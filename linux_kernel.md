<!-- TOC -->

- [Check](#check)
- [Compiling](#compiling)
    - [debug](#debug)
    - [.config](#config)
- [Install deb manually](#install-deb-manually)
- [Releases](#releases)
    - [Debian](#debian)
    - [Ubuntu](#ubuntu)
    - [RHEL](#rhel)
    - [Linux 4.14 Released 12 November, 2017](#linux-414-released-12-november-2017)
    - [Linux 4.13 Released 3 September, 2017](#linux-413-released-3-september-2017)
    - [Linux 4.12 Released 2 July, 2017](#linux-412-released-2-july-2017)
    - [Linux 4.11 Released 30 April, 2017](#linux-411-released-30-april-2017)
    - [Linux 4.10 Released 19 February, 2017](#linux-410-released-19-february-2017)
    - [Linux 4.9 Released 11 December, 2016](#linux-49-released-11-december-2016)
    - [Linux 4.8 Released 2 October, 2016](#linux-48-released-2-october-2016)
    - [Linux 4.7 Released 24 July, 2016](#linux-47-released-24-july-2016)
    - [Linux 4.6 Released 15 May, 2016](#linux-46-released-15-may-2016)
    - [Linux 4.5 Released 13 March, 2016](#linux-45-released-13-march-2016)
    - [Linux 4.4 Released 10 January, 2016](#linux-44-released-10-january-2016)
    - [Linux 4.3 Released 1 November, 2015](#linux-43-released-1-november-2015)
    - [Linux 4.2 Released 30 August, 2015](#linux-42-released-30-august-2015)
    - [Linux 4.1 Released 21 June, 2015](#linux-41-released-21-june-2015)
    - [Linux 4.0 Released 12 April, 2015](#linux-40-released-12-april-2015)
    - [Linux 3.10 Released 30 June, 2013](#linux-310-released-30-june-2013)
    - [Linux 2.6.32 Released 3 December, 2009](#linux-2632-released-3-december-2009)

<!-- /TOC -->

# Check
    lsb_release -a
    uname -a
    cat /etc/*-release

# Compiling
https://www.ibm.com/developerworks/community/blogs/5144904d-5d75-45ed-9d2b-cf1754ee936a/entry/kernel-build-system?lang=en (Chinese)

## debug
    scripts/config --enable DEBUG_INFO
    make clean

## .config
oldconfig: /boot/config*  # compiled parameters
Force pass overwriten: https://lists.kernelnewbies.org/pipermail/kernelnewbies/2013-May/008287.html

# Install deb manually
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

# Releases
https://kernelnewbies.org/LinuxVersions

## Debian
https://en.wikipedia.org/wiki/Debian_version_history#Release_table

    6.0	Squeeze	2.6.32
    7	Wheezy 3.2
    8	Jessie 3.16 April/May 2020
    9	Stretch	4.9	June 2022
    10	Buster
    11	Bullseye

## Ubuntu
https://askubuntu.com/questions/517136/list-of-ubuntu-versions-with-corresponding-linux-kernel-version

    12.04   Precise Pangolin 3.2+
    12.10   Quantal Quetzal  3.5
    13.04   Raring Ringtail  3.8
    13.10   Saucy Salamander 3.11
    14.04   Trusty Tahr      3.13
    14.10   Utopic Unicorn   3.16
    15.04   Vivid Vervet     3.19
    15.10   Wily Werewolf    4.2
    16.04   Xenial Xerus     4.4
    16.10   Yakkety Yak      4.8
    17.04   Zesty Zapus      4.10
    17.10   Artful Aardvark  4.13

## RHEL
https://access.redhat.com/articles/3078

    7   3.10
    6   2.6.32
    5   2.6.18

## Linux 4.14 Released 12 November, 2017
XEN: introduce the frontend for the newly introduced PV Calls procotol
igb: support BCM54616 PHY
ixgbe: add initial support for xdp redirect
phy: Add USB charger support
xhci: Support enabling of compliance mode for xhci 1.1
mediatek: Add controller support for MT2712 and MT7622 commit, add MSI support for MT2712 and MT7622

## Linux 4.13 Released 3 September, 2017

## Linux 4.12 Released 2 July, 2017

## Linux 4.11 Released 30 April, 2017

## Linux 4.10 Released 19 February, 2017

## Linux 4.9 Released 11 December, 2016

## Linux 4.8 Released 2 October, 2016

## Linux 4.7 Released 24 July, 2016

## Linux 4.6 Released 15 May, 2016

## Linux 4.5 Released 13 March, 2016

## Linux 4.4 Released 10 January, 2016

## Linux 4.3 Released 1 November, 2015

## Linux 4.2 Released 30 August, 2015

## Linux 4.1 Released 21 June, 2015

## Linux 4.0 Released 12 April, 2015
livepatch is not feature complete, yet it provides a basic infrastructure

## Linux 3.10 Released 30 June, 2013
## Linux 2.6.32 Released 3 December, 2009
