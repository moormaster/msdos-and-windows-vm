. lib-bogomips-sleep.sh
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
		echo "file not found: $1" 1>&2
		install-oak-cdromdriver-on-qemu-usage
		return
	fi

	echo "inserting win98 boot disk and installing cdrom driver..."
	qemu-send "change floppy0 ${win98bootdisk}"
	qemu-send-line-de "copy a:\\oakcdrom.sys c:\\"
	qemu-send-line-de "echo DEVICE=OAKCDROM.SYS /D:${CONFIG_OEMCD}>> c:\\config.sys"
	qemu-send-line-de "echo LH C:\\DOS\\MSCDEX.EXE /D:${CONFIG_OEMCD} /L:D >> c:\\autoexec.bat"
	bogomips-sleep 2
	qemu-send "boot_set c"
	qemu-send "system_reset"
	echo "rebooting..."
	bogomips-sleep 8
}

install-oak-cdromdriver-on-qemu-usage() {
	echo -e "usage:\n\tinstall-oak-cdromdriver-on-qemu <win98 boot disk>" 1>&2
}
