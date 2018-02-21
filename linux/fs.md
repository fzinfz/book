<!-- TOC -->

- [Compare](#compare)
- [Check info](#check-info)
- [Convert between MBR and GPT](#convert-between-mbr-and-gpt)
- [mkpart, format](#mkpart-format)
- [NTFS](#ntfs)
- [mount/umount](#mountumount)
    - [fstab](#fstab)
    - [NFS performance monitoring and tuning](#nfs-performance-monitoring-and-tuning)
- [LVM, resize fs](#lvm-resize-fs)
    - [Add disk to vg](#add-disk-to-vg)
- [btrfs](#btrfs)
- [Swap](#swap)
- [Benchmark](#benchmark)
    - [fio](#fio)

<!-- /TOC -->

# Compare
https://en.wikipedia.org/wiki/Comparison_of_file_systems

|File system|Host OS|Online grow|Offline grow|Online shrink|Offline shrink|
|---|---|---|---|---|---|
|FAT32(X)|misc.|No|3rd-party|No|3rd-party|
|NTFS|Windows|Yes|Yes|Yes|Yes|
|ReFS|Windows|Yes|?|No|?|
|Btrfs[51]|Linux|Yes|No|Yes|No|
|ext4[52]|Linux|Yes|Yes|No|Yes|
|HFS+|Linux|No|No|No|No|
|HFS+|macOS|Yes|No|Yes|No|
|APFS|macOS|?|?|?|?|
|ZFS|misc.|Yes|No|No|No|
|ReiserFS[59]|Linux|Yes|Yes|No|Yes|
|XFS[60]|Linux|Yes|No|No|No|

# Check info
    lshw -short -C disk
    lshw -class disk -class storage
    lsblk -f # check file system type
    tune2fs -l /dev/sda1 | grep -i count

    gdisk -l /dev/sda  #fdisk many give wrong GPT partiton

    # file -s /dev/vda
        /dev/vda: DOS/MBR boot sector
    # file -s /dev/vda1
        /dev/vda1: Linux rev 1.0 ext4 filesystem data, UUID=... (needs journal recovery) (extents) (large files) (huge files)

# Convert between MBR and GPT
    sudo sgdisk -g /dev/sda
    sudo sgdisk -m /dev/sda
    sudo partprobe -s

# mkpart, format
    parted -s /dev/sdb mklabel gpt
    parted -s /dev/sdb unit mib mkpart primary 0% 100% / 1MiB 512MiB
    mkfs.ext4 /dev/sdb1

# NTFS
https://wiki.archlinux.org/index.php/NTFS-3G

# mount/umount
    mount -o loop,ro x.iso /mnt/cd
    mount.nfs nfs_server:/dir /dir  #  apt install -y nfs-common
    mount -tnfs4 -ominorversion=1 server_nfs_4.1:/dir
    mount -t nfs -o nfsvers=4.1 192.168.4.12:/2T 2T
    mount -v 192.168.88.10:/ /data/  # mount NFS 4.2
    mount -o rw,remount /   # recovery
    umount -l /PATH/OF/BUSY-DEVICE
    umount --force /PATH/OF/BUSY-NFS(NETWORK-FILE-SYSTEM)

## fstab
    /dev/vdb1               /root/data       ext4    defaults,noatime 0 0
    /dev/cdrom              /media/CentOS           auto    user,noauto,exec,utf8        0    0
    //192.168.88.10/_ISO /mnt/ISO/ cifs username=user,password=pwd 0 0
    //servername/sharename /media/windowsshare cifs guest,uid=1000,iocharset=utf8 0 0
    /dev/mapper/x--vg--root /home           btrfs   defaults,subvol=@home 0       2
    /dev/sda2       /mymnt/win   ntfs-3g  rw,umask=0000,defaults 0 0
    NFS_server:/    /data nfs rsize=8192,wsize=8192,timeo=14,intr

<dump> is checked by the dump(ext2/3 filesystem backup) utility. This field is usually set to 0, which disables the check.
<fsck>/<pass> sets the order for filesystem checks at boot time; see fsck(8). 
1 for the root device, 2 for other partitions, 0 to disable checking. 
[Arch] If the root file system is btrfs, set to 0 instead of 1.

## NFS performance monitoring and tuning
https://www.ibm.com/support/knowledgecenter/en/ssw_aix_71/com.ibm.aix.performance/nfs_perf_mon_tun.htm  
http://www.nfsv4bat.org/Documents/ConnectAThon/2013/NewGenerationofTesting-v2.pdf

# LVM, resize fs
    pvs
    pvdisplay -v -m
    lvcreate -L 80G ubuntu-vg -n data

    lvresize -L +20G /dev/debian9-vg/root
    resize2fs /dev/debian9-vg/root

    yum install e4fsprogs
    resize4fs /dev/debian9-vg/root # resize ext4 if resize2fs error: Filesystem has unsupported feature(s)

    lvextend --resize-fs -l +100%FREE /dev/debian9-vg/root 

## Add disk to vg
    pvcreate /dev/sdb   # delete all partitions first
    vgextend ubuntu-vg /dev/sdb

# btrfs
    btrfs filesystem resize +60G /data
    btrfs filesystem usage /
    dmesg | grep crc32c # verify if Btrfs checksum is hardware accelerated, e.g.: crc32c-intel

# Swap
    swapoff -v /dev/mapper/ubuntu--vg-swap_1
    lvreduce --size -22G /dev/debian9-vg/swap
    mkswap /dev/mapper/ubuntu--vg-swap_1
    swapon -va

    echo /dev/VG/LV swap swap defaults 0 0 >> /etc/fstab

# Benchmark
## fio

    git clone https://github.com/axboe/fio.git && cd fio/examples/

    fio --name=randwrite --ioengine=libaio --group_reporting \
     --iodepth=1 --rw=randwrite \
     --direct=1 --bs=4k --numjobs=8 \
     --size=512M --runtime=30