<!-- TOC -->

- [Compare](#compare)
- [Check info](#check-info)
- [Convert between MBR and GPT](#convert-between-mbr-and-gpt)
- [mkpart, format](#mkpart-format)
- [mount/umount](#mountumount)
    - [fstab](#fstab)
- [LVM](#lvm)
    - [Check lv filesystem](#check-lv-filesystem)
    - [Rename](#rename)
    - [Create](#create)
    - [Activate vg](#activate-vg)
    - [Add disk to vg](#add-disk-to-vg)
    - [Remove disk from vg](#remove-disk-from-vg)
    - [lv operations](#lv-operations)
    - [Resize fs](#resize-fs)
- [btrfs](#btrfs)
- [f2fs](#f2fs)
- [NTFS](#ntfs)
- [Swap](#swap)
- [Benchmark](#benchmark)
    - [dd](#dd)
    - [fio](#fio)
- [SMART](#smart)
- [SAMBA](#samba)

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

# mount/umount

    mount -o rw,remount /   # recovery
    umount -l /PATH/OF/BUSY-DEVICE

    mount -o loop,ro $path $mount_point # ISO
    
    mount.nfs $1:$2 $3
    mount -tnfs4 -ominorversion=1 server_nfs_4.1:/dir\

    echo $path $mount_point cifs username=$user,password=$passwd 0 0 >>  /etc/fstab # SMB

## fstab
Loss NAS mount may cause hang!

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
    
    pvdisplay -v -m

                Wiping internal VG cache
                Wiping cache of LVM-capable devices
            --- Physical volume ---
            PV Name               /dev/sde1
            VG Name               wd500-vg
            PV Size               <422.53 GiB / not usable 0   
            Allocatable           yes 
            PE Size               4.00 MiB
            Total PE              108167
            Free PE               5523
            Allocated PE          102644
            PV UUID               nPoenO-vin9-wkZF-4Dxh-5WT2-yU3f-EtAMs5
            
            --- Physical Segments ---
            Physical extent 0 to 5522:
                FREE
            Physical extent 5523 to 95122:
                Logical volume	/dev/wd500-vg/data
                Logical extents	0 to 89599
            Physical extent 95123 to 95366:
                Logical volume	/dev/wd500-vg/swap_1
                Logical extents	0 to 243
            Physical extent 95367 to 108166:
                Logical volume	/dev/wd500-vg/data
                Logical extents	89600 to 102399

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

## Remove disk from vg
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/5/html/logical_volume_manager_administration/disk_remove_ex

    pvmove /dev/sdb1
    vgreduce myvg /dev/sdb1

## lv operations

    lvremove sandisk-u2/mint

## Resize fs
PV thrink: gparted

    lvresize -L +20G /dev/debian9-vg/root # -r, --resizefs
    resize2fs /dev/dlvebian9-vg/root

    yum install e4fsprogs
    resize4fs /dev/debian9-vg/root # resize ext4 if resize2fs error: Filesystem has unsupported feature(s)

    lvextend --resize-fs --extents +100%FREE vg/lv # not support btrfs

# btrfs
    btrfs filesystem resize +60G /data # use gparted for shrink
    btrfs filesystem usage /
    btrfs device usage /data

    dmesg | grep crc32c # verify if Btrfs checksum is hardware accelerated, e.g.: crc32c-intel

# f2fs
https://www.kernel.org/doc/Documentation/filesystems/f2fs.txt

# NTFS
https://wiki.archlinux.org/index.php/NTFS-3G

# Swap
    swapoff -v /dev/mapper/ubuntu--vg-swap_1
    lvreduce --size -22G /dev/debian9-vg/swap
    mkswap /dev/mapper/ubuntu--vg-swap_1
    swapon -va

    echo /dev/VG/LV swap swap defaults 0 0 >> /etc/fstab

# Benchmark
## dd
    
        dd if=/dev/zero of=/tmp/test_iops bs=512  count=10000 oflag=direct
        dd if=/dev/zero of=/tmp/test_bw   bs=200M count=1     oflag=direct

## fio

    git clone https://github.com/axboe/fio.git && cd fio/examples/

    fio --name=randwrite --ioengine=libaio --group_reporting \
     --iodepth=1 --rw=randwrite \
     --direct=1 --bs=4k --numjobs=8 \
     --size=512M --runtime=5

# SMART

    apt install smartmontools

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


# SAMBA
docker

    docker run  --restart=unless-stopped --net host --name samba  \ 
        -v /data:/data -d \
        dperson/samba -p -s "public;/data;yes;no"

apt

    apt install samba
    vi /etc/samba/smb.conf

    [public]
        comment = public anonymous access
        path = /data
        browsable =yes
        create mask = 0660
        directory mask = 0771
        writable = yes
        guest ok = yes
      
    service smbd restart