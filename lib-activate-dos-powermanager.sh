. lib-bogomips-sleep.sh
. lib-qemu.sh

activate-dos-powermanager() {
	qemu-send-line-de "echo DEVICE=C:\\DOS\\POWER.EXE ADV:MAX >> c:\\config.sys"
	bogomips-sleep 1
}
