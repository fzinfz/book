<!-- TOC -->

- [IOMMU](#iommu)
    - [Hyper-V DDA](#hyper-v-dda)
- [UI](#ui)
    - [webvirtcloud](#webvirtcloud)
    - [oVirt](#ovirt)
- [Compare](#compare)
- [OVMF (Open Virtual Machine Firmware)](#ovmf-open-virtual-machine-firmware)
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
- [Intel vPro](#intel-vpro)
    - [Q35](#q35)
- [OSX on KVM](#osx-on-kvm)
- [Hyper-V](#hyper-v)
    - [Check support](#check-support)
    - [Turn Off](#turn-off)

<!-- /TOC -->

# IOMMU
check [VDI](./vdi) for GPU passthrough.

https://www.kernel.org/doc/Documentation/Intel-IOMMU.txt  
https://pve.proxmox.com/wiki/Pci_passthrough  
https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF  
https://github.com/awilliam/rom-parser  
https://github.com/systemdaemon/systemd/blob/master/src/linux/Documentation/vfio.txt

    intel_iommu=on kvm-intel.nested=1

## Hyper-V DDA
https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/plan/plan-for-deploying-devices-using-discrete-device-assignment#machine-profile-script

# UI
https://www.linux-kvm.org/page/Management_Tools (Most outdated)

## webvirtcloud
https://github.com/retspen/webvirtcloud

#`# oVirt
https://www.ovirt.org/download/  
Engine running as a Virtual Machine on that Host: RHEL/CentOS

# Compare
|vendor|storage|
|:---:|:---:|
|PVE|LVM-thin/ZFS|
|libvirtd|qcow2|

# OVMF (Open Virtual Machine Firmware)
http://www.linux-kvm.org/downloads/lersek/ovmf-whitepaper-c770f8c.txt  
a sub-project of Intel's EFI Development Kit II (edk2)

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

# Intel vPro
https://en.wikipedia.org/wiki/Intel_vPro  
Intel vPro technology is an umbrella marketing term used by Intel for a large collection of computer hardware technologies, including Hyperthreading, Turbo Boost 3.0, VT-x, VT-d, Trusted Execution Technology (TXT), and Intel Active Management Technology (AMT).[1] When the vPro brand was launched (circa 2007), it was identified primarily with AMT,[2][3] thus some journalists still consider AMT to be the essence of vPro.[4]

## Q35
https://www.linux-kvm.org/images/0/06/2012-forum-Q35.pdf

    Q35 has IOMMU
    Q35 has PCIe Switches vs PCI Bridges (I440FX/PIIX4) 

https://wiki.qemu.org/Features/Q35

# OSX on KVM
https://github.com/kholia/OSX-KVM

https://www.contrib.andrew.cmu.edu/~somlo/OSXKVM/

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