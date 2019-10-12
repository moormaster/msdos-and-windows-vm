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
	bogomips-sleep 45
	echo "starting installation..."
	qemu-send-key "ret"
	bogomips-sleep 72
	echo "confirming question to setup dos programs in windows..."
	qemu-send-key "ret"
	bogomips-sleep 13
	echo "waiting for reboot..."
	bogomips-sleep 8
}

install-w311fwg-on-qemu-usage() {
	echo "install-w311wfg-on-qemu <WinInstallISO>" 1>&2
}
