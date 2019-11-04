WINWORLDPCMIRRORNAME="Ricky"
GENISOIMAGE=mkisofs

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

RTL8029DOS_ARCHIVE="dos_8029.zip"
RTL8029DOS_URL="http://www.claunia.com/qemu/drivers/dos_8029.zip"

RTL8029W311_ARCHIVE="wfw_8029.zip"
RTL8029W311_URL="http://www.claunia.com/qemu/drivers/wfw_8029.zip"

MSCLIENT1_ARCHIVE="DSK3-1.EXE"
MSCLIENT1_URL="https://archive.org/download/ftp.microsoft.com/ftp.microsoft.com.zip/ftp.microsoft.com%2Fbussys%2FClients%2FMSCLIENT%2FDSK3-1.EXE"

MSCLIENT2_ARCHIVE="DSK3-2.EXE"
MSCLIENT2_URL="https://archive.org/download/ftp.microsoft.com/ftp.microsoft.com.zip/ftp.microsoft.com%2Fbussys%2FClients%2FMSCLIENT%2FDSK3-2.EXE"

NC_ARCHIVE="Norton Commander 5.5 (3.5).7z"
NC_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/norton-commander/55x" "Norton Commander 5.5 (3.5).7z" ${WINWORLDPCMIRRORNAME}`

PKZIP_ARCHIVE="PKZip 2.04g (Registered) (3.5).7z"
PKZIP_URL=`./winworldpc-get-download-url.sh "https://winworldpc.com/product/pkzip/20" "PKZip 2.04g (Registered) (3.5).7z" ${WINWORLDPCMIRRORNAME}`

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

CLEANDOWNLOADFILES=${WIN98BOOTDISK_ARCHIVE} ${MSDOS622_ARCHIVE} ${W311FWG_ARCHIVE} ${TCPIP_ARCHIVE} ${CIRRUS_ARCHIVE} ${SVGA_ARCHIVE} ${RTL8029DOS_ARCHIVE} ${RTL8029W311_ARCHIVE} ${MSCLIENT1_ARCHIVE} ${MSCLIENT2_ARCHIVE} ${NC_ARCHIVE} ${PKZIP_ARCHIVE} ${IE_ARCHIVE} ${NETSCAPE_ARCHIVE} ${OFFICE_ARCHIVE}
CLEANFILES=Win98BootDisk.img ${MSDOS622_FILES} ${W311FWG_FILES} ${NC_FILES} ${OFFICE_FILES} tcpip.img pkzip.img HardDisk.img install-w311fwg.iso startvm.sh

DISKSIZE_IN_BYTES=`echo 250*1024*1024 | bc`

all: startvm.sh

downloads: win98bootdisk-archive msdos622-archive w311fwg-archive tcpip-archive cirrus-archive svga-archive rtl8029dos-archive rtl8029w311-archive tcpip-archive msclient1-archive msclient2-archive nc-archive pkzip-archive ie-archive netscape-archive office-archive

clean:
	rm -f ${CLEANFILES}
	rm -rf ${INSTALLISOIMAGE_DIR}

clean-all: clean clean-downloads

clean-downloads:
	rm -f ${CLEANDOWNLOADFILES}

startvm.sh: HardDisk.img install-w311fwg.iso
	echo "#!/usr/bin/env bash" > startvm.sh
	echo "qemu-system-i386 -m 32 -net nic,model=ne2k_pci -net user -fda \"\" -hda HardDisk.img -cdrom install-w311fwg.iso \"\$$@\"" >> startvm.sh
	chmod +x startvm.sh

HardDisk.img: lib-qemu.sh lib-install-dos-on-qemu.sh lib-activate-dos-powermanager.sh lib-install-oak-cdromdriver-on-qemu.sh lib-install-w311fwg-on-qemu.sh lib-install-app-netscape-on-qemu.sh lib-install-app-ie-on-qemu.sh lib-activate-w311fwg-settings-on-qemu.sh install-vm.sh install-w311fwg.iso Win98BootDisk.img DosDisk1.img DosDisk2.img DosDisk3.img Suppdisk.img
	dd if=/dev/zero of=HardDisk.img bs=${DISKSIZE_IN_BYTES} count=1

	./install-vm.sh HardDisk.img install-w311fwg.iso -m 32 -vga cirrus -net nic,model=ne2k_pci -net user

install-w311fwg.iso: install-w311fwg-iso-dir
	${GENISOIMAGE} -o install-w311fwg.iso ${INSTALLISOIMAGE_DIR}

install-w311fwg-iso-dir: WinDisks NCDisks OfficeDisks cirrus-archive svga-archive rtl8029dos-archive rtl8029w311-archive tcpip.img msclient1-archive msclient2-archive pkzip.img ie-archive netscape-archive src/WINSETUP/MYSETUP.SHH src/WINSETUP/WINSETUP.BAT src/DRIVERS/DRIVERS.BAT src/DRIVERS/WIN311/DRIVERS.BAT src/APPS/NC/INSTALL.BAT
	[ -d "${INSTALLISOIMAGE_DIR}" ] || mkdir ${INSTALLISOIMAGE_DIR}
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk1.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk2.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk3.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk4.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk5.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk6.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk7.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/WINSETUP WinDisk8.img
	cp -f src/WINSETUP/MYSETUP.SHH ${INSTALLISOIMAGE_DIR}/WINSETUP/
	cp -f src/WINSETUP/WINSETUP.BAT ${INSTALLISOIMAGE_DIR}/WINSETUP/
	[ -d "${INSTALLISOIMAGE_DIR}/DRIVERS" ] || mkdir "${INSTALLISOIMAGE_DIR}/DRIVERS"
	cp -f src/DRIVERS/DRIVERS.BAT ${INSTALLISOIMAGE_DIR}/DRIVERS
	[ -d "${INSTALLISOIMAGE_DIR}/DRIVERS/DOS" ] || mkdir "${INSTALLISOIMAGE_DIR}/DRIVERS/DOS"
	unzip -o -d "${INSTALLISOIMAGE_DIR}/DRIVERS/DOS/RTL8029" ${RTL8029DOS_ARCHIVE}
	unzip -o -d "${INSTALLISOIMAGE_DIR}/DRIVERS/DOS/MSCLIENT" ${MSCLIENT1_ARCHIVE}
	unzip -o -d "${INSTALLISOIMAGE_DIR}/DRIVERS/DOS/MSCLIENT" ${MSCLIENT2_ARCHIVE}
	[ -d "${INSTALLISOIMAGE_DIR}/DRIVERS/WIN311" ] || mkdir "${INSTALLISOIMAGE_DIR}/DRIVERS/WIN311"
	cp -f src/DRIVERS/WIN311/DRIVERS.BAT ${INSTALLISOIMAGE_DIR}/DRIVERS/WIN311
	unzip -o -d "${INSTALLISOIMAGE_DIR}/DRIVERS/WIN311/RTL8029" ${RTL8029W311_ARCHIVE}
	unzip -o -d "${INSTALLISOIMAGE_DIR}/DRIVERS/WIN311/CIRRUS" ${CIRRUS_ARCHIVE}
	7z x -y -o${INSTALLISOIMAGE_DIR}/DRIVERS/WIN311/SVGA ${SVGA_ARCHIVE}
	7z x -y -o${INSTALLISOIMAGE_DIR}/DRIVERS/WIN311/TCPIP tcpip.img
	[ -d "${INSTALLISOIMAGE_DIR}/APPS" ] || mkdir "${INSTALLISOIMAGE_DIR}/APPS"
	7z e -y -o${INSTALLISOIMAGE_DIR}/APPS/IE ${IE_ARCHIVE} "Microsoft Internet Explorer 5.0 (5.00.0913.2200) [Windows 3.x]/ie5win31.exe"
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/NC" ] || mkdir "${INSTALLISOIMAGE_DIR}/APPS/NC"
	cp src/APPS/NC/INSTALL.BAT "${INSTALLISOIMAGE_DIR}/APPS/NC/"
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/NC NCDisk1.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/NC NCDisk2.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/NC NCDisk3.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/NETSCAPE ${NETSCAPE_ARCHIVE} && mv "${INSTALLISOIMAGE_DIR}/APPS/NETSCAPE/Netscape Composer 4.09SE.exe" "${INSTALLISOIMAGE_DIR}/APPS/NETSCAPE/netscape.exe"
	[ -d "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE" ] || mkdir "${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE"
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK1 OfficeDisk1.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK2  OfficeDisk2.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK3  OfficeDisk3.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK4  OfficeDisk4.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK5  OfficeDisk5.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK6  OfficeDisk6.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK7  OfficeDisk7.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK8  OfficeDisk8.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK9  OfficeDisk9.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK10  OfficeDisk10.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK11  OfficeDisk11.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK12  OfficeDisk12.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK13  OfficeDisk13.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK14  OfficeDisk14.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK15  OfficeDisk15.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK16  OfficeDisk16.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK17  OfficeDisk17.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK18  OfficeDisk18.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK19  OfficeDisk19.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK20  OfficeDisk20.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK21  OfficeDisk21.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK22  OfficeDisk22.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK23  OfficeDisk23.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/MSOFFICE/DISK24  OfficeDisk24.img
	7z x -y -o${INSTALLISOIMAGE_DIR}/APPS/PKZIP pkzip.img
	
Win98BootDisk.img: win98bootdisk-archive
	7z e -y ${WIN98BOOTDISK_ARCHIVE} "Microsoft Windows 98 Second Edition - Boot Disk (3.5-1.44mb)/Windows 98 Second Edition Boot.img"
	mv "Windows 98 Second Edition Boot.img" Win98BootDisk.img

DosDisk1.img: msdos622-archive
	7z e -y ${MSDOS622_ARCHIVE} "Microsoft MS-DOS 6.22 Plus Enhanced Tools (3.5)/Disk1.img"
	mv Disk1.img DosDisk1.img

DosDisk2.img: msdos622-archive
	7z e -y ${MSDOS622_ARCHIVE} "Microsoft MS-DOS 6.22 Plus Enhanced Tools (3.5)/Disk2.img"
	mv Disk2.img DosDisk2.img

DosDisk3.img: msdos622-archive
	7z e -y ${MSDOS622_ARCHIVE} "Microsoft MS-DOS 6.22 Plus Enhanced Tools (3.5)/Disk3.img"
	mv Disk3.img DosDisk3.img

Suppdisk.img: msdos622-archive
	7z e -y ${MSDOS622_ARCHIVE} "Microsoft MS-DOS 6.22 Plus Enhanced Tools (3.5)/Suppdisk.img"

WinDisks: w311fwg-archive
	7z e -y ${W311FWG_ARCHIVE} "Microsoft Windows for Workgroups 3.11 (OEM) (3.5-1.44mb)/Disk*.img"
	mv Disk01.img WinDisk1.img
	mv Disk02.img WinDisk2.img
	mv Disk03.img WinDisk3.img
	mv Disk04.img WinDisk4.img
	mv Disk05.img WinDisk5.img
	mv Disk06.img WinDisk6.img
	mv Disk07.img WinDisk7.img
	mv Disk08.img WinDisk8.img

tcpip.img: tcpip-archive WinDisks
	# added WinDisk1.img dependency because of conflicting filename when executing makefile targets in parallel
	7z e -y ${TCPIP_ARCHIVE} "Microsoft TCP-IP-32 For Windows 3.1 (3.5)/Disk01.img"
	mv Disk01.img tcpip.img

pkzip.img: pkzip-archive DosDisk1.img
	# added DosDisk1.img dependency because of conflicting filename when executing makefile targets in parallel
	7z e -y ${PKZIP_ARCHIVE} "DISK1.IMG"
	mv DISK1.IMG pkzip.img

NCDisks: nc-archive WinDisks tcpip.img
	# adding WinDisks and tcpip.img to the dependency list due to naming conflict
	7z e -y ${NC_ARCHIVE} "Norton Commander 5.5 (3.5)/Disk*.img"
	mv Disk01.img NCDisk1.img
	mv Disk02.img NCDisk2.img
	mv Disk03.img NCDisk3.img

OfficeDisks: office-archive WinDisks tcpip.img NCDisks
	# adding WinDisk1.img, tcpip.img and NCDisks to the dependency list due to naming conflict
	7z e -y ${OFFICE_ARCHIVE} "Microsoft Office 4.3 Professional (3.5 DMF)/Disk*.img"
	mv Disk01.img OfficeDisk1.img
	mv Disk02.img OfficeDisk2.img
	mv Disk03.img OfficeDisk3.img
	mv Disk04.img OfficeDisk4.img
	mv Disk05.img OfficeDisk5.img
	mv Disk06.img OfficeDisk6.img
	mv Disk07.img OfficeDisk7.img
	mv Disk08.img OfficeDisk8.img
	mv Disk09.img OfficeDisk9.img
	mv Disk10.img OfficeDisk10.img
	mv Disk11.img OfficeDisk11.img
	mv Disk12.img OfficeDisk12.img
	mv Disk13.img OfficeDisk13.img
	mv Disk14.img OfficeDisk14.img
	mv Disk15.img OfficeDisk15.img
	mv Disk16.img OfficeDisk16.img
	mv Disk17.img OfficeDisk17.img
	mv Disk18.img OfficeDisk18.img
	mv Disk19.img OfficeDisk19.img
	mv Disk20.img OfficeDisk20.img
	mv Disk21.img OfficeDisk21.img
	mv Disk22.img OfficeDisk22.img
	mv Disk23.img OfficeDisk23.img
	mv Disk24.img OfficeDisk24.img

win98bootdisk-archive:
	[ -f ${WIN98BOOTDISK_ARCHIVE} ] || wget -O ${WIN98BOOTDISK_ARCHIVE} ${WIN98BOOTDISK_URL}
	grep ${WIN98BOOTDISK_ARCHIVE} md5sums | md5sum --ignore-missing -c

msdos622-archive:
	[ -f ${MSDOS622_ARCHIVE} ] || wget -O ${MSDOS622_ARCHIVE} ${MSDOS622_URL}
	grep ${MSDOS622_ARCHIVE} md5sums | md5sum --ignore-missing -c

w311fwg-archive:
	[ -f ${W311FWG_ARCHIVE} ] || wget -O ${W311FWG_ARCHIVE} ${W311FWG_URL}
	grep ${W311FWG_ARCHIVE} md5sums | md5sum --ignore-missing -c

tcpip-archive:
	[ -f ${TCPIP_ARCHIVE} ] || wget -O ${TCPIP_ARCHIVE} ${TCPIP_URL}
	grep ${TCPIP_ARCHIVE} md5sums | md5sum --ignore-missing -c

cirrus-archive:
	[ -f ${CIRRUS_ARCHIVE} ] || wget -O ${CIRRUS_ARCHIVE} ${CIRRUS_URL}
	grep ${CIRRUS_ARCHIVE} md5sums | md5sum --ignore-missing -c

svga-archive:
	[ -f ${SVGA_ARCHIVE} ] || wget -O ${SVGA_ARCHIVE} ${SVGA_URL}
	grep ${SVGA_ARCHIVE} md5sums | md5sum --ignore-missing -c

rtl8029dos-archive:
	[ -f ${RTL8029DOS_ARCHIVE} ] || wget -O ${RTL8029DOS_ARCHIVE} ${RTL8029DOS_URL}
	grep ${RTL8029DOS_ARCHIVE} md5sums | md5sum --ignore-missing -c

rtl8029w311-archive:
	[ -f ${RTL8029W311_ARCHIVE} ] || wget -O ${RTL8029W311_ARCHIVE} ${RTL8029W311_URL}
	grep ${RTL8029W311_ARCHIVE} md5sums | md5sum --ignore-missing -c

ie-archive:
	[ -f ${IE_ARCHIVE} ] || wget -O ${IE_ARCHIVE} ${IE_URL}
	grep "Microsoft Internet Explorer 5\.0" md5sums | md5sum --ignore-missing -c

msclient1-archive:
	[ -f ${MSCLIENT1_ARCHIVE} ] || wget -O ${MSCLIENT1_ARCHIVE} ${MSCLIENT1_URL}
	grep ${MSCLIENT1_ARCHIVE} md5sums | md5sum --ignore-missing -c

msclient2-archive:
	[ -f ${MSCLIENT2_ARCHIVE} ] || wget -O ${MSCLIENT2_ARCHIVE} ${MSCLIENT2_URL}
	grep ${MSCLIENT2_ARCHIVE} md5sums | md5sum --ignore-missing -c

nc-archive:
	[ -f ${NC_ARCHIVE} ] || wget -O ${NC_ARCHIVE} ${NC_URL}
	grep ${NC_ARCHIVE} md5sums | md5sum --ignore-missing -c

netscape-archive:
	[ -f ${NETSCAPE_ARCHIVE} ] || wget -O ${NETSCAPE_ARCHIVE} ${NETSCAPE_URL}
	grep ${NETSCAPE_ARCHIVE} md5sums | md5sum --ignore-missing -c

office-archive:
	[ -f ${OFFICE_ARCHIVE} ] || wget -O ${OFFICE_ARCHIVE} ${OFFICE_URL}
	grep ${OFFICE_ARCHIVE} md5sums | md5sum --ignore-missing -c

pkzip-archive:
	[ -f ${PKZIP_ARCHIVE} ] || wget -O ${PKZIP_ARCHIVE} ${PKZIP_URL}
	grep ${PKZIP_ARCHIVE} md5sums | md5sum --ignore-missing -c

