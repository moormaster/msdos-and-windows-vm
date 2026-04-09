. lib-bogomips-sleep.sh
. lib-qemu.sh

install-app-msoffice-on-qemu() {
	local isoimage="$1"

	if [ $# -lt 1 ]
	then
		install-app-msoffice-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		install-app-msoffice-on-qemu-usage
		return
	fi

	qemu-change-cdrom "$isoimage"
	echo "installing msoffice..."
	qemu-send-line-de "c:\\windows\\win.com d:\\apps\\msoffice\\disk1\\setup.exe /q"
	bogomips-sleep 425
	echo "closing office cue cards..."
	qemu-send-key "alt-f4"
	bogomips-sleep 1.2
	echo "closing windows..."
	qemu-send-key "alt-f4"
	qemu-send-key "ret"
	bogomips-sleep 5
	echo "starting windows..."
	qemu-send-line-de "c:\\windows\\win.com"
	bogomips-sleep 24
	echo "closing office cue cards..."
	qemu-send-key "alt-f4"
	bogomips-sleep 1.2
	echo "closing windows..."
	qemu-send-key "alt-f4"
	qemu-send-key "ret"
	bogomips-sleep 5
}

install-app-msoffice-on-qemu-usage() {
	echo -e "usage:\n\tinstall-app-msoffice-on-qemu <WinInstallISO>" 1>&2
}
