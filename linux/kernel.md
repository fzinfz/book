<!-- TOC -->

- [Check](#check)
- [delete](#delete)
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
- [Linux Releases](#linux-releases)
- [Kernel Versions](#kernel-versions)
- [linux-next](#linux-next)

<!-- /TOC -->

# Check

    lsb_release -a
    uname -a
    cat /etc/*-release
    dpkg -l | tail -n +6 | grep -E 'linux-image-[0-9]+'

# delete

    apt purge ...
    dpkg --purge ...

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

# Linux Releases
https://kernelnewbies.org/LinuxVersions

[RHEL](https://access.redhat.com/articles/3078) | 
[Ubuntu](https://askubuntu.com/questions/517136/list-of-ubuntu-versions-with-corresponding-linux-kernel-version) | 
[Debian](https://en.wikipedia.org/wiki/Debian_version_history#Release_table)

    6.0	Squeeze	2.6.32  -> LTS until February 2016
    7	Wheezy 3.2  -> LTS until May 2018
    8	Jessie 3.16 -> LTS until April/May 2020
    9	Stretch	4.9	-> LTS until June 2022
    10	Buster  4.19 -> LTS until June 2024
    11	Bullseye

# Kernel Versions
https://kernelnewbies.org/LinuxChanges  
https://kernelnewbies.org/Linux_5.10 


`+` for Longterm

    5.10 + 2020-12-13
        Ext4 fast commit
        Faster performance and memory consumption in virtio-fs
        


    5.9 - 2020-10-11
        New cgroup slab controller shares slab memory
        NFS: extended attributes RFC 8276

    5.4 + 2019-11-24  ->	Dec, 2025

    4.19 + 2018-10-22  ->	Dec, 2024

    4.14 + 2017-11-12  ->	Jan, 2024
            XEN: introduce the frontend for the newly introduced PV Calls procotol
            igb: support BCM54616 PHY
            ixgbe: add initial support for xdp redirect
            phy: Add USB charger support
            xhci: Support enabling of compliance mode for xhci 1.1
            mediatek: Add controller support for MT2712 and MT7622 commit, add MSI support for MT2712 and MT7622

    4.13 - 3 September, 2017 - Ubuntu 17.10 Artful

    4.12 - 2 July, 2017

    4.11 - 30 April, 2017

    4.10 - 19 February, 2017 - Ubuntu 17.04 Zesty

    4.9 + 2016-12-11  ->	Jan, 2023 - Debian 9 Stretch

    4.8 - 2 October, 2016 - Ubuntu 16.10 Yakkety

    4.7 - 24 July, 2016

    4.6 - 15 May, 2016

    4.5 - 13 March, 2016

    4.4 + 2016-01-10  ->	Feb, 2022 - Ubuntu 16.04 Xenial

    4.3 - 1 November, 2015

    4.2 - 30 August, 2015

    4.1 + 21 June, 2015

    4.0 - 12 April, 2015
        livepatch is not feature complete, yet it provides a basic infrastructure

    3.16 + 3 August, 2014 - Debian 8 Jessie 
    3.13 - 19 January, 2014 - Ubuntu 14.04 Trusty
    3.10 - 30 June, 2013 -  - RHEL 7
    3.2 + 4 January, 2012
    2.6.32 - 3 December, 2009 - RHEL 6

# linux-next
for patches aimed at the next kernel merge window  
https://www.kernel.org/doc/man-pages/linux-next.html