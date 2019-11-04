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
	qemu-send "change ide1-cd0 $isoimage"
	echo "copy drivers..."
	qemu-send-string-de "d:\\drivers\\drivers.bat"
	bogomips-sleep 61
	echo "preparing drivers..."
	qemu-send-string-de "c:\\drivers\\win311\\drivers.bat"
	bogomips-sleep 7
	echo "preparing windows setup..."
	qemu-send-string-de "xcopy d:\\winsetup c:\\winsetup\\"
	bogomips-sleep 56
	echo "running windows setup..."
	qemu-send-string-de "d:"
	qemu-send-string-de "cd winsetup"
	qemu-send-string-de "winsetup.bat"
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
	echo "running windows..."
	qemu-send-string-de "c:\\windows\\win.com"
	bogomips-sleep 4
	echo "running windows setup..."
	qemu-send-key "w"
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "running network setup..."
	qemu-send-key "alt-o"
	qemu-send-key "down"
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "installing network driver..."
	qemu-send-key "shift-tab"
	qemu-send-key "spc"
	bogomips-sleep 1
	qemu-send-key "shift-tab"
	qemu-send-key "down"
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-key "shift-tab"
	qemu-send-key "spc"
	bogomips-sleep 1
	qemu-send-key "tab"
	qemu-send-key "spc"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-string-de "c:\\drivers\\win311\\rtl8029\\wfw311"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "installing tcpip driver..."
	qemu-send-key "tab"
	qemu-send-key "tab"
	qemu-send-key "tab"
	qemu-send-key "spc"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-string-de "c:\\drivers\\win311\\tcpip"
	qemu-send-key "ret"
	bogomips-sleep 8
	echo "closing windows setup..."
	qemu-send-key "tab"
	qemu-send-key "spc"
	bogomips-sleep 1
	qemu-send-key "spc"
	bogomips-sleep 1
	echo "entering workgroup name..."
	qemu-send-key "tab"
	qemu-send-string-de "wg"
	bogomips-sleep 30
	echo "enabling dhcp..."
	qemu-send-key "spc"
	bogomips-sleep 1
	qemu-send-key "tab"
	qemu-send-key "spc"
	bogomips-sleep 1
	qemu-send-key "spc"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "rebooting..."
	qemu-send-key "ret"
	bogomips-sleep 20
	echo "running windows..."
	qemu-send-string-de "c:\\windows\\win.com"
	bogomips-sleep 20
	echo "setting empty password..."
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-key "alt-f4"
	bogomips-sleep 1
	qemu-send-key "spc"
	bogomips-sleep 5
}

install-w311fwg-on-qemu-usage() {
	echo -e "usage:\n\tinstall-w311fwg-on-qemu <WinInstallISO>" 1>&2
}
