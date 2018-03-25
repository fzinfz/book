<!-- TOC -->

- [Check](#check)
- [Commit logs](#commit-logs)
- [.deb download](#deb-download)
- [Dynamic Kernel Module Support (DKMS)](#dynamic-kernel-module-support-dkms)
- [Compiling](#compiling)
    - [debug](#debug)
    - [.config](#config)
- [Install .deb manually](#install-deb-manually)
- [initrd (initial ramdisk)](#initrd-initial-ramdisk)
    - [initrd scheme](#initrd-scheme)
    - [initramfs scheme](#initramfs-scheme)
        - [dracut](#dracut)
        - [mkinitcpio](#mkinitcpio)
- [tracing](#tracing)
    - [BPF /eBPF](#bpf-ebpf)
    - [bcc](#bcc)
- [Releases](#releases)
    - [4.14 + 12 November, 2017](#414--12-november-2017)
    - [4.13 - 3 September, 2017 - Ubuntu 17.10 Artful](#413---3-september-2017---ubuntu-1710-artful)
    - [4.12 - 2 July, 2017](#412---2-july-2017)
    - [4.11 - 30 April, 2017](#411---30-april-2017)
    - [4.10 - 19 February, 2017 - Ubuntu 17.04 Zesty](#410---19-february-2017---ubuntu-1704-zesty)
    - [4.9 + 11 December, 2016 - Debian 9 Stretch](#49--11-december-2016---debian-9-stretch)
    - [4.8 - 2 October, 2016 - Ubuntu 16.10 Yakkety](#48---2-october-2016---ubuntu-1610-yakkety)
    - [4.7 - 24 July, 2016](#47---24-july-2016)
    - [4.6 - 15 May, 2016](#46---15-may-2016)
    - [4.5 - 13 March, 2016](#45---13-march-2016)
    - [4.4 + 10 January, 2016 - Ubuntu 16.04 Xenial](#44--10-january-2016---ubuntu-1604-xenial)
    - [4.3 - 1 November, 2015](#43---1-november-2015)
    - [4.2 - 30 August, 2015](#42---30-august-2015)
    - [4.1 + 21 June, 2015](#41--21-june-2015)
    - [4.0 - 12 April, 2015](#40---12-april-2015)
    - [3.16 + 3 August, 2014 - Debian 8 Jessie](#316--3-august-2014---debian-8-jessie)
    - [3.13 - 19 January, 2014 - Ubuntu 14.04 Trusty](#313---19-january-2014---ubuntu-1404-trusty)
    - [3.10 - 30 June, 2013 -  - RHEL 7](#310---30-june-2013------rhel-7)
    - [3.2 + 4 January, 2012](#32--4-january-2012)
    - [2.6.32 - 3 December, 2009 - RHEL 6](#2632---3-december-2009---rhel-6)

<!-- /TOC -->

# Check
    lsb_release -a
    uname -a
    cat /etc/*-release

# Commit logs
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/

# .deb download
http://kernel.ubuntu.com/~kernel-ppa/mainline/  
http://kernel.ubuntu.com/~kernel-ppa/mainline/daily/current/

# Dynamic Kernel Module Support (DKMS)
https://wiki.archlinux.org/index.php/Dynamic_Kernel_Module_Support

DKMS modules automatically rebuilt when a new kernel is installed.

# Compiling
https://www.ibm.com/developerworks/community/blogs/5144904d-5d75-45ed-9d2b-cf1754ee936a/entry/kernel-build-system?lang=en (Chinese)

## debug
    scripts/config --enable DEBUG_INFO
    make clean

## .config
oldconfig: /boot/config*  # compiled parameters  
Force pass overwriten: https://lists.kernelnewbies.org/pipermail/kernelnewbies/2013-May/008287.html

# Install .deb manually
```
wget http://mirrors.kernel.org/debian/pool/main/l/linux/linux-image-4.9.0-rc8-amd64-unsigned_4.9~rc8-1~exp1_amd64.deb

ar x linux-image-4.9.0-rc8-amd64-unsigned_4.9~rc8-1~exp1_amd64.deb
tar -Jxf data.tar.xz
install -m644 boot/vmlinuz-4.9.0-rc8-amd64 /boot/vmlinuz-4.9.0-rc8-amd64
cp -Rav lib/modules/4.9.0-rc8-amd64 /lib/modules/
depmod -a 4.9.0-rc8-amd64

dracut -f -v --hostonly -k '/lib/modules/4.9.0-rc8-amd64'  /boot/initramfs-4.9.0-rc8-amd64.img 4.9.0-rc8-amd64
```
Ref: https://www.mf8.biz/linux-kernel-with-tcp-bbr/    

# initrd (initial ramdisk)
https://en.wikipedia.org/wiki/Initial_ramdisk  
initrd and initramfs refer to two different methods of achieving this.   

    lsinitramfs /initrd.img

## initrd scheme
the image may be a file system image (optionally compressed)  
executes /sbin/init to begin the normal user-space boot process

## initramfs scheme
available since the Linux kernel 2.6.13  
the image may be a cpio archive (optionally compressed)  
Tiny Core Linux and Puppy Linux can run entirely from initrd.
 
    /etc/initramfs-tools/modules
    update-initramfs -u
    update-initramfs -d -k 4.13.0-16-generic

### dracut
create initial ramdisk images for preloading modules

/usr/lib/dracut/modules.d

    /etc/dracut.conf.d/local.conf
        add_drivers+="vfio vfio_iommu_type1 vfio_pci vfio_virqfd"
    dracut --force  # create /boot/initramfs-*.img

### mkinitcpio
https://wiki.archlinux.org/index.php/Mkinitcpio
mkinitcpio is the next generation of initramfs creation.

# tracing
## BPF /eBPF
https://qmonnet.github.io/whirl-offload/2016/09/01/dive-into-bpf/

## bcc
https://github.com/iovisor/bcc/tree/master/tools

![](http://www.brendangregg.com/Perf/bcc_tracing_tools.png)

# Releases
https://kernelnewbies.org/LinuxVersions

[RHEL](https://access.redhat.com/articles/3078) | 
[Ubuntu](https://askubuntu.com/questions/517136/list-of-ubuntu-versions-with-corresponding-linux-kernel-version) | 
[Debian](https://en.wikipedia.org/wiki/Debian_version_history#Release_table)

    6.0	Squeeze	2.6.32  -> LTS until February 2016
    7	Wheezy 3.2  -> LTS until May 2018
    8	Jessie 3.16 -> LTS until April/May 2020
    9	Stretch	4.9	-> LTS until June 2022
    10	Buster
    11	Bullseye

## 4.14 + 12 November, 2017
    XEN: introduce the frontend for the newly introduced PV Calls procotol
    igb: support BCM54616 PHY
    ixgbe: add initial support for xdp redirect
    phy: Add USB charger support
    xhci: Support enabling of compliance mode for xhci 1.1
    mediatek: Add controller support for MT2712 and MT7622 commit, add MSI support for MT2712 and MT7622

## 4.13 - 3 September, 2017 - Ubuntu 17.10 Artful

## 4.12 - 2 July, 2017

## 4.11 - 30 April, 2017

## 4.10 - 19 February, 2017 - Ubuntu 17.04 Zesty

## 4.9 + 11 December, 2016 - Debian 9 Stretch

## 4.8 - 2 October, 2016 - Ubuntu 16.10 Yakkety

## 4.7 - 24 July, 2016

## 4.6 - 15 May, 2016

## 4.5 - 13 March, 2016

## 4.4 + 10 January, 2016 - Ubuntu 16.04 Xenial

## 4.3 - 1 November, 2015

## 4.2 - 30 August, 2015

## 4.1 + 21 June, 2015

## 4.0 - 12 April, 2015
livepatch is not feature complete, yet it provides a basic infrastructure

## 3.16 + 3 August, 2014 - Debian 8 Jessie 
## 3.13 - 19 January, 2014 - Ubuntu 14.04 Trusty
## 3.10 - 30 June, 2013 -  - RHEL 7
## 3.2 + 4 January, 2012
## 2.6.32 - 3 December, 2009 - RHEL 6