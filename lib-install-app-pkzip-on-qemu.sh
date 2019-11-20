. lib-bogomips-sleep.sh
. lib-qemu.sh

install-app-pkzip-on-qemu() {
	isoimage="$1"

	if [ $# -lt 1 ]
	then
		install-app-pkzip-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		install-app-pkzip-on-qemu-usage
		return
	fi

	qemu-change-cdrom "$isoimage"
	echo "installing pkzip..."
	qemu-send-line-de "xcopy /e d:\\apps\\pkzip\\*.* c:\\pkware\\"
	bogomips-sleep 3
}

install-app-pkzip-on-qemu-usage() {
	echo -e "usage:\n\tinstall-app-pkzip-on-qemu <WinInstallISO>" 1>&2
}
