<!-- TOC -->

- [Compare](#compare)
- [Check info](#check-info)
- [Convert between MBR and GPT](#convert-between-mbr-and-gpt)
- [mkpart, format](#mkpart-format)
- [NTFS](#ntfs)
- [mount/umount](#mountumount)
    - [fstab](#fstab)
- [LVM](#lvm)
    - [Check lv filesystem](#check-lv-filesystem)
    - [Rename](#rename)
    - [Create](#create)
    - [Activate vg](#activate-vg)
    - [Add disk to vg](#add-disk-to-vg)
    - [Resize fs](#resize-fs)
- [btrfs](#btrfs)
- [Swap](#swap)
- [Benchmark](#benchmark)
    - [fio](#fio)
- [SMART](#smart)

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
https://wiki.archlinux.org/index.php/Parted

    parted -s /dev/sdb mklabel gpt
    parted -s /dev/sdb unit mib mkpart primary 0% 100% / 1MiB 512MiB

    mkpart primary fat32 1MiB 512MiB
    set 1 esp on
    
    mkfs.ext4 /dev/sdb1

# NTFS
https://wiki.archlinux.org/index.php/NTFS-3G

# mount/umount
    mount -o loop,ro x.iso /mnt/cd
    mount -o rw,remount /   # recovery
    umount -l /PATH/OF/BUSY-DEVICE

## fstab

    cat /proc/mounts    # list mounted

    /dev/vdb1               /root/data       ext4    defaults,noatime 0 0
    /dev/cdrom              /media/CentOS           auto    user,noauto,exec,utf8        0    0
    //192.168.88.10/_ISO /mnt/ISO/ cifs username=user,password=pwd 0 0
    //servername/sharename /media/windowsshare cifs guest,uid=1000,iocharset=utf8 0 0
    /dev/mapper/x--vg--root /home           btrfs   defaults,subvol=@home 0       2
    /dev/sda2       /mymnt/win   ntfs-3g  rw,umask=0000,defaults 0 0

<dump> is checked by the dump(ext2/3 filesystem backup) utility. This field is usually set to 0, which disables the check.
<fsck>/<pass> sets the order for filesystem checks at boot time; see fsck(8). 
1 for the root device, 2 for other partitions, 0 to disable checking. 
[Arch] If the root file system is btrfs, set to 0 instead of 1.

# LVM

    lsblk -o NAME,TYPE,FSTYPE,MOUNTPOINT,RM,MAJ:MIN,UUID
    pvs -o+vg_uuid,UUID
    vgs -o+vg_uuid  
    pvdisplay -v -m

## Check lv filesystem
    file -s /dev/vg1/lv1

## Rename
    vgrename $vg_uuid new-vg-name

## Create
    vgcreate vg-name /dev/sdc3
    lvcreate -L 80G wd500-vg -n data
    mkfs.btrfs /dev/mapper/wd500--vg-data
    mount /dev/mapper/wd500--vg-data /data2
    echo $(cat /proc/mounts | tail -n 1) >> /etc/fstab ; ls /etc/fstab ;

## Activate vg
    vgchange -ay

## Add disk to vg
    pvcreate /dev/sdb   # delete all partitions first
    vgextend ubuntu-vg /dev/sdb

## Resize fs
PV thrink: gparted

    lvresize -L +20G /dev/debian9-vg/root # -r, --resizefs
    resize2fs /dev/dlvebian9-vg/root

    yum install e4fsprogs
    resize4fs /dev/debian9-vg/root # resize ext4 if resize2fs error: Filesystem has unsupported feature(s)

    lvextend --resize-fs -l +100%FREE /dev/debian9-vg/root 

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
     --size=512M --runtime=5

# SMART
https://wiki.archlinux.org/index.php/S.M.A.R.T.

    smartctl --info /dev/sdf
    
    smartctl --test=short /dev/sdf     

    smartctl --all /dev/sdf

    smartctl -l selftest /dev/sdf
    smartctl -l xerror /dev/sdf
    -l TYPE, --log=TYPE
            Show device log. TYPE: error, selftest, selective, directory[,g|s],
                                xerror[,N][,error], xselftest[,N][,selftest],
                                background, sasphy[,reset], sataphy[,reset],
                                scttemp[sts,hist], scttempint,N[,p],
                                scterc[,N,M], devstat[,N], ssd,
                                gplog,N[,RANGE], smartlog,N[,RANGE]
