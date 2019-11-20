. lib-bogomips-sleep.sh
. lib-qemu.sh

install-w311fwg-on-qemu() {
	isoimage="$1"

	if [ $# -lt 1 ]
	then
		install-w311fwg-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		install-w311fwg-on-qemu-usage
		return
	fi

	echo "starting windows 3.11 for workgroups setup..."
	qemu-change-cdrom "$isoimage"
	echo "copy drivers..."
	qemu-send-line-de "d:\\drivers\\drivers.bat"
	bogomips-sleep 61
	echo "preparing drivers..."
	qemu-send-line-de "c:\\drivers\\win311\\drivers.bat"
	bogomips-sleep 7
	echo "preparing windows setup..."
	qemu-send-line-de "xcopy d:\\winsetup c:\\winsetup\\"
	bogomips-sleep 105
	echo "running windows setup..."
	qemu-send-line-de "c:"
	qemu-send-line-de "cd winsetup"
	qemu-send-line-de "winsetup.bat"
	bogomips-sleep 4
	echo "starting installation..."
	qemu-send-key "ret"
	bogomips-sleep 205
	echo "confirming question to setup dos programs in windows..."
	qemu-send-key "ret"
	bogomips-sleep 2
	echo "denying question to setup tcpip tools..."
	qemu-send-key "tab"
	qemu-send-key "tab"
	qemu-send-key "spc"
	echo "rebooting..."
	bogomips-sleep 24
}

install-w311fwg-on-qemu-usage() {
	echo -e "usage:\n\tinstall-w311fwg-on-qemu <WinInstallISO>" 1>&2
}
