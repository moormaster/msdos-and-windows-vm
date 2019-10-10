#!/bin/bash

. lib-qemu.sh

install-oak-cdromdriver-onto-disk() {
	imagefile="$1"

	win98bootdisk="$2"

	qemu-pipe-init
 
	qemu-system-i386 -fda ${win98bootdisk} -hda ${imagefile} -boot c -monitor pipe:qemu-monitor-pipe &

	# wait for DOS to fully boot
	sleep 8
	qemu-send-string-de "copy a:\\oakcdrom.sys c:\\"
	qemu-send-string-de "echo device=oakcdrom.sys /D:oemcd001 >> config.sys"
	qemu-send-string-de "echo LH C:\\DOS\\MSCDEX.EXE /D:oemcd001 /L:D >> autoexec.bat"

	sleep 3
	qemu-send "quit"

	qemu-pipe-destroy
}

usage() {
	echo "$0 <hdd image file> <win98 boot disk>"
}

if [ $# -lt 2 ]
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

install-oak-cdromdriver-onto-disk "$@"
