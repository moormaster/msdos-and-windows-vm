. lib-bogomips-sleep.sh
. lib-qemu.sh

activate-w311fwg-settings-on-qemu() {
	isoimage="$1"

	if [ $# -lt 1 ]
	then
		activate-w311fwg-settings-on-qemu-usage
		return
	fi

	if ! [ -f "$1" ]
	then
		echo "file not found: $1" 1>&2
		activate-w311fwg-settings-on-qemu-usage
		return
	fi

	qemu-send "change ide1-cd0 $isoimage"
	echo "activating svga driver..."
	qemu-send-string-de "cd \\windows"
	qemu-send-string-de "setup.exe"
	bogomips-sleep 1
	qemu-send-key "up"
	qemu-send-key "up"
	qemu-send-key "up"
	qemu-send-key "up"
	qemu-send-key "up"
	qemu-send-key "up"
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-key "down"
	qemu-send-key "down"
	qemu-send-key "down"
	qemu-send-key "ret"
	qemu-send-key "ret"
	qemu-send-key "ret"
	bogomips-sleep 45
	echo "activating win.com..."
	qemu-send-string-de "echo C:\\WINDOWS\\WIN.COM >> c:\\autoexec.bat"
	bogomips-sleep 1
}

activate-w311fwg-settings-on-qemu-usage() {
	echo "activate-w311fwg-settings-on-qemu <WinInstallISO>" 1>&2
}
