#!/bin/bash

. lib-bogomips-sleep.sh

qemu-pipe-init() {
	[ "$1" != "" ] && QEMU_PIPE="$1" || QEMU_PIPE=qemu-monitor-pipe

	mkfifo "${QEMU_PIPE}.in" "${QEMU_PIPE}.out"

	echo ${QEMU_PIPE}
}

qemu-pipe-destroy() {
	local pipename="$1"
	[ "$pipename" == "" ] && pipename=${QEMU_PIPE}

	[ -p "${pipename}.in" ] && rm "${pipename}.in"
	[ -p "${pipename}.out" ] && rm "${pipename}.out"
}

qemu-send-string-en-us() {
	[ -p "${QEMU_PIPE}.in" ] && (
		local line=$1
		echo "$line" | 
		sed "s/./sendkey \0\n/g" | 
		sed "s/sendkey \([A-Z]\)/sendkey shift-\L\1/g" |
		sed "s/sendkey  /sendkey spc/g" | 
		sed "s/sendkey \//sendkey slash/g" |
		sed "s/sendkey \*/sendkey asterisk/g" |
		sed "s/sendkey \./sendkey dot/g" |
		sed "s/sendkey :/sendkey shift-semicolon/g" |
		sed "s/sendkey \\\\/sendkey backslash/g" |
		sed "s/sendkey =/sendkey equal/g" |
		sed "s/sendkey </sendkey shift-comma/g" |
		sed "s/sendkey >/sendkey shift-dot/g" | while read line
		do
			qemu-send "$line"
		done
		qemu-send-key "ret"
	)
}

qemu-send-string-de() {
	[ -p "${QEMU_PIPE}.in" ] && (
		local line=$1
		echo "$line" | 
		sed "y/yz/zy/" | sed "y/YZ/ZY/" |
		sed "s/./sendkey \0\n/g" | 
		sed "s/sendkey \([A-Z]\)/sendkey shift-\L\1/g" |
		sed "s/sendkey  /sendkey spc/g" | 
		sed "s/sendkey \//sendkey shift-7/g" |
		sed "s/sendkey \*/sendkey shift-bracket_right/g" |
		sed "s/sendkey \./sendkey dot/g" |
		sed "s/sendkey :/sendkey shift-dot/g" |
		sed "s/sendkey \\\\/sendkey alt_r-minus/g" |
		sed "s/sendkey =/sendkey shift-0/g" |
		sed "s/sendkey </sendkey less/g" |
		sed "s/sendkey >/sendkey shift-less/g" | while read line
		do
			qemu-send "$line"
		done
		qemu-send-key "ret"
	)
}

qemu-send-key() {
	local key="$1"
	qemu-send "sendkey $key"
}

qemu-send() {
	[ -p "${QEMU_PIPE}.in" ] && (
		local line=$1
		echo "$1" >> "${QEMU_PIPE}.in"
		bogomips-sleep 0.2
	)
}
