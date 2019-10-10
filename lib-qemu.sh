#!/bin/bash

qemu-pipe-init() {
	mkfifo qemu-monitor-pipe.in qemu-monitor-pipe.out
}

qemu-pipe-destroy() {
	rm qemu-monitor-pipe.in qemu-monitor-pipe.out
}

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
