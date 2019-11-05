. lib-bogomips-sleep.sh
. lib-qemu.sh

activate-w311fwg-networkdriver-on-qemu() {
	echo "running windows..."
	qemu-send-string-de "c:\\windows\\win.com"
	bogomips-sleep 10
	echo "confirming message about missing network driver..."
	qemu-send-key "ret"
	bogomips-sleep 6
	echo "running windows setup..."
	qemu-send-key "alt-f"
	qemu-send-key "r"
	qemu-send-string-de "c:\\windows\\winsetup.exe"
	bogomips-sleep 1
	echo "running network setup..."
	qemu-send-key "alt-o"
	qemu-send-key "n"
	bogomips-sleep 1
	echo "installing network driver..."
	qemu-send-key "alt-d"
	bogomips-sleep 1

	case "$NETWORK" in
	"rtl8029")
		echo "choosing adapter rtl8029..."
		qemu-send-key "alt-a"
		qemu-send-key "ret"
		bogomips-sleep 1
		qemu-send-string-de "c:\\drivers\\win311\\rtl8029\\wfw311"
		bogomips-sleep 1
		qemu-send-key "ret"
		bogomips-sleep 1
		;;
	"amdpcnet")
		echo "choosing adapter amd pcnet..."
		qemu-send-key "alt-a"
		qemu-send-key "ret"
		bogomips-sleep 1
		qemu-send-string-de "c:\\drivers\\win311\\amdpcnet"
		bogomips-sleep 1
		qemu-send-key "ret"
		bogomips-sleep 1
		echo "confirming base i/o port..."
		qemu-send-key "ret"
		echo "setting interrupt..."
		qemu-send-key "9"
		qemu-send-key "ret"
		echo "confirming dma channel..."
		qemu-send-key "ret"
		echo "confirming twisted pair interface..."
		qemu-send-key "ret"
		echo "confirming LED0-LED3 function..."
		qemu-send-key "ret"
		qemu-send-key "ret"
		qemu-send-key "ret"
		qemu-send-key "ret"
		;;
	*)
		echo "invalid value specified NETWORK=\"$NETWORK\"" 1>&2
		;;
	esac

	echo "installing tcpip driver..."
	qemu-send-key "alt-p"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 1
	qemu-send-string-de "c:\\drivers\\win311\\tcpip"
	qemu-send-key "ret"
	bogomips-sleep 8
	echo "closing network drivers dialog..."
	qemu-send-key "alt-l"
	bogomips-sleep 1
	echo "closing network setup..."
	qemu-send-key "ret"
	bogomips-sleep 7
	echo "enabling dhcp..."
	qemu-send-key "alt-e"
	bogomips-sleep 1
	echo "confirming enabling of dhcp..."
	qemu-send-key "ret"
	echo "closing TCP/IP configuration dialog..."
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "confirming changes of system.ini..."
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "rebooting..."
	qemu-send-key "ret"
	bogomips-sleep 20
	echo "running windows..."
	qemu-send-string-de "c:\\windows\\win.com"
	bogomips-sleep 20
	echo "setting empty password..."
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "confirming creation of password-list file..."
	qemu-send-key "z"
	bogomips-sleep 1
	echo "confirming with empty password..."
	qemu-send-key "ret"
	bogomips-sleep 1
	echo "closing windows..."
	qemu-send-key "alt-f4"
	bogomips-sleep 1
	qemu-send-key "ret"
	bogomips-sleep 10
}
