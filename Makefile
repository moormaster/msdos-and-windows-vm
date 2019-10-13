WINWORLDPCMIRRORNAME="Ricky"

WIN98BOOTDISK_ARCHIVE="Microsoft Windows 98 Second Edition - Boot Disk (3.5-1.44mb).7z"
WIN98BOOTDISK_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/microsoft-windows-boot-disk/98-se" "Microsoft Windows 98 Second Edition - Boot Disk (3.5-1.44mb).7z" "${WINWORLDPCMIRRORNAME}"`

MSDOS622_ARCHIVE="Microsoft MS-DOS 6.22 Plus Enhanced Tools (3.5).7z"
MSDOS622_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/ms-dos/622" "Microsoft MS-DOS 6.22 Plus Enhanced Tools (3.5).7z" "${WINWORLDPCMIRRORNAME}"`

W311FWG_ARCHIVE="Microsoft Windows for Workgroups 3.11 (OEM) (3.5-1.44mb).7z"
W311FWG_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/windows-3/wfw-311" "Microsoft Windows for Workgroups 3.11 (OEM) (3.5-1.44mb).7z" "${WINWORLDPCMIRRORNAME}"`

TCPIP_ARCHIVE="Microsoft TCP-IP-32 For Windows 3.1 (3.5).7z"
TCPIP_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/microsoft-tcp-ip-32/tcpip-32-3-11b" "Microsoft TCP-IP-32 For Windows 3.1 (3.5).7z" "${WINWORLDPCMIRRORNAME}"`

CIRRUS_ARCHIVE="win_5446.zip"
CIRRUS_URL="http://www.claunia.com/qemu/drivers/win_5446.zip"

RTL8029_ARCHIVE="wfw_8029.zip"
RTL8029_URL="http://www.claunia.com/qemu/drivers/wfw_8029.zip"

IE_ARCHIVE="Microsoft Internet Explorer 5.0 (5.00.0913.2200) [Windows 3.x].7z"
IE_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/internet-explorer/ie-5" "Microsoft Internet Explorer 5.0 (5.00.0913.2200) [Windows 3.x].7z" "${WINWORLDPCMIRRORNAME}"`

NETSCAPE_ARCHIVE="Netscape Composer 4.09SE.exe.7z"
NETSCAPE_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/netscape-navigator/40x" "Netscape Composer 4.09SE.exe.7z" "${WINWORLDPCMIRRORNAME}"`

INSTALLISOIMAGE_DIR=install-w311fwg-iso

MSDOS622_FILES=DosDisk1.img DosDisk2.img DosDisk3.img Suppdisk.img
W311FWG_FILES=WinDisk1.img WinDisk2.img WinDisk3.img WinDisk4.img WinDisk5.img WinDisk6.img WinDisk7.img WinDisk8.img 

DLFILES=i${WIN98BOOTDISK_ARCHIVE} ${MSDOS622_ARCHIVE} ${W311FWG_ARCHIVE} ${TCPIP_ARCHIVE} ${CIRRUS_ARCHIVE} ${RTL8029_ARCHIVE} ${IE_ARCHIVE} ${NETSCAPE_ARCHIVE}
FILES=Win98BootDisk.img ${MSDOS622_FILES} ${W311FWG_FILES} tcpip.img HardDisk.img install-w311fwg.iso startvm.sh

DISKSIZE_IN_BYTES=104857600

all: startvm.sh

downloads: win98bootdisk-archive msdos622-archive w311fwg-archive tcpip-archive cirrus-archive rtl8029-archive ie-archive netscape-archive

clean:
	rm -f ${FILES}
	rm -rf ${INSTALLISOIMAGE_DIR}

clean-all: clean clean-downloads

clean-downloads:
	rm -f ${DLFILES}

startvm.sh: HardDisk.img install-w311fwg.iso
	echo "#!/bin/bash" >> startvm.sh
	echo "qemu-system-i386 -m 32 -vga cirrus -net nic,model=ne2k_pci -net user -fda \"\" -hda HardDisk.img -cdrom install-w311fwg.iso \"\$$@\"" >> startvm.sh
	chmod +x startvm.sh

HardDisk.img: lib-qemu.sh lib-install-dos-on-qemu.sh lib-install-oak-cdromdriver-on-qemu.sh lib-install-w311fwg-on-qemu.sh install-vm.sh install-w311fwg.iso Win98BootDisk.img DosDisk1.img DosDisk2.img DosDisk3.img Suppdisk.img
	dd if=/dev/zero of=HardDisk.img bs=${DISKSIZE_IN_BYTES} count=1

	./install-vm.sh HardDisk.img install-w311fwg.iso -m 32 -vga cirrus -net nic,model=ne2k_pci -net user

install-w311fwg.iso: install-w311fwg-iso-dir
	[ -f install-w311fwg.iso ] || mkisofs -o install-w311fwg.iso ${INSTALLISOIMAGE_DIR}

install-w311fwg-iso-dir: ${W311FWG_FILES} cirrus-archive rtl8029-archive tcpip.img ie-archive netscape-archive MYSETUP.SHH WINSETUP.BAT
	[ -d "${INSTALLISOIMAGE_DIR}" ] || mkdir ${INSTALLISOIMAGE_DIR}
	[ -d "${INSTALLISOIMAGE_DIR}/WINSETUP/WinDisk1.img" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk1.img
	[ -d "${INSTALLISOIMAGE_DIR}/WINSETUP/WinDisk2.img" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk2.img
	[ -d "${INSTALLISOIMAGE_DIR}/WINSETUP/WinDisk3.img" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk3.img
	[ -d "${INSTALLISOIMAGE_DIR}/WINSETUP/WinDisk4.img" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk4.img
	[ -d "${INSTALLISOIMAGE_DIR}/WINSETUP/WinDisk5.img" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk5.img
	[ -d "${INSTALLISOIMAGE_DIR}/WINSETUP/WinDisk6.img" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk6.img
	[ -d "${INSTALLISOIMAGE_DIR}/WINSETUP/WinDisk7.img" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk7.img
	[ -d "${INSTALLISOIMAGE_DIR}/WINSETUP/WinDisk8.img" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk8.img
	[ -d "${INSTALLISOIMAGE_DIR}/WINSETUP/MYSETUP.SHH" ] || cp -f MYSETUP.SHH ${INSTALLISOIMAGE_DIR}/WINSETUP/
	[ -d "${INSTALLISOIMAGE_DIR}/WINSETUP.BAT" ] || cp -f WINSETUP.BAT ${INSTALLISOIMAGE_DIR}/
	[ -d "${INSTALLISOIMAGE_DIR}/DRIVERS" ] || mkdir "${INSTALLISOIMAGE_DIR}/DRIVERS"
	[ -d "${INSTALLISOIMAGE_DIR}/DRIVERS/RTL8029" ] || unzip -d "${INSTALLISOIMAGE_DIR}/DRIVERS/RTL8029" ${RTL8029_ARCHIVE}
	[ -d "${INSTALLISOIMAGE_DIR}/DRIVERS/CIRRUS" ] || unzip -d "${INSTALLISOIMAGE_DIR}/DRIVERS/CIRRUS" ${CIRRUS_ARCHIVE}
	[ -d "${INSTALLISOIMAGE_DIR}/DRIVERS/TCPIP" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/DRIVERS/TCPIP tcpip.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS" ] || mkdir "${INSTALLISOIMAGE_DIR}/APPS"
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/IE" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/IE ${IE_ARCHIVE}
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/NETSCAPE" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/NETSCAPE ${NETSCAPE_ARCHIVE}

Win98BootDisk.img: win98bootdisk-archive
	[ -f "Win98BootDisk.img" ] || 7z e ${WIN98BOOTDISK_ARCHIVE} "Microsoft Windows 98 Second Edition - Boot Disk (3.5-1.44mb)/Windows 98 Second Edition Boot.img"
	[ -f "Win98BootDisk.img" ] || mv "Windows 98 Second Edition Boot.img" Win98BootDisk.img

DosDisk1.img: msdos622-archive
	[ -f "DosDisk1.img" ] || 7z e ${MSDOS622_ARCHIVE} "Microsoft MS-DOS 6.22 Plus Enhanced Tools (3.5)/Disk1.img"
	[ -f "DosDisk1.img" ] || mv Disk1.img DosDisk1.img

DosDisk2.img: msdos622-archive
	[ -f "DosDisk2.img" ] || 7z e ${MSDOS622_ARCHIVE} "Microsoft MS-DOS 6.22 Plus Enhanced Tools (3.5)/Disk2.img"
	[ -f "DosDisk2.img" ] || mv Disk2.img DosDisk2.img

DosDisk3.img: msdos622-archive
	[ -f "DosDisk3.img" ] || 7z e ${MSDOS622_ARCHIVE} "Microsoft MS-DOS 6.22 Plus Enhanced Tools (3.5)/Disk3.img"
	[ -f "DosDisk3.img" ] || mv Disk3.img DosDisk3.img

Suppdisk.img: msdos622-archive
	[ -f "Suppdisk.img" ] || 7z e ${MSDOS622_ARCHIVE} "Microsoft MS-DOS 6.22 Plus Enhanced Tools (3.5)/Suppdisk.img"

WinDisk1.img: w311fwg-archive
	[ -f "WinDisk1.img" ] || 7z e ${W311FWG_ARCHIVE} "Microsoft Windows for Workgroups 3.11 (OEM) (3.5-1.44mb)/Disk01.img"
	[ -f "WinDisk1.img" ] || mv Disk01.img WinDisk1.img

WinDisk2.img: w311fwg-archive
	[ -f "WinDisk2.img" ] || 7z e ${W311FWG_ARCHIVE} "Microsoft Windows for Workgroups 3.11 (OEM) (3.5-1.44mb)/Disk02.img"
	[ -f "WinDisk2.img" ] || mv Disk02.img WinDisk2.img

WinDisk3.img: w311fwg-archive
	[ -f "WinDisk3.img" ] || 7z e ${W311FWG_ARCHIVE} "Microsoft Windows for Workgroups 3.11 (OEM) (3.5-1.44mb)/Disk03.img"
	[ -f "WinDisk3.img" ] || mv Disk03.img WinDisk3.img

WinDisk4.img: w311fwg-archive
	[ -f "WinDisk4.img" ] || 7z e ${W311FWG_ARCHIVE} "Microsoft Windows for Workgroups 3.11 (OEM) (3.5-1.44mb)/Disk04.img"
	[ -f "WinDisk4.img" ] || mv Disk04.img WinDisk4.img

WinDisk5.img: w311fwg-archive
	[ -f "WinDisk5.img" ] || 7z e ${W311FWG_ARCHIVE} "Microsoft Windows for Workgroups 3.11 (OEM) (3.5-1.44mb)/Disk05.img"
	[ -f "WinDisk5.img" ] || mv Disk05.img WinDisk5.img

WinDisk6.img: w311fwg-archive
	[ -f "WinDisk6.img" ] || 7z e ${W311FWG_ARCHIVE} "Microsoft Windows for Workgroups 3.11 (OEM) (3.5-1.44mb)/Disk06.img"
	[ -f "WinDisk6.img" ] || mv Disk06.img WinDisk6.img

WinDisk7.img: w311fwg-archive
	[ -f "WinDisk7.img" ] || 7z e ${W311FWG_ARCHIVE} "Microsoft Windows for Workgroups 3.11 (OEM) (3.5-1.44mb)/Disk07.img"
	[ -f "WinDisk7.img" ] || mv Disk07.img WinDisk7.img

WinDisk8.img: w311fwg-archive
	[ -f "WinDisk8.img" ] || 7z e ${W311FWG_ARCHIVE} "Microsoft Windows for Workgroups 3.11 (OEM) (3.5-1.44mb)/Disk08.img"
	[ -f "WinDisk8.img" ] || mv Disk08.img WinDisk8.img

tcpip.img: tcpip-archive WinDisk1.img
	# added WinDisk1.img dependency because of conflicting filename when executing makefile targets in parallel
	[ -f "tcpip.img" ] || 7z e ${TCPIP_ARCHIVE} "Microsoft TCP-IP-32 For Windows 3.1 (3.5)/Disk01.img"
	[ -f "tcpip.img" ] || mv Disk01.img tcpip.img

win98bootdisk-archive:
	[ -f ${WIN98BOOTDISK_ARCHIVE} ] || wget -O ${WIN98BOOTDISK_ARCHIVE} ${WIN98BOOTDISK_URL}
	md5sum --ignore-missing -c md5sums

msdos622-archive:
	[ -f ${MSDOS622_ARCHIVE} ] || wget -O ${MSDOS622_ARCHIVE} ${MSDOS622_URL}
	md5sum --ignore-missing -c md5sums

w311fwg-archive:
	[ -f ${W311FWG_ARCHIVE} ] || wget -O ${W311FWG_ARCHIVE} ${W311FWG_URL}
	md5sum --ignore-missing -c md5sums

tcpip-archive:
	[ -f ${TCPIP_ARCHIVE} ] || wget -O ${TCPIP_ARCHIVE} ${TCPIP_URL}
	md5sum --ignore-missing -c md5sums

cirrus-archive:
	[ -f ${CIRRUS_ARCHIVE} ] || wget -O ${CIRRUS_ARCHIVE} ${CIRRUS_URL}
	md5sum --ignore-missing -c md5sums

rtl8029-archive:
	[ -f ${RTL8029_ARCHIVE} ] || wget -O ${RTL8029_ARCHIVE} ${RTL8029_URL}
	md5sum --ignore-missing -c md5sums

ie-archive:
	[ -f ${IE_ARCHIVE} ] || wget -O ${IE_ARCHIVE} ${IE_URL}
	md5sum --ignore-missing -c md5sums

netscape-archive:
	[ -f ${NETSCAPE_ARCHIVE} ] || wget -O ${NETSCAPE_ARCHIVE} ${NETSCAPE_URL}
	md5sum --ignore-missing -c md5sums

