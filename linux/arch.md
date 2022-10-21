- [Install](#install)

# Install
https://wiki.archlinux.org/title/installation_guide#Verify_the_boot_mode

    # sshd started by default, `passwd root` to login
    ls /sys/firmware/efi/efivars
    vi /etc/pacman.d/mirrorlist
    pacstrap -K /mnt base linux linux-firmware
    genfstab -U /mnt >> /mnt/etc/fstab
    arch-chroot /mnt