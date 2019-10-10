#!/bin/bash

. lib-qemu.sh

install-dos-onto-disk() {
	imagefile="$1"

	dosdisk1="$2"
	dosdisk2="$3"
	dosdisk3="$4"
	dossuppdisk="$5"

	qemu-pipe-init
 
	qemu-system-i386 -enable-kvm -fda ${dosdisk1} -hda ${imagefile} -boot a -monitor pipe:qemu-monitor-pipe &

	# wait for DOS installer to fully boot
	sleep 8
	qemu-send-key "ret"
	qemu-send-key "ret"
	qemu-send-key "ret"
	# wait for installer to reboot
	sleep 8

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
	sleep 10
	qemu-send "change floppy0 ${dosdisk2}"
	qemu-send-key "ret"

	# wait for disk 2 to be installed
	sleep 10
	qemu-send "change floppy0 ${dosdisk3}"
	qemu-send-key "ret"

	# wait for disk 3 to be installed
	sleep 10

	# confirm final messages	
	qemu-send "eject floppy0"
	qemu-send-key "ret"
	qemu-send-key "ret"

	# wait for reboot to complete
	sleep 8

	if [ -f "${dossuppdisk}" ]
	then
		qemu-send "change floppy0 ${dossuppdisk}"
		qemu-send-string-de "mkdir c:\\dossupp"
		qemu-send-string-de "copy a:\*.* c:\\dossupp"
		# wait copy to finish
		sleep 10
	fi
	qemu-send "quit"

	# wait for qemu to close
	wait

	qemu-pipe-destroy
}

usage() {
	echo "$0 <hdd image file> <dos disk 1> <dos disk 2> <dos disk 3> [dos supplemental disk]"
}

if [ $# -lt 4 ]
then
	usage
	exit
fi

if ! [ -f "$1" ]
then
	echo "file not found: $1"
	usage
	exit
fi

if ! [ -f "$2" ]
then
	echo "file not found: $2"
	usage
	exit
fi

if ! [ -f "$3" ]
then
	echo "file not found: $3"
	usage
	exit
fi

if ! [ -f "$4" ]
then
	echo "file not found: $4"
	usage
	exit
fi

if [ "$5" != "" ] && ! [ -f "$5" ]
then
	echo "file not found: $5"
	usage
	exit
fi

install-dos-onto-disk "$@"
