<!-- TOC -->

- [Doc](#doc)
- [qm](#qm)
- [Boot](#boot)
- [apt](#apt)
- [Disk](#disk)
    - [raw disk map](#raw-disk-map)
- [iso](#iso)
- [PCI Passthrough](#pci-passthrough)
    - [GPU](#gpu)
    - [SR-IOV](#sr-iov)
- [NUMA](#numa)
- [Scripts](#scripts)

<!-- /TOC -->

# Doc
- v8: https://pve.proxmox.com/pve-docs/pve-admin-guide.pdf
- v7: https://pve.proxmox.com/pve-docs-7/

# qm
https://pve.proxmox.com/pve-docs-7/qm.1.html

    qm list
    qm reset/stop # immediately
    qm reboot/shutdown # clean

# Boot
Serial: follow debian

    pve-efiboot-tool kernel list
    pve-efiboot-tool refresh

# apt
https://pve.proxmox.com/wiki/Package_Repositories#sysadmin_no_subscription_repo

    deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription # 8.x

# Disk

    dmsetup ls --tree
    lvs

    ln -s /var/lib/vz/template/iso/ iso

https://pve.proxmox.com/wiki/Storage
- file + block : zfs

## raw disk map
https://pve.proxmox.com/wiki/Passthrough_Physical_Disk_to_Virtual_Machine_(VM)

    find /dev/disk/by-id/ -type l|xargs -I{} ls -l {}|grep -v -E '[0-9]$' |sort -k11|cut -d' ' -f9,10,11,12
    qm set 100 -scsi2 /dev/disk/by-id/ata-... # add
    qm unlink 100 --idlist scsi2

# iso
    
    ls -lh /var/lib/vz/template/iso/

# PCI Passthrough
- All: https://pve.proxmox.com/wiki/PCI(e)_Passthrough

## GPU
https://pve.proxmox.com/wiki/PCI_Passthrough

## SR-IOV
https://github.com/strongtz/i915-sriov-dkms

    apt install -y sysfsutils && cat /etc/sysfs.conf | grep -v ^#
    cd /sys/devices/pci0000:00/0000:00:02.0 && grep '' sriov*

    dmesg | grep VF
    lspci | grep VGA

Windows Guest: All Functions + Advanced(click all)

# NUMA
https://pve.proxmox.com/wiki/NUMA

    numactl --hardware # both host & vm

# Scripts
https://tteck.github.io/Proxmox/

