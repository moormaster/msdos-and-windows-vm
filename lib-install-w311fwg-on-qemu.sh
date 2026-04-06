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
	bogomips-sleep 25
	echo "preparing drivers..."
	qemu-send-line-de "c:\\drivers\\win311\\drivers.bat"
	bogomips-sleep 9
	echo "preparing windows setup..."
	qemu-send-line-de "xcopy d:\\winsetup c:\\winsetup\\"
	bogomips-sleep 105
	echo "running windows setup..."
	qemu-send-line-de "c:"
	qemu-send-line-de "cd winsetup"
	qemu-send-line-de "winsetup.bat"
	bogomips-sleep 5
	echo "starting installation..."
	qemu-send-key "ret"
	bogomips-sleep 185
	echo "confirming question to setup edit.com in windows..."
	qemu-send-key "ret"
	bogomips-sleep 3
	echo "denying question to setup c:\\temp\\borlc\\make.exe cmd..."
	qemu-send-key "esc"
	bogomips-sleep 3
	echo "denying question to setup c:\\tc\\make.exe cmd..."
	qemu-send-key "esc"
	bogomips-sleep 3
	echo "denying question to setup tcpip tools..."
	qemu-send-key "esc"
	bogomips-sleep 3
	echo "denying question to setup d:\\apps\\borlc\\make.exe cmd..."
	qemu-send-key "esc"
	echo "rebooting..."
	bogomips-sleep 29
}

install-w311fwg-on-qemu-usage() {
	echo -e "usage:\n\tinstall-w311fwg-on-qemu <WinInstallISO>" 1>&2
}
