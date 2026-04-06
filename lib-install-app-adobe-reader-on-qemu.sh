. lib-bogomips-sleep.sh
. lib-qemu.sh

install-app-adobe-reader-on-qemu() {
	isoimage="$1"

	if [ $# -lt 1 ]
	then
		install-app-adobe-reader-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		install-app-adobe-reader-on-qemu-usage
		return
	fi

	qemu-change-cdrom "$isoimage"
	echo "copying setup..."
	echo "starting windows..."
	qemu-send-line-de "c:\\windows\\win.com"
	bogomips-sleep 10
	echo "installing adobe reader..."
	qemu-send-key "alt-f"
	qemu-send-key "r"
	qemu-send-line-de "d:\\apps\\adoberea\\rs16e301.exe"
	bogomips-sleep 25
	echo "confirming install..."
	qemu-send-key "ret"
	bogomips-sleep 55
	echo "confirming welcome dialog..."
	qemu-send-key "ret"
	bogomips-sleep 3
	echo "confirming license..."
	qemu-send-key "ret"
	bogomips-sleep 5
	echo "confirming install location..."
	qemu-send-key "ret"
	bogomips-sleep 70
	echo "skip to display readme..."
	qemu-send-key "spc"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "confirm install end..."
	qemu-send-key "ret"
	bogomips-sleep 6
	echo "closing windows..."
	qemu-send-key "alt-f4"
	bogomips-sleep 1.2
	qemu-send-key "spc"
	bogomips-sleep 6
}

install-app-adobe-reader-on-qemu-usage() {
	echo -e "usage:\n\tinstall-app-adobe-reader-on-qemu <WinInstallISO>" 1>&2
}
