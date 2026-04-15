. lib-bogomips-sleep.sh
. lib-qemu.sh

install-app-netscape-on-qemu() {
	local isoimage="$1"

	if [ $# -lt 1 ]
	then
		install-app-netscape-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		install-app-netscape-on-qemu-usage
		return
	fi

	qemu-change-cdrom "$isoimage"
	echo "running windows..."
	qemu-send-line-de "c:\\windows\\win.com /n"
	bogomips-sleep 28
	echo "installing netscape..."
	qemu-send-key "alt-f"
	qemu-send-key "r"
	qemu-send-line-de "d:\\apps\\netscape\\netscape.exe"
	bogomips-sleep 250
	echo "confirming welcome message..."
	qemu-send-key "ret"
	bogomips-sleep 2.0
	echo "confirming license..."
	qemu-send-key "ret"
	bogomips-sleep 2.0
	echo "confirming installation directory..."
	qemu-send-key "ret"
	bogomips-sleep 2.0
	echo "confirming installation directory creation..."
	qemu-send-key "ret"
	bogomips-sleep 10
	echo "confirming video for windows message..."
	qemu-send-key "ret"
	bogomips-sleep 18
	echo "confirming windows group name..."
	qemu-send-key "ret"
	bogomips-sleep 2.0
	echo "confirming installation begin..."
	qemu-send-key "ret"
	bogomips-sleep 505
	echo "denying to view readme..."
	qemu-send-key "n"
	bogomips-sleep 2.0
	echo "rebooting..."
	qemu-send-key "ret"
	bogomips-sleep 5.0
	qemu-send-key "ret"
	bogomips-sleep 28
}

install-app-netscape-on-qemu-usage() {
	echo -e "usage:\n\tinstall-app-netscape-on-qemu <WinInstallISO>" 1>&2
}
