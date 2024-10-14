- [BL2/FIP](#bl2fip)
- [MTD](#mtd)
- [uboot](#uboot)
- [ubi](#ubi)
- [Breed](#breed)

# BL2/FIP
https://trustedfirmware-a.readthedocs.io/en/latest/design/firmware-design.html
- Boot Loader stage 1 (BL1) AP Trusted ROM
- Boot Loader stage 2 (BL2) Trusted Boot Firmware
- Firmware Image Package

# MTD
calc HEX -> DEC ： 
00400000 = 4MiB
06f00000 = 111MiB

    cat /proc/mtd
    fw_printenv | grep mtdparts

    mtd write .bin FIP # kmod-mtd-rw
    dd if=/tmp/uboot.bin of=/mtd4

# uboot
https://openwrt.org/docs/techref/bootloader/uboot.config

# ubi

    ubinfo -a


# Breed
breed -> openwrt initramfs -> /cgi-bin/luci/admin/system/flashops/sysupgrade