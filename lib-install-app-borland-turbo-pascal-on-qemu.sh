. lib-bogomips-sleep.sh
. lib-qemu.sh

install-app-borland-turbo-pascal-on-qemu() {
	isoimage="$1"

	if [ $# -lt 1 ]
	then
		install-app-borland-turbo-pascal-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		install-app-borland-turbo-pascal-on-qemu-usage
		return
	fi

	qemu-change-cdrom "$isoimage"
	echo "installing Borland Turbo Pascal..."
	qemu-send-line-de "d:\\apps\\borltp\\install.bat"
	bogomips-sleep 20
	echo "confirming welcome message..."
	qemu-send-key "ret"
	bogomips-sleep 1.2
	echo "confirming source drive"
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
	bogomips-sleep 10
	echo "leaving installer..."
	qemu-send-key "ret"
	bogomips-sleep 1.2
	echo "leaving readme"
	qemu-send-key "esc"
	bogomips-sleep 1.2
	qemu-send-line-de "c:"
	qemu-send-line-de "cd \\"
	echo "setting FILES=20"
	qemu-send-line-de "echo FILES = 20 >> CONFIG.SYS"
	bogomips-sleep 1.2
	echo "adding TP\\BIN to PATH"
	qemu-send-line-de "echo PATH C:\\WINDOWS;C:\\DOS;C:\\TC;C:\\TC\\BIN;C:\\TP\\BIN >> AUTOEXEC.BAT"
	bogomips-sleep 1.2
}

install-app-borland-turbo-pascal-on-qemu-usage() {
	echo -e "usage:\n\tinstall-app-borland-turbo-pascal-on-qemu <WinInstallISO>" 1>&2
}
