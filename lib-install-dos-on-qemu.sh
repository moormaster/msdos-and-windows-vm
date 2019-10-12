#!/bin/bash

. lib-qemu.sh
. lib-bogomips-sleep.sh

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

	qemu-send "change floppy0 ${dosdisk1}"
	qemu-send "boot_set a"
	qemu-send "system_reset"
	# wait for DOS installer to fully boot
	bogomips-sleep 8
	qemu-send-key "ret"
	qemu-send-key "ret"
	qemu-send-key "ret"
	# wait for installer to reboot
	bogomips-sleep 8

	# choose language
	qemu-send-key "up"
	qemu-send-key "up"
	qemu-send-key "ret"
	for ((i=0; i<13; i++))
	do
		qemu-send-key "up"
	done
	qemu-send-key "ret"

	# choose keyboard layout
	qemu-send-key "up"
	qemu-send-key "ret"
	for ((i=0; i<13; i++))
	do
		qemu-send-key "up"
	done
	qemu-send-key "ret"

	qemu-send-key "ret"
	qemu-send-key "ret"

	# wait for disk 1 to be installed
	bogomips-sleep 15
	qemu-send "change floppy0 ${dosdisk2}"
	qemu-send-key "ret"

	# wait for disk 2 to be installed
	bogomips-sleep 15
	qemu-send "change floppy0 ${dosdisk3}"
	qemu-send-key "ret"

	# wait for disk 3 to be installed
	bogomips-sleep 15

	# confirm final messages	
	qemu-send "eject floppy0"
	qemu-send-key "ret"
	qemu-send-key "ret"

	# wait for reboot to complete
	bogomips-sleep 8

	if [ -f "${dossuppdisk}" ]
	then
		qemu-send "change floppy0 ${dossuppdisk}"
		qemu-send-string-de "mkdir c:\\dossupp"
		qemu-send-string-de "copy a:\*.* c:\\dossupp"
		# wait copy to finish
		bogomips-sleep 15
	fi
}

install-dos-on-qemu-usage() {
	echo "install-dos-on-qemu <dos disk 1> <dos disk 2> <dos disk 3> [dos supplemental disk]" 1>&2
}
