# Makefile for unattended creation of a MS DOS hard disk image

Installs an QEMU image with
- MS-DOS 6.22 including supplemental disk
- Norton Commmander
- Microsoft Windows for Workgroups 3.11
- Microsoft Office
- Netscape 4
- Internet Explorer 5

Provides additional software on the iso image

- AMD PCNet driver for Windows 3.11
- RTL8029 driver for DOS
- Microsoft Network Client for DOS

## Build
```
make downloads
make -j
```

If the vm does weird stuff the sendkey commands might be running to fast. The factor of the sleep times between actions can be controlled using the *SLEEPFACTOR* environment variable:
```
SLEEPFACTOR=2 make -j
```

Additional QEMU arguments can be defined in the *QEMU_ARGS* environment variable
```
QEMU_ARGS="-vnc :1" make -j
```

App installation can be skipped with *NOAPPS* environment variable
```
NOAPPS=1 make -j
```

Following configuration variables are available:

- *CONFIG_OEMCD* - the name of the cd drive when loading the dos cdrom driver - Default is *OEMCD001*
- *CONFIG_NETWORK* - the network driver to be installed. Possible values are *amdpcnet*, *rtl8029* or *none* - Default is *rtl8029*
- *CONFIG_COMPUTERNAME* - the computer name - Default is *JohnQ.Pu*
- *CONFIG_WORKGROUP* - the name of the workgroup - Default is *wg*
- *CONFIG_USERNAME* - the name of the user - Default is *JohnQ.Pu*
- *CONFIG_PASSWORD* - the password - Default is empty

i.e.
```
CONFIG_NETWORK=amdpcnet make -j
```

