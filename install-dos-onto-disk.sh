#!/bin/bash

qemu-send-string-en-us() {
	[ -p qemu-monitor-pipe.in ] && (
		line=$1
		echo "$line" | 
		sed "s/./sendkey \0\n/g" | 
		sed "s/sendkey \([A-Z]\)/sendkey shift-\L\1/g" |
		sed "s/sendkey  /sendkey spc/g" | 
		sed "s/sendkey \//sendkey slash/g" |
		sed "s/sendkey \*/sendkey asterisk/g" |
		sed "s/sendkey \./sendkey dot/g" |
		sed "s/sendkey :/sendkey shift-semicolon/g" |
		sed "s/sendkey \\\\/sendkey backslash/g" >> qemu-monitor-pipe.in
		qemu-send-key "ret"
	)
}

qemu-send-string-de() {
	[ -p qemu-monitor-pipe.in ] && (
		line=$1
		echo "$line" | 
		sed "y/yz/zy/" | sed "y/YZ/ZY/" |
		sed "s/./sendkey \0\n/g" | 
		sed "s/sendkey \([A-Z]\)/sendkey shift-\L\1/g" |
		sed "s/sendkey  /sendkey spc/g" | 
		sed "s/sendkey \//sendkey shift-7/g" |
		sed "s/sendkey \*/sendkey shift-bracket_right/g" |
		sed "s/sendkey \./sendkey dot/g" |
		sed "s/sendkey :/sendkey shift-dot/g" |
		sed "s/sendkey \\\\/sendkey alt_r-minus/g" >> qemu-monitor-pipe.in
		qemu-send-key "ret"
	)
}

qemu-send-key() {
	key="$1"
	qemu-send "sendkey $key"
}

qemu-send() {
	[ -p qemu-monitor-pipe.in ] && (
		line=$1
		echo "$1" >> qemu-monitor-pipe.in
		sleep 0.2
	)
}

install_dos_onto_disk() {
	imagefile="$1"

	dosdisk1="$2"
	dosdisk2="$3"
	dosdisk3="$4"
	dossuppdisk="$5"

 
	mkfifo qemu-monitor-pipe.in qemu-monitor-pipe.out
	qemu-system-i386 -fda ${dosdisk1} -hda ${imagefile} -boot a -monitor pipe:qemu-monitor-pipe &

	# wait for DOS installer to fully boot
	sleep 5
	qemu-send-key "ret"
	qemu-send-key "ret"
	qemu-send-key "ret"
	# wait for installer to reboot
	sleep 5

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
	sleep 5
	qemu-send "change floppy0 ${dosdisk2}"
	qemu-send-key "ret"

	# wait for disk 2 to be installed
	sleep 5
	qemu-send "change floppy0 ${dosdisk3}"
	qemu-send-key "ret"

	# wait for disk 3 to be installed
	sleep 5

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
		sleep 2
	fi
	qemu-send "quit"

	# wait for qemu to close
	wait

	rm qemu-monitor-pipe.in qemu-monitor-pipe.out
}

usage() {
	echo "$0 <hdd image file> <dos disk 1> <dos disk 2> <dos disk 3> [dos supplemental disk]"
}

if [ $# -lt 4 ]
then
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

install_dos_onto_disk "$@"
