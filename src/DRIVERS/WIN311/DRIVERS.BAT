@echo off
echo unpacking tcpip driver...
cd c:\drivers\win311\tcpip
tcp32b.exe
echo patching svga driver...
mkdir c:\windows
mkdir c:\windows\system
expand d:\winsetup\svga256.dr_ c:\windows\system\svga256.drv
copy c:\drivers\win311\svga\vgapatch.com c:\windows\system
cd c:\windows\system
vgapatch.com p
cd c:\
