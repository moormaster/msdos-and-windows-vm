#!/bin/bash

. lib-bogomips-sleep.sh
. lib-qemu.sh

activate-w311fwg-settings-on-qemu() {
	isoimage="$1"

	if [ $# -lt 1 ]
	then
		activate-w311fwg-settings-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		activate-w311fwg-settings-on-qemu-usage
		return
	fi
	qemu-send "change ide1-cd0 $isoimage"
	echo "running windows setup..."
	qemu-send-string-de "cd \\windows"
	qemu-send-string-de "setup.exe"
	bogomips-sleep 1
	echo "activating svga driver..."
	for ((i=0;i<6;i++))
	do
		qemu-send-key "up"
	done
	qemu-send-key "ret"
	bogomips-sleep 1
	for ((i=0;i<3;i++))
	do
		qemu-send-key "down"
	done
	qemu-send-key "ret"

	echo "activating windows apm driver..."
	for ((i=0;i<7;i++))
	do
		qemu-send-key "up"
	done
	qemu-send-key "ret"
	bogomips-sleep 1
	for ((i=0;i<14;i++))
	do
		qemu-send-key "down"
	done
	qemu-send-key "ret"

	qemu-send-key "ret"
	qemu-send-key "ret"
	qemu-send-key "ret"
	bogomips-sleep 5
	echo "activating win.com..."
	qemu-send-string-de "echo C:\\WINDOWS\\WIN.COM >> c:\\autoexec.bat"
	bogomips-sleep 1
}

activate-w311fwg-settings-on-qemu-usage() {
	echo -e "usage:\n\tactivate-w311fwg-settings-on-qemu <WinInstallISO>" 1>&2
}
