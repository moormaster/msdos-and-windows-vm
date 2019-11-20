. lib-bogomips-sleep.sh
. lib-qemu.sh

install-app-nc-on-qemu() {
	isoimage="$1"

	if [ $# -lt 1 ]
	then
		install-app-nc-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		install-app-nc-on-qemu-usage
		return
	fi

	qemu-change-cdrom "$isoimage"
	echo "installing nc..."
	qemu-send-line-de "d:\\apps\\nc\\install.bat"
	bogomips-sleep 50
	echo "confirming color install..."
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "confirming welcome message..."
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "confirming full install..."
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "confirming install location..."
	qemu-send-key "ret"
	bogomips-sleep 15
	echo "leaving installer..."
	qemu-send-key "x"
	bogomips-sleep 1
	qemu-send-line-de "c:"
	qemu-send-line-de "cd \\"
}

install-app-nc-on-qemu-usage() {
	echo -e "usage:\n\tinstall-app-nc-on-qemu <WinInstallISO>" 1>&2
}
