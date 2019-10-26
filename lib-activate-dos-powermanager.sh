. lib-bogomips-sleep.sh
. lib-qemu.sh

activate-dos-powermanager() {
	qemu-send-string-de "echo DEVICE=C:\\DOS\\POWER.EXE ADV:MAX >> C:\\config.sys"
	bogomips-sleep 1
}
