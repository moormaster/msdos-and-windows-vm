#!/bin/bash

. lib-bogomips-sleep.sh
. lib-qemu.sh

install-dos-on-qemu() {
	local dosdisk1="$1"
	local dosdisk2="$2"
	local dosdisk3="$3"
	local dossuppdisk="$4"

	if [ $# -lt 3 ]
	then
		install-dos-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		install-dos-on-qemu-usage
		return
	fi

	if ! [ -f "$2" ]
	then
		echo "file not found: $2" 1>&2

		install-dos-on-qemu-usage
		return
	fi

	if ! [ -f "$3" ]
	then
		echo "file not found: $3" 1>&2

		install-dos-on-qemu-usage
		return
	fi

	if [ "$4" != "" ] && ! [ -f "$4" ]
	then
		echo "file not found: $4" 1>&2
		install-dos-on-qemu-usage
		return
	fi

	echo "inserting dos disk 1 and reboot..."
	qemu-send "change floppy0 ${dosdisk1}"
	qemu-send "boot_set a"
	qemu-send "system_reset"
	bogomips-sleep 6
	echo "confirming messages saying the disk needs to be partitioned..."
	qemu-send-key "ret"
	bogomips-sleep 0.1
	qemu-send-key "ret"
	bogomips-sleep 0.1
	qemu-send-key "ret"
	bogomips-sleep 0.1
	echo "waiting for reboot..."
	bogomips-sleep 6

	echo "choosing language..."
	qemu-send-key "up"
	qemu-send-key "up"
	qemu-send-key "ret"
	bogomips-sleep 0.1
	for ((i=0; i<13; i++))
	do
		qemu-send-key "up"
	done
	qemu-send-key "ret"
	bogomips-sleep 0.1

	echo "choosing keyboard layout..."
	qemu-send-key "up"
	qemu-send-key "ret"
	bogomips-sleep 0.1
	for ((i=0; i<13; i++))
	do
		qemu-send-key "up"
	done
	qemu-send-key "ret"
	bogomips-sleep 0.1

	echo "starting installation..."
	qemu-send-key "ret"
	bogomips-sleep 0.1
	qemu-send-key "ret"
	bogomips-sleep 8

	echo "inserting and installing disk 2..."
	qemu-send "change floppy0 ${dosdisk2}"
	qemu-send-key "ret"
	bogomips-sleep 11

	echo "inserting and installing disk 3..."
	qemu-send "change floppy0 ${dosdisk3}"
	qemu-send-key "ret"
	bogomips-sleep 11

	echo "ejecting floppy and reboot..."
	qemu-send "eject floppy0"
	qemu-send-key "ret"
	bogomips-sleep 0.1
	qemu-send-key "ret"
	bogomips-sleep 6

	if [ -f "${dossuppdisk}" ]
	then
		echo "inserting an copying supplemental disk to be copied..."
		qemu-send "change floppy0 ${dossuppdisk}"
		qemu-send-string-de "a:"
		qemu-send-string-de "setup.bat c:\\dos"
		qemu-send-string-de "a"
		bogomips-sleep 1
		qemu-send-key "f5"
		qemu-send-string-de "y"
		bogomips-sleep 2
		qemu-send-string-de "y"
		# wait copy to finish
		bogomips-sleep 5
		qemu-send-string-de "c:"
	fi
}

install-dos-on-qemu-usage() {
	echo "install-dos-on-qemu <dos disk 1> <dos disk 2> <dos disk 3> [dos supplemental disk]" 1>&2
}
