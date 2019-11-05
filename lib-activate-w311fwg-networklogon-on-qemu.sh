. lib-bogomips-sleep.sh
. lib-qemu.sh

activate-w311fwg-networklogon-on-qemu() {
	echo "running windows..."
	qemu-send-string-de "c:\\windows\\win.com"
	bogomips-sleep 4
	echo "runnung setup..."
	qemu-send-key "alt-f"
	qemu-send-key "r"
	qemu-send-string-de "c:\\windows\\winsetup.exe"
	bogomips-sleep 1
	qemu-send-key "alt-o"
	qemu-send-key "n"
	bogomips-sleep 1
	echo "open networks..."
	qemu-send-key "alt-n"
	bogomips-sleep 1
	echo "choose Microsoft Windows Network..."
	qemu-send-key "alt-i"
	qemu-send-key "ret"
	qemu-send-key "ret"
	qemu-send-key "esc"
	qemu-send-key "z"
	bogomips-sleep 1
	echo "entering workgroup name..."
	qemu-send-key "tab"
	qemu-send-string-de "wg"
	bogomips-sleep 10
	echo "confirming changes to autoexec.bat and config.sys..."
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "rebooting..."
	qemu-send-key "ret"
	bogomips-sleep 20
	echo "running windows..."
	qemu-send-string-de "c:\\windows\\win.com"
	bogomips-sleep 4
	echo "confirming message about missing network driver..."
	qemu-send-key "ret"
	bogomips-sleep 6
	echo "closing windows..."
	qemu-send-key "alt-f4"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 5
}
