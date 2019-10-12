#!/bin/bash

. lib-qemu.sh
. lib-install-dos-on-qemu.sh
. lib-install-oak-cdromdriver-on-qemu.sh
. lib-install-w311fwg-on-qemu.sh

install-vm() {
	hddimage="$1"
	isoimage="$2"

	shift 2
	qemuargs=("$@")
	
	QEMU_PIPE=$( qemu-pipe-init )

	qemu-system-i386 -enable-kvm -hda "${hddimage}" -fda "" -cdrom "" -monitor "pipe:${QEMU_PIPE}" "${qemuargs[@]}" &

	# wait for qemu to initialize
	sleep 5

	echo installing dos...
	install-dos-on-qemu DosDisk1.img DosDisk2.img DosDisk3.img Suppdisk.img

	echo installing cdrom driver...
	install-oak-cdromdriver-on-qemu Win98BootDisk.img

	echo installing windows 3.11 for workgroups
	install-w311fwg-on-qemu "$isoimage"

	qemu-send "quit"
	# wait for qemu to close
	wait

	qemu-pipe-destroy ${QEMU_PIPE}
}

install-vm-usage() {
	echo "$0 <HardDisk image> <Windows 3.11 install iso>" 2>&1
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
