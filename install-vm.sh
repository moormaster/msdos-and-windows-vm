#!/bin/bash

. lib-qemu.sh
. lib-install-dos-on-qemu.sh
. lib-install-oak-cdromdriver-on-qemu.sh

install-vm() {
	imagefile="$1"

	shift 1
	qemuargs=("$@")
	
	QEMU_PIPE=$( qemu-pipe-init )

	qemu-system-i386 -enable-kvm -hda "${imagefile}" -fda "" -monitor "pipe:${QEMU_PIPE}" "${qemuargs[@]}" &

	# wait for qemu to initialize
	sleep 5

	echo installing dos...
	install-dos-on-qemu DosDisk1.img DosDisk2.img DosDisk3.img Suppdisk.img

	echo installing cdrom driver...
	install-oak-cdromdriver-on-qemu Win98BootDisk.img

	qemu-send "quit"
	# wait for qemu to close
	wait

	qemu-pipe-destroy ${QEMU_PIPE}
}

usage() {
	echo "$0 <HardDisk image>" 2>&1
}

if [ $# -lt 1 ]
then
	usage
	exit
fi

install-vm "$@"
