#!/bin/bash

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
	qemu-send "change ide1-cd0 install-w311fwg.iso"
	qemu-send-string-de "d:"
	qemu-send-string-de "winsetup.bat"
	bogomips-sleep 41
	echo "starting installation..."
	qemu-send-key "ret"
	bogomips-sleep 74
	echo "confirming question to setup dos programs in windows..."
	qemu-send-key "ret"
	bogomips-sleep 8
	echo "waiting for reboot..."
	bogomips-sleep 11
	echo "copy tcpip driver..."
	qemu-send-string-de "mkdir c:\\drivers"
	qemu-send-string-de "mkdir c:\\drivers\\tcpip"
	qemu-send-string-de "copy d:\\drivers\\tcpip\\*.* c:\\drivers\\tcpip"
	bogomips-sleep 24
	echo "copy network driver..."
	qemu-send-string-de "mkdir c:\\drivers\\rtl8029"
	qemu-send-string-de "copy d:\\drivers\\rtl8029\\wfw311\\*.* c:\\drivers\\rtl8029"
	bogomips-sleep 2
	echo "unpacking tcpip driver..."
	qemu-send-string-de "cd c:\\drivers\\tcpip"
	qemu-send-string-de "tcp32b.exe"
	bogomips-sleep 7
	echo "running windows setup..."
	qemu-send-string-de "C:\\WINDOWS\\WIN.COM"
	bogomips-sleep 4
	qemu-send-key "w"
	qemu-send-key "ret"
	qemu-send-key "alt-o"
	qemu-send-key "down"
	qemu-send-key "ret"
	echo "installing network driver..."
	qemu-send-key "shift-tab"
	qemu-send-key "spc"
	qemu-send-key "shift-tab"
	qemu-send-key "down"
	qemu-send-key "ret"
	qemu-send-key "shift-tab"
	qemu-send-key "spc"
	qemu-send-key "tab"
	qemu-send-key "spc"
	qemu-send-key "ret"
	qemu-send-string-de "C:\\drivers\\rtl8029"
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "installing tcpip driver..."
	qemu-send-key "tab"
	qemu-send-key "tab"
	qemu-send-key "tab"
	qemu-send-key "spc"
	qemu-send-key "ret"
	qemu-send-string-de "C:\\drivers\\tcpip"
	qemu-send-key "ret"
	bogomips-sleep 8
	echo "closing windows setup..."
	qemu-send-key "tab"
	qemu-send-key "spc"
	qemu-send-key "spc"
	bogomips-sleep 1
	echo "entering workgroup name..."
	qemu-send-key "tab"
	qemu-send-string-de "WG"
	bogomips-sleep 10
	qemu-send-key "spc"
	qemu-send-key "tab"
	qemu-send-key "spc"
	qemu-send-key "spc"
	qemu-send-key "ret"
	qemu-send-key "ret"
	qemu-send-key "ret"
	echo "waiting for reboot..."	
	bogomips-sleep 20
	qemu-send-string-de "echo C:\\WINDOWS\\WIN.COM >> c:\autoexec.bat"
	bogomips-sleep 1
}

install-w311fwg-on-qemu-usage() {
	echo "install-w311wfg-on-qemu <WinInstallISO>" 1>&2
}
