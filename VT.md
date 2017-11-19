<!-- TOC -->

- [IOMMU](#iommu)
- [KVM/libvirt](#kvmlibvirt)
    - [Pool](#pool)
    - [Driver](#driver)
    - [MacVTap](#macvtap)
    - [Shutdown timeout](#shutdown-timeout)
    - [Nested](#nested)
    - [vfio](#vfio)
        - [Raw disk mapping](#raw-disk-mapping)
    - [GRUB](#grub)
    - [UEFI](#uefi)
    - [virsh](#virsh)
- [VSphere / ESXi](#vsphere--esxi)
    - [Raw disk mapping (RDM)](#raw-disk-mapping-rdm)
    - [Config](#config)
        - [Backup](#backup)
        - [Restore](#restore)
    - [vmdk](#vmdk)
    - [Inject driver](#inject-driver)
- [Vagrant](#vagrant)
- [LXD](#lxd)
- [oVirt](#ovirt)
- [Intel vPro](#intel-vpro)
- [qemu-system](#qemu-system)
- [qemu-img](#qemu-img)
    - [Windows](#windows)
    - [Linux](#linux)
- [Hyper-V](#hyper-v)
    - [Check support](#check-support)
    - [Turn Off](#turn-off)

<!-- /TOC -->

# IOMMU
https://pve.proxmox.com/wiki/Pci_passthrough
https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF
https://github.com/awilliam/rom-parser

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

## vfio
https://www.kernel.org/doc/Documentation/vfio.txt

    echo '0000:42:00.1' | sudo tee /sys/bus/pci/devices/0000:42:00.1/driver/unbind
    echo 8086 1d02 | sudo tee /sys/bus/pci/drivers/vfio-pci/new_id

### Raw disk mapping
    <disk type='block' device='disk'>
        <driver name='qemu' type='raw'/>
        <source dev='/dev/md/storage'/>
        <target dev='vdb' bus='virtio'/>
    </disk>

## GRUB
    vi /etc/default/grub
        GRUB_CMDLINE_LINUX_DEFAULT="intel_iommu=on kvm-intel.nested=1 modprobe.blacklist=megaraid_sas"
    update-grub

## UEFI
    apt install -y ovmf
    systemctl restart libvirtd
    # select UEFI while creating VM

## virsh
    virsh list --all

    virsh domxml-to-native qemu-argv demo.xml > demo.sh
    virsh domxml-from-native qemu-argv demo.args > demo.xml

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

## Inject driver
http://www.v-front.de/2014/12/how-to-make-your-unsupported-nic-work.html  
https://vibsdepot.v-front.de/wiki/index.php/List_of_currently_available_ESXi_packages  
http://www.v-front.de/p/esxi-customizer-ps.html

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

# Intel vPro
https://en.wikipedia.org/wiki/Intel_vPro  
Intel vPro technology is an umbrella marketing term used by Intel for a large collection of computer hardware technologies, including Hyperthreading, Turbo Boost 3.0, VT-x, VT-d, Trusted Execution Technology (TXT), and Intel Active Management Technology (AMT).[1] When the vPro brand was launched (circa 2007), it was identified primarily with AMT,[2][3] thus some journalists still consider AMT to be the essence of vPro.[4]

# qemu-system
    qemu-system-aarch64       qemu-system-m68k          qemu-system-mipsel        qemu-system-s390x         qemu-system-unicore32
    qemu-system-alpha         qemu-system-microblaze    qemu-system-moxie         qemu-system-sh4           qemu-system-x86_64
    qemu-system-arm           qemu-system-microblazeel  qemu-system-or32          qemu-system-sh4eb         qemu-system-x86_64-spice
    qemu-system-cris          qemu-system-mips          qemu-system-ppc           qemu-system-sparc         qemu-system-xtensa
    qemu-system-i386          qemu-system-mips64        qemu-system-ppc64         qemu-system-sparc64       qemu-system-xtensaeb
    qemu-system-lm32          qemu-system-mips64el      qemu-system-ppcemb        qemu-system-tricore      

    # qemu-system-x86_64 -M ?
    Supported machines are:
    pc                   Standard PC (i440FX + PIIX, 1996) (alias of pc-i440fx-2.9)
    pc-i440fx-2.9        Standard PC (i440FX + PIIX, 1996) (default)
    q35                  Standard PC (Q35 + ICH9, 2009) (alias of pc-q35-2.9)
    isapc                ISA-only PC
    none                 empty machine

# qemu-img
## Windows
https://cloudbase.it/qemu-img-windows/

## Linux
    qemu-img -h | tail -n1  # Supported formats
    tar -xvf x.ova
    qemu-img convert -O qcow2 x.vmdk x.qcow2    

# Hyper-V
## Check support
    systeminfo

## Turn Off
```
C:\>bcdedit /copy {current} /d "No Hyper-V" 
The entry was successfully copied to {ff-23-113-824e-5c5144ea}. 

C:\>bcdedit /set {ff-23-113-824e-5c5144ea} hypervisorlaunchtype off 
The operation completed successfully.
```