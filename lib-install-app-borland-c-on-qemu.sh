. lib-bogomips-sleep.sh
. lib-qemu.sh

install-app-borland-c-on-qemu() {
	local isoimage="$1"

	if [ $# -lt 1 ]
	then
		install-app-borland-c-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		install-app-borland-c-on-qemu-usage
		return
	fi

	qemu-change-cdrom "$isoimage"
	echo "installing Borland C..."
	qemu-send-line-de "d:\\apps\\borlc\\install.bat"
	bogomips-sleep 55
	echo "confirming welcome message..."
	qemu-send-key "ret"
	bogomips-sleep 1.2
	echo "changing source drive"
	qemu-send-key "c"
	qemu-send-key "ret"
	bogomips-sleep 1.2
	qemu-send-key "ret"
	bogomips-sleep 1.2
	echo "confirming install..."
	qemu-send-key "ret"
	bogomips-sleep 1.2
	echo "confirming install location..."
	qemu-send-key "end"
	bogomips-sleep 1.2
	qemu-send-key "ret"
	bogomips-sleep 25
	echo "leaving installer..."
	qemu-send-key "ret"
	bogomips-sleep 1.2
	qemu-send-line-de "c:"
	qemu-send-line-de "cd \\"
	echo "setting FILES=20"
	qemu-send-line-de "echo FILES = 20 >> CONFIG.SYS"
	bogomips-sleep 1.2
	echo "adding TC to PATH"
	qemu-send-line-de "echo PATH C:\\WINDOWS;C:\\DOS;C:\\TC >> AUTOEXEC.BAT"
	bogomips-sleep 1.2
}

install-app-borland-c-on-qemu-usage() {
	echo -e "usage:\n\tinstall-app-borland-c-on-qemu <WinInstallISO>" 1>&2
}
