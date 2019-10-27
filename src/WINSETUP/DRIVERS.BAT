@echo off
echo copy tcpip driver...
mkdir c:\drivers
mkdir c:\drivers\tcpip
copy d:\drivers\tcpip\*.* c:\drivers\tcpip
echo copy network driver...
mkdir c:\drivers\rtl8029
copy d:\drivers\rtl8029\wfw311\*.* c:\drivers\rtl8029
echo copy svga driver...
mkdir c:\drivers\svga
copy d:\drivers\svga\*.* c:\drivers\svga
echo unpacking tcpip driver...
cd c:\drivers\tcpip
tcp32b.exe
echo patching svga driver...
mkdir c:\windows
mkdir c:\windows\system
expand d:\winsetup\svga256.dr_ c:\windows\system\svga256.drv
copy c:\drivers\svga\vgapatch.com c:\windows\system
cd c:\windows\system
vgapatch.com p
cd c:\

