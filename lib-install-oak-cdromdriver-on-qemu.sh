#!/bin/bash

. lib-qemu.sh

install-oak-cdromdriver-on-qemu() {
	local win98bootdisk="$1"

	if [ $# -lt 1 ]
	then
		install-oak-cdromdriver-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 2>&1
		install-oak-cdromdriver-on-qemu-usage
		return
	fi

	qemu-send "change floppy0 ${win98bootdisk}"
	qemu-send-string-de "copy a:\\oakcdrom.sys c:\\"
	qemu-send-string-de "echo device=oakcdrom.sys /D:oemcd001 >> config.sys"
	qemu-send-string-de "echo LH C:\\DOS\\MSCDEX.EXE /D:oemcd001 /L:D >> autoexec.bat"
	sleep 10
}

install-oak-cdromdriver-on-qemu-usage() {
	echo "$0 <win98 boot disk>" 2>&1
}
