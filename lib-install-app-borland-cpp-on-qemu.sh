. lib-bogomips-sleep.sh
. lib-qemu.sh

install-app-borland-cpp-on-qemu() {
	isoimage="$1"

	if [ $# -lt 1 ]
	then
		install-app-borland-cpp-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		install-app-borland-cpp-on-qemu-usage
		return
	fi

	qemu-change-cdrom "$isoimage"
	echo "installing Borland C++..."
	qemu-send-line-de "d:\\apps\\borlcpp\\install.bat"
	bogomips-sleep 5
	echo "confirming welcome message..."
	qemu-send-key "ret"
	bogomips-sleep 1.2
	echo "changing source drive"
	qemu-send-key "c"
	qemu-send-key "ret"
	bogomips-sleep 1.2
	qemu-send-key "ret"
	bogomips-sleep 1.2
	echo "confirming install location..."
	qemu-send-key "end"
	bogomips-sleep 1.2
	qemu-send-key "ret"
	bogomips-sleep 15
	echo "leaving installer..."
	qemu-send-key "ret"
	bogomips-sleep 1.2
	echo "leaving readme file"
	qemu-send-key "esc"
	bogomips-sleep 1.2
	qemu-send-line-de "c:"
	qemu-send-line-de "cd \\"
	echo "setting FILES=20"
	qemu-send-line-de "echo FILES = 20 >> CONFIG.SYS"
	bogomips-sleep 1.2
	echo "adding TC\\BIN to PATH"
	qemu-send-line-de "echo PATH C:\\WINDOWS;C:\\DOS;C:\\TC;C:\\TC\\BIN >> AUTOEXEC.BAT"
	bogomips-sleep 1.2
}

install-app-borland-cpp-on-qemu-usage() {
	echo -e "usage:\n\tinstall-app-borland-cpp-on-qemu <WinInstallISO>" 1>&2
}
