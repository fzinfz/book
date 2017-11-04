<!-- TOC -->

- [qemu-img](#qemu-img)
    - [Windows](#windows)
    - [Linux](#linux)
- [KVM/libvirt](#kvmlibvirt)
    - [Pool](#pool)
    - [Driver](#driver)
    - [MacVTap](#macvtap)
    - [Shutdown timeout](#shutdown-timeout)
    - [Nested](#nested)
    - [VT-d](#vt-d)
    - [GPU Passthrough](#gpu-passthrough)
- [VSphere / ESXi](#vsphere--esxi)
    - [Raw disk mapping (RDM)](#raw-disk-mapping-rdm)
    - [Config](#config)
        - [Backup](#backup)
        - [Restore](#restore)
    - [vmdk](#vmdk)
- [Vagrant](#vagrant)
- [Openstack](#openstack)
    - [Hardware requirements & design](#hardware-requirements--design)
    - [devstack](#devstack)
    - [Images](#images)
    - [Ubuntu](#ubuntu)
- [LXD](#lxd)
- [IOMMU](#iommu)
- [GRUB](#grub)
- [VDI](#vdi)
    - [Virtualized Application Solutions (Shared GPU)](#virtualized-application-solutions-shared-gpu)
    - [Virtual Desktop Solutions (Shared GPU)](#virtual-desktop-solutions-shared-gpu)
    - [Virtual Remote Workstation Solutions (Dedicated GPU)](#virtual-remote-workstation-solutions-dedicated-gpu)
    - [Solutions](#solutions)
- [oVirt](#ovirt)
- [RDO/Packstack](#rdopackstack)

<!-- /TOC -->

# qemu-img
## Windows
https://cloudbase.it/qemu-img-windows/

## Linux
    qemu-img -h | tail -n1  # Supported formats
    tar -xvf x.ova
    qemu-img convert -O qcow2 x.vmdk x.qcow2

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

## GPU Passthrough

    virsh domxml-to-native qemu-argv demo.xml > demo.sh

    cat > demo.args <<EOF
    LC_ALL=C PATH=/bin HOME=/home/test USER=test \
    LOGNAME=test /usr/bin/qemu -S -M pc -m 214 -smp 1 \
    -nographic -monitor pty -no-acpi -boot c -hda \
    /dev/HostVG/QEMUGuest1 -net none -serial none \
    -parallel none -usb
    EOF

    virsh domxml-from-native qemu-argv demo.args > demo.xml

    virsh list --all

    vi /etc/libvirt/qemu/VM_NAME.xml

        <features>
            ...
            <kvm>
            <hidden state='on'/>
            </kvm>
        </features>

        <qemu:commandline>
        <qemu:arg value='-set'/>
        <qemu:arg value='device.hostdev0.x-vga=on'/>
        </qemu:commandline>

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


# Openstack
## Hardware requirements & design
https://docs.openstack.org/newton/install-guide-rdo/overview.html#example-architecture
at least two nodes (hosts):controller(2 NICs) + compute(2 NICs)  
Optional services such as Block Storage and Object Storage require additional nodes.

## devstack
http://docs.openstack.org/developer/devstack/guides/single-machine.html
Use of postgresql in devstack is deprecated, and will be removed during the Pike cycle

    export GIT_BASE=http://github.com  # fix git clone hangs issue
    export no_proxy=127.0.0.1,192.168.88.15    # don't use *; fix: Could not determine a suitable URL for the plugin

    sudo useradd -s /bin/bash -d /opt/stack -m stack
    echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
    sudo su - stack
    git clone https://git.openstack.org/openstack-dev/devstack

    ./stack.sh:main:224     xenial|yakkety|zesty|stretch|jessie|f24|f25|f26|opensuse-42.2|opensuse-42.3|rhel7|kvmibm1

http://docs.openstack.org/developer/openstack-ansible/developer-docs/quickstart-aio.html  
https://developer.rackspace.com/blog/life-without-devstack-openstack-development-with-osa/  

## Images
http://docs.openstack.org/image-guide/obtain-images.html  
http://cdimage.debian.org/cdimage/openstack/
http://linuximages.de/openstack/arch/

## Ubuntu
http://conjure-up.io/docs/en/users/#getting-started
    snap install conjure-up --classic
    conjure-up openstack

# LXD
https://www.ubuntu.com/cloud/lxd
http://insights.ubuntu.com/2016/03/14/the-lxd-2-0-story-prologue/
https://insights.ubuntu.com/2016/04/13/stephane-graber-lxd-2-0-docker-in-lxd-712/  

https://github.com/lxc/lxd#how-can-i-run-docker-inside-a-lxd-container

# IOMMU
https://pve.proxmox.com/wiki/Pci_passthrough
https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF
https://wiki.debian.org/VGAPassthrough

https://github.com/awilliam/rom-parser

# GRUB 
    vi /etc/default/grub
        GRUB_CMDLINE_LINUX_DEFAULT="intel_iommu=on kvm-intel.nested=1 modprobe.blacklist=megaraid_sas"
    update-grub

# VDI
http://www.nvidia.com/object/xendesktop-vgpu.html

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

## Solutions
https://www.openstack.org/videos/boston-2017/virtual-desktop-infrastructure-vdi-with-openstack

https://guacamole.incubator.apache.org/
https://hub.docker.com/r/guacamole/guacamole/
HTML5 remote desktop gateway. supports VNC, RDP, and SSH.

# oVirt
    yum install http://resources.ovirt.org/pub/yum-repo/ovirt-release41.rpm
    yum -y install ovirt-engine
    engine-setup

# RDO/Packstack
https://www.rdoproject.org/install/packstack/    
    sudo systemctl disable firewalld
    sudo systemctl stop firewalld
    sudo systemctl disable NetworkManager
    sudo systemctl stop NetworkManager
    sudo systemctl enable network
    sudo systemctl start network

    yum install -y centos-release-openstack-pike && \
    yum update -y  && \
    yum install -y openstack-packstack && \
    packstack --allinone || packstack --answer-file=FILE
