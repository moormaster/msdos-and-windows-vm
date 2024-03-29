. lib-bogomips-sleep.sh
. lib-qemu.sh

install-app-ie-on-qemu() {
	isoimage="$1"

	if [ $# -lt 1 ]
	then
		install-app-ie-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		install-app-ie-on-qemu-usage
		return
	fi

	qemu-change-cdrom "$isoimage"
	echo "extracting setup..."
	qemu-send-line-de "mkdir c:\\temp"
	qemu-send-line-de "mkdir c:\\temp\\ie"
	qemu-send-line-de "d:\\apps\\pkzip\\pkunzip d:\\apps\\ie\\ie5win31.exe c:\\temp\\ie"
	bogomips-sleep 60
	echo "installing ie..."
	qemu-send-line-de "c:\\windows\\win.com c:\\temp\\ie\\setup.exe /q"
	bogomips-sleep 145
	echo "skipping customization file..."
	qemu-send-key "tab"
	qemu-send-key "tab"
	qemu-send-key "tab"
	qemu-send-key "spc"
	bogomips-sleep 5
	echo "rebooting..."
	qemu-send-key "spc"
	bogomips-sleep 20
	qemu-send-line-de "c:\\windows\\win.com"
	bogomips-sleep 70
	echo "setting time zone..."
	for ((i=0;i<18;i++))
	do
		qemu-send-key "down"
	done
	qemu-send-key "ret"
	bogomips-sleep 5
	echo "open program manager..."
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-key "alt-f4"
	bogomips-sleep 1
	qemu-send-key "spc"
	bogomips-sleep 5
}

install-app-ie-on-qemu-usage() {
	echo -e "usage:\n\tinstall-app-ie-on-qemu <WinInstallISO>" 1>&2
}
