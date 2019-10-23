WINWORLDPCMIRRORNAME="Ricky"

WIN98BOOTDISK_ARCHIVE="Microsoft Windows 98 Second Edition - Boot Disk (3.5-1.44mb).7z"
WIN98BOOTDISK_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/microsoft-windows-boot-disk/98-se" "Microsoft Windows 98 Second Edition - Boot Disk (3.5-1.44mb).7z" ${WINWORLDPCMIRRORNAME}`

MSDOS622_ARCHIVE="Microsoft MS-DOS 6.22 Plus Enhanced Tools (3.5).7z"
MSDOS622_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/ms-dos/622" "Microsoft MS-DOS 6.22 Plus Enhanced Tools (3.5).7z" ${WINWORLDPCMIRRORNAME}`

W311FWG_ARCHIVE="Microsoft Windows for Workgroups 3.11 (OEM) (3.5-1.44mb).7z"
W311FWG_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/windows-3/wfw-311" "Microsoft Windows for Workgroups 3.11 (OEM) (3.5-1.44mb).7z" ${WINWORLDPCMIRRORNAME}`

TCPIP_ARCHIVE="Microsoft TCP-IP-32 For Windows 3.1 (3.5).7z"
TCPIP_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/microsoft-tcp-ip-32/tcpip-32-3-11b" "Microsoft TCP-IP-32 For Windows 3.1 (3.5).7z" ${WINWORLDPCMIRRORNAME}`

CIRRUS_ARCHIVE="win_5446.zip"
CIRRUS_URL="http://www.claunia.com/qemu/drivers/win_5446.zip"

SVGA_ARCHIVE="win3x-svga.flp"
SVGA_URL="http://ds-tech.weebly.com/uploads/2/6/2/0/2620861/win3x-svga.flp"

RTL8029_ARCHIVE="wfw_8029.zip"
RTL8029_URL="http://www.claunia.com/qemu/drivers/wfw_8029.zip"

NC_ARCHIVE="Norton Commander 5.5 (3.5).7z"
NC_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/norton-commander/55x" "Norton Commander 5.5 (3.5).7z" ${WINWORLDPCMIRRORNAME}`

IE_ARCHIVE="Microsoft Internet Explorer 5.0 (5.00.0913.2200) [Windows 3.x].7z"
IE_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/internet-explorer/ie-5" "Microsoft Internet Explorer 5.0 (5.00.0913.2200) [Windows 3.x].7z" ${WINWORLDPCMIRRORNAME}`

NETSCAPE_ARCHIVE="Netscape Composer 4.09SE.exe.7z"
NETSCAPE_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/netscape-navigator/40x" "Netscape Composer 4.09SE.exe.7z" ${WINWORLDPCMIRRORNAME}`

OFFICE_ARCHIVE="Microsoft Office 4.3 Professional (3.5 DMF).7z"
OFFICE_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/microsoft-office/4x" "Microsoft Office 4.3 Professional (3.5 DMF).7z" ${WINWORLDPCMIRRORNAME}`

INSTALLISOIMAGE_DIR=install-w311fwg-iso

MSDOS622_FILES=DosDisk1.img DosDisk2.img DosDisk3.img Suppdisk.img
W311FWG_FILES=WinDisk1.img WinDisk2.img WinDisk3.img WinDisk4.img WinDisk5.img WinDisk6.img WinDisk7.img WinDisk8.img 

NC_FILES=NCDisk1.img NCDisk2.img NCDisk3.img
OFFICE_FILES=OfficeDisk1.img OfficeDisk2.img OfficeDisk3.img OfficeDisk4.img OfficeDisk5.img OfficeDisk6.img OfficeDisk7.img OfficeDisk8.img OfficeDisk9.img OfficeDisk10.img OfficeDisk11.img OfficeDisk12.img OfficeDisk13.img OfficeDisk14.img OfficeDisk15.img OfficeDisk16.img OfficeDisk17.img OfficeDisk18.img OfficeDisk19.img OfficeDisk20.img OfficeDisk21.img OfficeDisk22.img OfficeDisk23.img OfficeDisk24.img

DLFILES=${WIN98BOOTDISK_ARCHIVE} ${MSDOS622_ARCHIVE} ${W311FWG_ARCHIVE} ${TCPIP_ARCHIVE} ${CIRRUS_ARCHIVE} ${SVGA_ARCHIVE} ${RTL8029_ARCHIVE} ${NC_ARCHIVE} ${IE_ARCHIVE} ${NETSCAPE_ARCHIVE} ${OFFICE_ARCHIVE}
FILES=Win98BootDisk.img ${MSDOS622_FILES} ${W311FWG_FILES} ${NC_FILES} ${OFFICE_FILES} tcpip.img HardDisk.img install-w311fwg.iso startvm.sh

DISKSIZE_IN_BYTES=`echo 250*1024*1024 | bc`

all: startvm.sh

downloads: win98bootdisk-archive msdos622-archive w311fwg-archive tcpip-archive cirrus-archive svga-archive rtl8029-archive nc-archive ie-archive netscape-archive office-archive

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

install-w311fwg-iso-dir: ${W311FWG_FILES} ${NV_FILES} ${OFFICE_FILES} cirrus-archive svga-archive rtl8029-archive tcpip.img ie-archive netscape-archive src/WINSETUP/MYSETUP.SHH src/WINSETUP/WINSETUP.BAT src/APPS/NC/INSTALL.BAT
	[ -d "${INSTALLISOIMAGE_DIR}" ] || mkdir ${INSTALLISOIMAGE_DIR}
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk1.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk2.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk3.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk4.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk5.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk6.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk7.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk8.img
	[ -d "${INSTALLISOIMAGE_DIR}/WINSETUP/MYSETUP.SHH" ] || cp -f src/WINSETUP/MYSETUP.SHH ${INSTALLISOIMAGE_DIR}/WINSETUP/
	[ -d "${INSTALLISOIMAGE_DIR}/WINSETUP/WINSETUP.BAT" ] || cp -f src/WINSETUP/WINSETUP.BAT ${INSTALLISOIMAGE_DIR}/WINSETUP/
	[ -d "${INSTALLISOIMAGE_DIR}/DRIVERS" ] || mkdir "${INSTALLISOIMAGE_DIR}/DRIVERS"
	[ -d "${INSTALLISOIMAGE_DIR}/DRIVERS/RTL8029" ] || unzip -d "${INSTALLISOIMAGE_DIR}/DRIVERS/RTL8029" ${RTL8029_ARCHIVE}
	[ -d "${INSTALLISOIMAGE_DIR}/DRIVERS/CIRRUS" ] || unzip -d "${INSTALLISOIMAGE_DIR}/DRIVERS/CIRRUS" ${CIRRUS_ARCHIVE}
	[ -d "${INSTALLISOIMAGE_DIR}/DRIVERS/SVGA" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/DRIVERS/SVGA ${SVGA_ARCHIVE}
	[ -d "${INSTALLISOIMAGE_DIR}/DRIVERS/TCPIP" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/DRIVERS/TCPIP tcpip.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS" ] || mkdir "${INSTALLISOIMAGE_DIR}/APPS"
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/IE" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/IE ${IE_ARCHIVE}
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/NETSCAPE" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/NETSCAPE ${NETSCAPE_ARCHIVE}
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/NC" ] || mkdir "${INSTALLISOIMAGE_DIR}/APPS/NC"
	[ -f "${INSTALLISOIMAGE_DIR}/APPS/NC/INSTALL.BAT" ] || cp src/APPS/NC/INSTALL.BAT "${INSTALLISOIMAGE_DIR}/APPS/NC/"
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/NC NCDisk1.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/NC NCDisk2.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/NC NCDisk3.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE" ] || mkdir "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE"
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK1" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK1 OfficeDisk1.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK2" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK2  OfficeDisk2.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK3" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK3  OfficeDisk3.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK4" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK4  OfficeDisk4.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK5" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK5  OfficeDisk5.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK6" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK6  OfficeDisk6.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK7" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK7  OfficeDisk7.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK8" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK8  OfficeDisk8.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK9" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK9  OfficeDisk9.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK10" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK10  OfficeDisk10.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK11" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK11  OfficeDisk11.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK12" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK12  OfficeDisk12.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK13" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK13  OfficeDisk13.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK14" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK14  OfficeDisk14.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK15" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK15  OfficeDisk15.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK16" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK16  OfficeDisk16.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK17" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK17  OfficeDisk17.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK18" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK18  OfficeDisk18.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK19" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK19  OfficeDisk19.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK20" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK20  OfficeDisk20.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK21" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK21  OfficeDisk21.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK22" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK22  OfficeDisk22.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK23" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK23  OfficeDisk23.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK24" ] || 7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK24  OfficeDisk24.img
	
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

NCDisk1.img: nc-archive WinDisk1.img
	# adding WinDisk1.img to the dependency list due to naming conflict
	[ -f "NCDisk1.img" ] || 7z e ${NC_ARCHIVE} "Norton Commander 5.5 (3.5)/Disk01.img"
	[ -f "NCDisk1.img" ] || mv Disk01.img NCDisk1.img

NCDisk2.img: nc-archive WinDisk2.img
	# adding WinDisk2.img to the dependency list due to naming conflict
	[ -f "NCDisk2.img" ] || 7z e ${NC_ARCHIVE} "Norton Commander 5.5 (3.5)/Disk02.img"
	[ -f "NCDisk2.img" ] || mv Disk02.img NCDisk2.img

NCDisk3.img: nc-archive WinDisk3.img
	# adding WinDisk3.img to the dependency list due to naming conflict
	[ -f "NCDisk3.img" ] || 7z e ${NC_ARCHIVE} "Norton Commander 5.5 (3.5)/Disk03.img"
	[ -f "NCDisk3.img" ] || mv Disk03.img NCDisk3.img

OfficeDisk1.img: office-archive WinDisk1.img NCDisk1.img
	# adding WinDisk1.img and NCDisk1.img to the dependency list due to naming conflict
	[ -f "OfficeDisk1.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk01.img"
	[ -f "OfficeDisk1.img" ] || mv Disk01.img OfficeDisk1.img

OfficeDisk2.img: office-archive WinDisk2.img NCDisk2.img
	# adding WinDisk2.img and NCDisk2.img to the dependency list due to naming conflict
	[ -f "OfficeDisk2.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk02.img"
	[ -f "OfficeDisk2.img" ] || mv Disk02.img OfficeDisk2.img

OfficeDisk3.img: office-archive WinDisk3.img NCDisk3.img
	# adding WinDisk3.img and NCDisk3.img to the dependency list due to naming conflict
	[ -f "OfficeDisk3.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk03.img"
	[ -f "OfficeDisk3.img" ] || mv Disk03.img OfficeDisk3.img

OfficeDisk4.img: office-archive WinDisk4.img
	# adding WinDisk4.img to the dependency list due to naming conflict
	[ -f "OfficeDisk4.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk04.img"
	[ -f "OfficeDisk4.img" ] || mv Disk04.img OfficeDisk4.img

OfficeDisk5.img: office-archive WinDisk5.img
	# adding WinDisk5.img to the dependency list due to naming conflict
	[ -f "OfficeDisk5.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk05.img"
	[ -f "OfficeDisk5.img" ] || mv Disk05.img OfficeDisk5.img

OfficeDisk6.img: office-archive WinDisk6.img
	# adding WinDisk6.img to the dependency list due to naming conflict
	[ -f "OfficeDisk6.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk06.img"
	[ -f "OfficeDisk6.img" ] || mv Disk06.img OfficeDisk6.img

OfficeDisk7.img: office-archive WinDisk7.img
	# adding WinDisk7.img to the dependency list due to naming conflict
	[ -f "OfficeDisk7.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk07.img"
	[ -f "OfficeDisk7.img" ] || mv Disk07.img OfficeDisk7.img

OfficeDisk8.img: office-archive WinDisk8.img
	# adding WinDisk8.img to the dependency list due to naming conflict
	[ -f "OfficeDisk8.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk08.img"
	[ -f "OfficeDisk8.img" ] || mv Disk08.img OfficeDisk8.img

OfficeDisk9.img: office-archive
	[ -f "OfficeDisk9.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk09.img"
	[ -f "OfficeDisk9.img" ] || mv Disk09.img OfficeDisk9.img

OfficeDisk10.img: office-archive
	[ -f "OfficeDisk10.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk10.img"
	[ -f "OfficeDisk10.img" ] || mv Disk10.img OfficeDisk10.img

OfficeDisk11.img: office-archive
	[ -f "OfficeDisk11.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk11.img"
	[ -f "OfficeDisk11.img" ] || mv Disk11.img OfficeDisk11.img

OfficeDisk12.img: office-archive
	[ -f "OfficeDisk12.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk12.img"
	[ -f "OfficeDisk12.img" ] || mv Disk12.img OfficeDisk12.img

OfficeDisk13.img: office-archive
	[ -f "OfficeDisk13.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk13.img"
	[ -f "OfficeDisk13.img" ] || mv Disk13.img OfficeDisk13.img

OfficeDisk14.img: office-archive
	[ -f "OfficeDisk14.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk14.img"
	[ -f "OfficeDisk14.img" ] || mv Disk14.img OfficeDisk14.img

OfficeDisk15.img: office-archive
	[ -f "OfficeDisk15.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk15.img"
	[ -f "OfficeDisk15.img" ] || mv Disk15.img OfficeDisk15.img

OfficeDisk16.img: office-archive
	[ -f "OfficeDisk16.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk16.img"
	[ -f "OfficeDisk16.img" ] || mv Disk16.img OfficeDisk16.img

OfficeDisk17.img: office-archive
	[ -f "OfficeDisk17.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk17.img"
	[ -f "OfficeDisk17.img" ] || mv Disk17.img OfficeDisk17.img

OfficeDisk18.img: office-archive
	[ -f "OfficeDisk18.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk18.img"
	[ -f "OfficeDisk18.img" ] || mv Disk18.img OfficeDisk18.img

OfficeDisk19.img: office-archive
	[ -f "OfficeDisk19.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk19.img"
	[ -f "OfficeDisk19.img" ] || mv Disk19.img OfficeDisk19.img

OfficeDisk20.img: office-archive
	[ -f "OfficeDisk20.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk20.img"
	[ -f "OfficeDisk20.img" ] || mv Disk20.img OfficeDisk20.img

OfficeDisk21.img: office-archive
	[ -f "OfficeDisk21.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk21.img"
	[ -f "OfficeDisk21.img" ] || mv Disk21.img OfficeDisk21.img

OfficeDisk22.img: office-archive
	[ -f "OfficeDisk22.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk22.img"
	[ -f "OfficeDisk22.img" ] || mv Disk22.img OfficeDisk22.img

OfficeDisk23.img: office-archive
	[ -f "OfficeDisk23.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk23.img"
	[ -f "OfficeDisk23.img" ] || mv Disk23.img OfficeDisk23.img

OfficeDisk24.img: office-archive
	[ -f "OfficeDisk24.img" ] || 7z e ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk24.img"
	[ -f "OfficeDisk24.img" ] || mv Disk24.img OfficeDisk24.img

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

svga-archive:
	[ -f ${SVGA_ARCHIVE} ] || wget -O ${SVGA_ARCHIVE} ${SVGA_URL}
	md5sum --ignore-missing -c md5sums

rtl8029-archive:
	[ -f ${RTL8029_ARCHIVE} ] || wget -O ${RTL8029_ARCHIVE} ${RTL8029_URL}
	md5sum --ignore-missing -c md5sums

nc-archive:
	[ -f ${NC_ARCHIVE} ] || wget -O ${NC_ARCHIVE} ${NC_URL}
	md5sum --ignore-missing -c md5sums

office-archive:
	[ -f ${OFFICE_ARCHIVE} ] || wget -O ${OFFICE_ARCHIVE} ${OFFICE_URL}
	md5sum --ignore-missing -c md5sums

ie-archive:
	[ -f ${IE_ARCHIVE} ] || wget -O ${IE_ARCHIVE} ${IE_URL}
	md5sum --ignore-missing -c md5sums

netscape-archive:
	[ -f ${NETSCAPE_ARCHIVE} ] || wget -O ${NETSCAPE_ARCHIVE} ${NETSCAPE_URL}
	md5sum --ignore-missing -c md5sums

