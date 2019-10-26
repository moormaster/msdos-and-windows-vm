#!/bin/bash

. lib-bogomips-sleep.sh
. lib-qemu.sh

install-app-netscape-on-qemu() {
	isoimage="$1"

	if [ $# -lt 1 ]
	then
		install-app-netscape-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		install-app-netscape-on-qemu-usage
		return
	fi

	qemu-send "change ide1-cd0 $isoimage"
	echo "running windows..."
	qemu-send-string-de "C:\\WINDOWS\\WIN.COM"
	bogomips-sleep 20
	echo "installing netscape..."
	qemu-send-key "alt-f"
	qemu-send-key "r"
	qemu-send-string-de "d:\\apps\\netscape\\netscape.exe"
	bogomips-sleep 200
	echo "confirming installer..."
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "confirming installation directory..."
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 5
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "confirming installation begin..."
	qemu-send-key "ret"
	bogomips-sleep 130
	echo "denying to view readme..."
	qemu-send-key "n"
	bogomips-sleep 2
	echo "rebooting..."
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 20
}

install-app-netscape-on-qemu-usage() {
	echo "install-app-netscape-on-qemu <WinInstallISO>" 1>&2
}
