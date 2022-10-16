- [iPXE](#ipxe)
- [netboot.xyz](#netbootxyz)
  - [USB/ISO/GRUB/TFTP](#usbisogrubtftp)
  - [iPXE](#ipxe-1)
  - [Self Hosting](#self-hosting)
- [Diskless](#diskless)
  - [Hive OS - Ubuntu](#hive-os---ubuntu)
  - [NetBSD](#netbsd)
  - [Windows](#windows)


# iPXE
https://ipxe.org/cmd/chain

Download and boot the iPXE demonstration image
  chain http://boot.ipxe.org/demo/boot.php

# netboot.xyz
https://github.com/netbootxyz/netboot.xyz

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