- [DHCP Options](#dhcp-options)
    - [Next Server](#next-server)
- [.iso to USB](#iso-to-usb)
- [UEFI Editor](#uefi-editor)
    - [efibootmgr - Linux](#efibootmgr---linux)
    - [Windows GUI](#windows-gui)
- [iPXE](#ipxe)
- [netboot.xyz](#netbootxyz)
    - [USB/ISO/GRUB/TFTP](#usbisogrubtftp)
    - [iPXE](#ipxe-1)
    - [Self Hosting](#self-hosting)
- [Windows](#windows)
    - [Remote install ISO](#remote-install-iso)
    - [Server - Windows](#server---windows)
- [Mikrotik](#mikrotik)
    - [Mikrotik + Windows](#mikrotik--windows)
- [Diskless](#diskless)
    - [Hive OS - Ubuntu](#hive-os---ubuntu)
    - [NetBSD](#netbsd)
    - [Windows](#windows-1)

https://blogs.technet.microsoft.com/dominikheinz/2011/03/18/dhcp-pxe-basics/

https://techcommunity.microsoft.com/t5/Configuration-Manager-Blog/You-want-to-PXE-Boot-Don-t-use-DHCP-Options/ba-p/275562


# DHCP Options
http://www.iana.org/assignments/bootp-dhcp-parameters/bootp-dhcp-parameters.xhtml

https://tools.ietf.org/html/rfc2132

    66: TFTP server name
    67: Bootfile name

## Next Server
https://www.ietf.org/archive/id/draft-ietf-dhc-nextserver-02.txt

# .iso to USB

- [ventoy](https://github.com/ventoy/Ventoy/releases):  copy .iso to flash drive directly
- [rufus](https://rufus.ie/en/): `WTG<v2.3` | `win7<=v3.22`
- [Etcher](https://www.balena.io/etcher): Windows images are not bootable without extra treatment
- Luobotou: https://github.com/nkc3g4/wtg-assistant : support 16G flash drive

# UEFI Editor
## efibootmgr - Linux
https://github.com/rhboot/efibootmgr  

  efibootmgr -v # Listing boot entries
  wget -P /boot/efi/EFI/arch https://url_of_ipxe-arch.efi  #  https://archlinux.org/releng/netboot/
  efibootmgr --create --disk /dev/sde --loader /EFI/arch/ipxe-arch.___.efi --label "Arch Linux Netboot" --unicode # -p if ESP not 1st partition
  efibootmgr --bootorder 

  Boot0006* debian        HD(1,GPT,fcdf5171-643b-4f6d-8599-e2682b07e1bf,0x800,0x1e5000)/File(\EFI\debian\shimx64.efi)
  Boot000C* BootSandisk   PcieRoot(0x0)/Pci(0x1f,0x2)/Sata(0,0,0)/HD(1,GPT,f4e334a7-3313-43b5-a074-e26d3374c63c,0x800,0x100000)/File(\EFI\BOOT\BOOTX64.EFI)

## Windows GUI
under `Tools` menu: https://www.diskgenius.com/editions.php

# iPXE
https://ipxe.org/cmd/chain

Download and boot the iPXE demonstration image
  chain http://boot.ipxe.org/demo/boot.php

# netboot.xyz
https://github.com/netbootxyz/netboot.xyz

OS list: https://netboot.xyz/docs/faq/#what-operating-systems-are-currently-available-on-netbootxyz

https://netboot.xyz/downloads/ | Raspberry Pi 4 / ARM64 / i686, x86_64, or aarch64

USB/ISO/iPXE/GRUB/QEMU/TFTP/VMWare: https://netboot.xyz/docs/category/booting-methods

WinPE: https://netboot.xyz/docs/kb/pxe/windows/

## USB/ISO/GRUB/TFTP
Combined Legacy and UEFI iPXE Bootloaders

    https://boot.netboot.xyz/ipxe/netboot.xyz.iso # GRUB/QEMU/VMware/etc
    https://boot.netboot.xyz/ipxe/netboot.xyz.img # creation of USB Keys
    https://boot.netboot.xyz/ipxe/netboot.xyz.kpxe  # for TFTP or iPXE PCBIOS DHCP

## iPXE

    chain --autofree http://boot.netboot.xyz/ipxe/netboot.xyz.lkrn # Legacy (PCBIOS)/non-UEFI
    chain --autofree http://boot.netboot.xyz/ipxe/netboot.xyz.efi # uses built-in iPXE NIC drivers

## Self Hosting
https://netboot.xyz/docs/docker  
https://netboot.xyz/docs/selfhosting

# Windows
customize and modify wim files: http://hello.wimbuilder.world

    # check build version： WinNTSetup or dism
    dism /Get-WimInfo /WimFile:e:\sources\install.wim /index:2

## Remote install ISO
支持安装网络上的微软原版iso （win7/8/10/x64/x86): https://github.com/zwj4031/netgrubfm/  
支持启动WIM、ISO、IMG、RAMOS、ISCSI的网启模板(BIOS/UEFI): https://github.com/zwj4031/ipxefm  

## Server - Windows
http://tftpd32.jounin.net/tftpd32_download.html

# Mikrotik

    add code=66 name=next-server value="'192.168.88.248'"
    add code=67 name=boot-file value="'CentOS-7-x86_64-NetInstall-1810.iso'"

## Mikrotik + Windows
https://gist.github.com/PatrickLang/d891d4ed4bdf1d23ec584c44df7b0478

# Diskless
## Hive OS - Ubuntu
https://hiveon.com/forum/t/hive-os-diskless-pxe/12319

    PXE Server: Debian + 2 Gb of RAM + 4 Gb of free disk
    Diskless rig | BIOS with PXE (netboot, etc) option
        4Gb+ of system RAM for AMD GPU RX 4xx/5xx
        8Gb+ of system RAM for Nvidia cards (unsupported for now)

https://github.com/minershive/hiveos-pxe-diskless

    ./pxe-setup.sh && cd path_to_pxeserver && ./deploy_pxe # show_help() | ubuntu18 --build

## NetBSD
http://www.netbsd.org/docs/network/netboot/

## Windows
? https://linbit.com/blog/booting-diskless-windows-clients-via-windrbd/