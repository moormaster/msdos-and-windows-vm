#!/usr/bin/env bash

. lib-qemu.sh
. lib-bogomips-sleep.sh
. lib-install-dos-on-qemu.sh
. lib-activate-dos-powermanager.sh
. lib-activate-w311fwg-networklogon-on-qemu.sh
. lib-activate-w311fwg-networkdriver-on-qemu.sh
. lib-install-oak-cdromdriver-on-qemu.sh
. lib-install-w311fwg-on-qemu.sh
. lib-install-app-ie-on-qemu.sh
. lib-install-app-nc-on-qemu.sh
. lib-install-app-msoffice-on-qemu.sh
. lib-install-app-netscape-on-qemu.sh
. lib-install-app-pkzip-on-qemu.sh
. lib-activate-w311fwg-settings-on-qemu.sh

install-vm() {
	hddimage="$1"
	isoimage="$2"

	shift 2
	qemuargs=("$@")
	
	[ "${CONFIG_OEMCD}" == "" ] && CONFIG_OEMCD="OEMCD"
	[ "${CONFIG_NETWORK}" == "" ] && CONFIG_NETWORK="rtl8029"
	[ "${CONFIG_COMPUTERNAME}" == "" ] && CONFIG_COMPUTERNAME="JohnQ.Pu"
	[ "${CONFIG_WORKGROUP}" == "" ] && CONFIG_WORKGROUP="wg"
	[ "${CONFIG_USERNAME}" == "" ] && CONFIG_USERNAME="JohnQ.Pu"
	[ "${CONFIG_PASSWORD}" == "" ] && CONFIG_PASSWORD=""

	echo "CONFIG_OEMCD=${CONFIG_OEMCD}"
	echo "CONFIG_NETWORK=${CONFIG_NETWORK}"
	echo "CONFIG_COMPUTERNAME=${CONFIG_COMPUTERNAME}"
	echo "CONFIG_WORKGROUP=${CONFIG_WORKGROUP}"
	echo "CONFIG_USERNAME=${CONFIG_USERNAME}"
	echo "CONFIG_PASSWORD=${CONFIG_PASSWORD}"

	case "${CONFIG_NETWORK}" in
		"rtl8029")
			QEMU_NETWORK="-net user -net nic,model=ne2k_pci"
			;;
		"amdpcnet")
			QEMU_NETWORK="-net user -net nic,model=pcnet"
			;;
		"none")
			QEMU_NETWORK=""
			;;
	esac

	QEMU_PIPE=$( qemu-pipe-init )
	QEMU_EXEC=( qemu-system-i386 -hda "${hddimage}" -fda "" -cdrom "" ${QEMU_NETWORK} "${qemuargs[@]}" ${QEMU_ARGS} )

	rm "${QEMU_PIPE}.stop"

	case "$( uname )" in
		Linux*)
			"${QEMU_EXEC[@]}" -monitor "pipe:${QEMU_PIPE}" &
			;;
		CYGWIN*)
			( while ! [ -f "${QEMU_PIPE}.stop" ]; do cat "${QEMU_PIPE}.in"; done ) | "${QEMU_EXEC[@]}" -monitor stdio > "${QEMU_PIPE}.out" &
			;;
	esac

	(
	        # read out pipe to prevent blocking
	        cat "${QEMU_PIPE}.out" > /dev/null &

		# wait for qemu to initialize
		bogomips-sleep 1

		echo installing dos...
		install-dos-on-qemu DosDisk1.img DosDisk2.img DosDisk3.img Suppdisk.img

		echo installing cdrom driver...
		install-oak-cdromdriver-on-qemu Win98BootDisk.img

		if [ "$NOAPPS" != "" ] && [ "$NOAPPS" != "0" ]
		then
			echo "skipping installation of dos apps due to NOAPPS=\"$NOAPPS\""
		else
			echo installing dos apps...
			install-app-nc-on-qemu "$isoimage"
			install-app-pkzip-on-qemu "$isoimage"
		fi

		echo installing windows 3.11 for workgroups...
		install-w311fwg-on-qemu "$isoimage"

		if [ "$NOAPPS" != "" ] && [ "$NOAPPS" != "0" ]
		then
			echo "skipping installation of apps due to NOAPPS=\"$NOAPPS\""
		else
			echo installing apps...
			install-app-msoffice-on-qemu "$isoimage"
		fi

		echo "activating windows 3.11 for workgroups network driver..."
		if [ "${CONFIG_NETWORK}" == "none" ]
		then
			echo "skipping network driver installation due to NETWORK=\"${CONFIG_NETWORK}\""
		else
			activate-w311fwg-networklogon-on-qemu
			activate-w311fwg-networkdriver-on-qemu
		fi

		if [ "${CONFIG_NETWORK}" == "none" ]
		then
			echo "skipping installation of browsers due to NETWORK=\"${CONFIG_NETWORK}\""
		else
			if [ "$NOAPPS" != "" ] && [ "$NOAPPS" != "0" ]
			then
				echo "skipping installation of browsers due to NOAPPS=\"$NOAPPS\""
			else
				install-app-netscape-on-qemu "$isoimage"
				install-app-ie-on-qemu "$isoimage"
			fi
		fi

		echo "activating windows 3.11 for workgroups graphics and powermanagement drivers..."
		activate-w311fwg-settings-on-qemu "$isoimage"

		echo activating power management for dos...
		activate-dos-powermanager

		touch "${QEMU_PIPE}.stop"

		qemu-send "quit"
	) | while read line
	do
		echo -e "$(date +%H:%M:%S) $line"
	done
	# wait for qemu to close
	wait

	rm "${QEMU_PIPE}.stop"

	qemu-pipe-destroy ${QEMU_PIPE}
}

install-vm-usage() {
	echo -e "usage:\n\t$0 <HardDisk image> <Windows 3.11 install iso>" 2>&1
}

if [ $# -lt 1 ]
then
	install-vm-usage
	exit
fi

if ! [ -f "$1" ]
then
	echo "file not found: $1" 1>&2
	install-vm-usage
	exit
fi

if ! [ -f "$2" ]
then
	echo "file not found: $2" 1>&2
	install-vm-usage
	exit
fi

install-vm "$@"
