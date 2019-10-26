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
	echo "copy tcpip driver..."
	qemu-send-string-de "mkdir c:\\drivers"
	qemu-send-string-de "mkdir c:\\drivers\\tcpip"
	qemu-send-string-de "copy d:\\drivers\\tcpip\\*.* c:\\drivers\\tcpip"
	bogomips-sleep 43
	echo "copy network driver..."
	qemu-send-string-de "mkdir c:\\drivers\\rtl8029"
	qemu-send-string-de "copy d:\\drivers\\rtl8029\\wfw311\\*.* c:\\drivers\\rtl8029"
	bogomips-sleep 2
	echo "copy vga driver..."
	qemu-send-string-de "mkdir c:\\drivers\\svga"
	qemu-send-string-de "copy d:\\drivers\\svga\\*.* c:\\drivers\\svga"
	bogomips-sleep 2
	echo "unpacking tcpip driver..."
	qemu-send-string-de "cd c:\\drivers\\tcpip"
	qemu-send-string-de "tcp32b.exe"
	bogomips-sleep 7
	echo "patching svga driver..."
	qemu-send-string-de "mkdir c:\\windows"
	qemu-send-string-de "mkdir c:\\windows\\system"
	qemu-send-string-de "expand d:\\winsetup\\svga256.dr_ c:\\windows\\system\\svga256.drv"
	bogomips-sleep 2
	qemu-send-string-de "copy c:\\drivers\\svga\\vgapatch.com c:\\windows\\system"
	qemu-send-string-de "cd \\windows\\system"
	qemu-send-string-de "vgapatch.com p"
	bogomips-sleep 1
	qemu-send-string-de "cd \\"
	echo "running windows setup..."
	qemu-send-string-de "d:"
	qemu-send-string-de "cd WINSETUP"
	qemu-send-string-de "winsetup.bat"
	bogomips-sleep 2
	echo "starting installation..."
	qemu-send-key "ret"
	bogomips-sleep 75
	echo "confirming question to setup dos programs in windows..."
	qemu-send-key "ret"
	bogomips-sleep 2
	echo "denying question to setup tcpip tools..."
	qemu-send-key "tab"
	qemu-send-key "tab"
	qemu-send-key "spc"
	echo "rebooting..."
	bogomips-sleep 19
	echo "running windows..."
	qemu-send-string-de "C:\\WINDOWS\\WIN.COM"
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
	qemu-send-string-de "C:\\drivers\\rtl8029"
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
	qemu-send-string-de "C:\\drivers\\tcpip"
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
	qemu-send-string-de "WG"
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
	qemu-send-string-de "C:\\WINDOWS\\WIN.COM"
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
	echo "install-w311fwg-on-qemu <WinInstallISO>" 1>&2
}
