<!-- TOC -->

- [OVMF (Open Virtual Machine Firmware)](#ovmf-open-virtual-machine-firmware)
- [IOMMU](#iommu)
- [Xen vs KVM](#xen-vs-kvm)
- [Xen](#xen)
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
    - [Releases](#releases)
    - [Q35](#q35)
- [OSX on KVM](#osx-on-kvm)
- [qemu-img](#qemu-img)
    - [Windows](#windows)
    - [Linux](#linux)
- [Hyper-V](#hyper-v)
    - [Check support](#check-support)
    - [Turn Off](#turn-off)

<!-- /TOC -->

# OVMF (Open Virtual Machine Firmware)
http://www.linux-kvm.org/downloads/lersek/ovmf-whitepaper-c770f8c.txt  
a sub-project of Intel's EFI Development Kit II (edk2)

# IOMMU
https://www.kernel.org/doc/Documentation/Intel-IOMMU.txt  
https://pve.proxmox.com/wiki/Pci_passthrough  
https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF  
https://github.com/awilliam/rom-parser  
https://github.com/systemdaemon/systemd/blob/master/src/linux/Documentation/vfio.txt

# Xen vs KVM
http://drsalbertspijkers.blogspot.co.uk/2017/05/kvm-kernel-virtual-machine-or-xen.html  
![](https://4.bp.blogspot.com/-we18-TvbbgE/WSfqL65mC6I/AAAAAAAACeA/lcC-3Xn6vxcXVdQb1_BR7PklQu4doFWdQCLcB/s640/virtualization_xen_kvm.png)

# Xen
https://www.xenproject.org/users/getting-started.html  
Xen Project and Performance

https://wiki.xenproject.org/wiki/Compiling_Xen_From_Source

    apt-get build-dep xen   # `deb-src` required
    make xenconfig # kernel 4.2+

https://wiki.debian.org/Xen

    apt-get install xen-system

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

## Releases
https://wiki.qemu.org/ChangeLog

    2.11
        KVM can advertise Hyper-V frequency MSRs when the TSC frequency is stable and known
        QXL adds support for chunked cursors.
        Support for generic PCIe to PCI bridge device pcie-pci-bridge, which supports SHPC and can replace the i82801b11 DMI to PCI bridge.
        PCI bridges can pass information to the firmware regarding reservation of bus numbers, IO space and memory.
        Support for TPM emulator
        Experimental support for NVIDIA GPUDirect Cliques
    2.10.0 - Debian 10 & Ubuntu 17.10 artful 18.04 bionic
        QEMU is broken since 2.10 with Linux kernels < v3.15
        Support for Solaris 9 and earlier has been removed.
        qxl and virtio-gpu support two new properties for the default display resolution, xres and yres
        Support for the vxhs(Veritas HyperScale) network protocol
        "qemu-img resize" supports preallocation of the new parts of the image.
        additional docker targets have been added which allow cross compilation build tests for arm, powerpc and mips. Run "make docker" for help.
    2.8 - Debian 9 stretch / 8 jessie-backports & Ubuntu 17.04 zesty/zesty-updates
    2.5 - Ubuntu 16.04 xenial/xenial-updates
    2.1 - Debian 8 jessie
    2.0 - Ubuntu 14.04 trusty/trusty-updates


## Q35
https://www.linux-kvm.org/images/0/06/2012-forum-Q35.pdf

    Q35 has IOMMU
    Q35 has PCIe Switches vs PCI Bridges (I440FX/PIIX4) 

https://wiki.qemu.org/Features/Q35

# OSX on KVM
https://github.com/kholia/OSX-KVM

https://www.contrib.andrew.cmu.edu/~somlo/OSXKVM/

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