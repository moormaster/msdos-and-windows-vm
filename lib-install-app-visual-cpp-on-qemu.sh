. lib-bogomips-sleep.sh
. lib-qemu.sh

install-app-visual-cpp-on-qemu() {
	local isoimage="$1"

	if [ $# -lt 1 ]
	then
		install-app-visual-cpp-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		install-app-visual-cpp-on-qemu-usage
		return
	fi

	qemu-change-cdrom "$isoimage"
	echo "installing Micrsoft Visual C++..."
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
	qemu-send-line-de "d:\\msvc\\setup.exe"
	bogomips-sleep 45
	echo "confirming welcome screen..."
	qemu-send-key "ret"
	bogomips-sleep 2
	echo "confirming typical install..."
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "confirming installation of Phar Lap DOS-Extender..."
	qemu-send-key "z"
	bogomips-sleep 1
	echo "confirming name and org..."
	qemu-send-key "a"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 280
	echo "confirming changes to SYSTEM.INI and TOOLS.INI..,"
	qemu-send-key "ret"
	bogomips-sleep 3
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "confirm file-sharing info..."
	qemu-send-key "ret"
	bogomips-sleep 20
	echo "confirming install end..."
	qemu-send-key "ret"
	bogomips-sleep 3
	echo "closing windows..."
	qemu-send-key "alt-f4"
	qemu-send-key "ret"
	bogomips-sleep 5
}

install-app-visual-cpp-on-qemu-usage() {
	echo -e "usage:\n\tinstall-app-visual-cpp-on-qemu <WinInstallISO>" 1>&2
}
