<!-- TOC -->

- [qemu-img](#qemu-img)
    - [Windows](#windows)
    - [Linux](#linux)
- [IOMMU](#iommu)
    - [GRUB](#grub)
- [KVM/libvirt](#kvmlibvirt)
    - [Pool](#pool)
    - [Driver](#driver)
    - [MacVTap](#macvtap)
    - [Shutdown timeout](#shutdown-timeout)
    - [Nested](#nested)
    - [VT-d](#vt-d)
    - [UEFI](#uefi)
    - [virsh](#virsh)
    - [GPU assignment](#gpu-assignment)
- [Intel® Graphics Virtualization Technology](#intel®-graphics-virtualization-technology)
    - [GVT-g](#gvt-g)
        - [KVMGT](#kvmgt)
- [SPICE & QXL guest driver](#spice--qxl-guest-driver)
- [VDI Solutions - Nvidia](#vdi-solutions---nvidia)
    - [Virtualized Application Solutions (Shared GPU)](#virtualized-application-solutions-shared-gpu)
    - [Virtual Desktop Solutions (Shared GPU)](#virtual-desktop-solutions-shared-gpu)
    - [Virtual Remote Workstation Solutions (Dedicated GPU)](#virtual-remote-workstation-solutions-dedicated-gpu)
- [VDI Solutions - Open Source](#vdi-solutions---open-source)
- [VSphere / ESXi](#vsphere--esxi)
    - [Raw disk mapping (RDM)](#raw-disk-mapping-rdm)
    - [Config](#config)
        - [Backup](#backup)
        - [Restore](#restore)
    - [vmdk](#vmdk)
- [Vagrant](#vagrant)
- [LXD](#lxd)
- [oVirt](#ovirt)

<!-- /TOC -->

# qemu-img
## Windows
https://cloudbase.it/qemu-img-windows/

## Linux
    qemu-img -h | tail -n1  # Supported formats
    tar -xvf x.ova
    qemu-img convert -O qcow2 x.vmdk x.qcow2

# IOMMU
https://pve.proxmox.com/wiki/Pci_passthrough
https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF
https://github.com/awilliam/rom-parser

## GRUB
    vi /etc/default/grub
        GRUB_CMDLINE_LINUX_DEFAULT="intel_iommu=on kvm-intel.nested=1 modprobe.blacklist=megaraid_sas"
    update-grub

# KVM/libvirt
## Pool
    virsh pool-edit default     # debian 9 default: /var/lib/libvirt/images/

## Driver
https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso  
baloon (dynamic memory management)： https://pve.proxmox.com/wiki/Dynamic_Memory_Management

## MacVTap
http://virt.kernelnewbies.org/MacVTap  
 `private` mode exists that behaves like a `VEPA` mode endpoint in the absence of a hairpin aware switch. Most switches today do not support hairpin mode.      
 ![](https://seravo.fi/wp-content/uploads/2012/10/hairpin.png)   
 `Bridge`, connecting all endpoints directly to each other. when inter-guest communication is performance critical.

https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Virtualization_Administration_Guide/sect-attch-nic-physdev.html    
`passthrough` attaches a virtual function of a SRIOV capable NIC directly to a VM **without losing the migration capability**.

https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Virtualization_Host_Configuration_and_Guest_Installation_Guide/App_Macvtap.html  
when a guest virtual machine is configured to use a type='direct' network interface such as macvtap, ..., the guest cannot communicate with its own host.

## Shutdown timeout
    vi /etc/init.d/libvirt-guests
        ON_SHUTDOWN=shutdown
        SHUTDOWN_TIMEOUT=10

    systemctl enable libvirt-guests.service

## Nested
    cat /sys/module/kvm_intel/parameters/nested

    apt install sysfsutils
    systool -m kvm_intel -v | grep nested

booting with `kvm-intel.nested=1` argument on the kernel command line, or:

    sudo rmmod kvm-intel
    sudo sh -c "echo 'options kvm-intel nested=y' >> /etc/modprobe.d/dist.conf"
    sudo modprobe kvm-intel

    sudo rmmod kvm-amd
    sudo sh -c "echo 'options kvm-amd nested=1' >> /etc/modprobe.d/dist.conf"
    sudo modprobe kvm-amd

virt-manager：enable `Copy host CPU configuration` checkbox 

## VT-d
    echo '0000:42:00.1' | sudo tee /sys/bus/pci/devices/0000:42:00.1/driver/unbind
    echo 8086 1d02 | sudo tee /sys/bus/pci/drivers/vfio-pci/new_id

## UEFI
    apt install -y ovmf
    systemctl restart libvirtd
    # select UEFI while creating VM

## virsh
    virsh list --all

    virsh domxml-to-native qemu-argv demo.xml > demo.sh
    virsh domxml-from-native qemu-argv demo.args > demo.xml

## GPU assignment
https://www.linux-kvm.org/images/b/b3/01x09b-VFIOandYou-small.pdf
https://wiki.debian.org/VGAPassthrough

# Intel® Graphics Virtualization Technology
![](https://01.org/sites/default/files/users/u16902/graphics_virtualization_update_figure_1.png) 
![](https://01.org/sites/default/files/users/u16902/graphics_virtualization_update_figure_2.png) 
![](https://01.org/sites/default/files/users/u16902/graphics_virtualization_update_figure_3.png)

* –d (Intel® GVT –d): vDGA: virtual dedicated graphics acceleration (one VM to one physical GPU)
* –s (Intel® GVT -s): vSGA: virtual shared graphics acceleration (multiple VMs to one physical GPU)
* –g (Intel® GVT -g): vGPU: virtual graphics processing unit (multiple VMs to one physical GPU)

## GVT-g
https://01.org/igvt-g/blogs/wangbo85/2017/intel-gvt-g-kvmgt-public-release-q22017  
kernel 4.10+ / QEMU 2.9+ / Xeon(r) E3_v4 and E3_v5 / Core(tm) Gen 5th(Broadwell)+  
X11VNC for Linux guest  
TightVNC, HP RGS, RDP for Windows guest  

https://github.com/intel/gvt-linux/wiki/GVTg_Setup_Guide  
For KVMGT, you also can use the current upstream Linux kernel and QEMU directly since all the enabling patches have been upstreamed.  
For XenGT, you must use the repositories we provided.

### KVMGT
grub：  intel_iommu=igfx_off i915.hvm_boot_foreground=1 i915.enable_gvt=1 kvm.ignore_msrs=1

# SPICE & QXL guest driver
https://www.spice-space.org/download.html

# VDI Solutions - Nvidia
http://www.nvidia.com/object/xendesktop-vgpu.html
(Right bottom section: "Partner Solutions")

## Virtualized Application Solutions (Shared GPU)
Citrix XenApp 6.5 with OpenGL Add-on and Citrix XenDesktop 7 Hosted-Shared delivery

## Virtual Desktop Solutions (Shared GPU)
XenDesktop FP1 with NVIDIA GRID™ vGPU™1
Microsoft RemoteFX in Windows Server 2012
VMware Horizon View 5.2 with vSGA2

## Virtual Remote Workstation Solutions (Dedicated GPU)
Citrix XenDesktop 5.6 
Citrix XenDesktop 7 VDI delivery
VMware View 5.3 with vDGA

# VDI Solutions - Open Source
https://www.openstack.org/videos/boston-2017/virtual-desktop-infrastructure-vdi-with-openstack

https://guacamole.incubator.apache.org/
https://hub.docker.com/r/guacamole/guacamole/
HTML5 remote desktop gateway. supports VNC, RDP, and SSH.

# VSphere / ESXi
## Raw disk mapping (RDM)
    ls -alh /vmfs/devices/disks
    vmkfstools -r /vmfs/devices/disks/<device> example.vmdk
    vmkfstools -z /vmfs/devices/disks/<device> example.vmdk

[Ref](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1026256)

## Config
[Ref](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=2042141)

### Backup
`vim-cmd hostsvc/firmware/backup_config`

### Restore
    vim-cmd hostsvc/maintenance_mode_enter
    vim-cmd hostsvc/firmware/restore_config /tmp/configBundle.tgz

## vmdk
    vmkfstools -i "source.vmdk" -d thin "destination.vmdk"

The tool also reverts a vmdk which was blown up, back into a thin file! ([Ref](http://www.how2blog.de/?p=98))


# Vagrant
https://atlas.hashicorp.com/boxes/  
Get Direct link: https://github.com/everyx/vagrant-box-download-helper-everyx.user.js

    sudo apt-get install vagrant 
    sudo apt-get install libz-dev
    vagrant plugin install vagrant-mutate
    vagrant mutate http://files.vagrantup.com/precise32.box libvirt
    vagrant plugin install vagrant-libvirt

    vagrant plugin install vagrant-lxc

    vagrant box add hashicorp/precise64 && tar *.box -C out_folder

# LXD
https://www.ubuntu.com/cloud/lxd
http://insights.ubuntu.com/2016/03/14/the-lxd-2-0-story-prologue/
https://insights.ubuntu.com/2016/04/13/stephane-graber-lxd-2-0-docker-in-lxd-712/  

https://github.com/lxc/lxd#how-can-i-run-docker-inside-a-lxd-container

# oVirt
    yum install http://resources.ovirt.org/pub/yum-repo/ovirt-release41.rpm
    yum -y install ovirt-engine
    engine-setup
