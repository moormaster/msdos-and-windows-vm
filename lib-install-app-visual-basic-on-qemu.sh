. lib-bogomips-sleep.sh
. lib-qemu.sh

install-app-visual-basic-on-qemu() {
	local isoimage="$1"

	if [ $# -lt 1 ]
	then
		install-app-visual-basic-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		install-app-visual-basic-on-qemu-usage
		return
	fi

	qemu-change-cdrom "$isoimage"
	echo "installing Micrsoft Visual Basic..."
	echo "starting windows"
	qemu-send-line-de "c:\\windows\\win.com"
	bogomips-sleep 15
	echo "closing office manager..."
	qemu-send-key "alt-f"
	qemu-send-key "r"
	qemu-send-line-de "taskman"
	bogomips-sleep 3
	qemu-send-key "tab"
	bogomips-sleep 1
	qemu-send-key "tab"
	bogomips-sleep 1
	qemu-send-key "spc"
	bogomips-sleep 1
	echo "starting setup"
	qemu-send-key "alt-f"
	qemu-send-key "r"
	qemu-send-line-de "d:\\setup.exe"
	bogomips-sleep 45
	echo "starting Visual Basic install..."
	qemu-send-key "spc"
	bogomips-sleep 5
	echo "confirming welcome screen..."
	qemu-send-key "ret"
	bogomips-sleep 3
	echo "confirming name and org..."
	qemu-send-key "a"
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 3
	echo "confirming product id..."
	qemu-send-key "ret"
	bogomips-sleep 10
	echo "confirming install location..."
	qemu-send-key "ret"
	bogomips-sleep 15
	echo "confirming complete install..."
	qemu-send-key "ret"
	bogomips-sleep 15
	echo "confirming to copy help files..."
	qemu-send-key "ret"
	bogomips-sleep 10
	echo "confirming program group..."
	qemu-send-key "ret"
	bogomips-sleep 255
	echo "confirming install end..."
	qemu-send-key "ret"
	bogomips-sleep 2
	echo "closing windows..."
	qemu-send-key "alt-f4"
	qemu-send-key "ret"
	bogomips-sleep 5
}

install-app-visual-basic-on-qemu-usage() {
	echo -e "usage:\n\tinstall-app-visual-basic-on-qemu <WinInstallISO>" 1>&2
}
