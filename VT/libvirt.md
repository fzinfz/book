<!-- TOC -->

- [Releases](#releases)
- [install](#install)
- [Config](#config)
- [Debug](#debug)
- [virsh](#virsh)
- [snapshot](#snapshot)
- [Pool](#pool)
- [Driver](#driver)
- [OVS](#ovs)
- [MacVTap](#macvtap)
- [Linux bridge](#linux-bridge)
- [VLAN](#vlan)
    - [Macvlan Bridge](#macvlan-bridge)
    - [OVS - VLAN tagging transparent](#ovs---vlan-tagging-transparent)
- [Shutdown timeout](#shutdown-timeout)
- [Nested](#nested)
- [virtiofs](#virtiofs)
- [vfio](#vfio)
    - [Raw disk mapping](#raw-disk-mapping)
- [GRUB](#grub)
- [UEFI](#uefi)
- [Troubleshooting](#troubleshooting)

<!-- /TOC -->

# Releases
https://libvirt.org/news.html

    v3.10.0 (unreleased)
        qemu: Add vmcoreinfo feature
            Starting with QEMU 2.11, the guest can save kernel debug details when this feature is enabled and the kernel supports it.
    3.9.0 (2017-11-02) - Debian 10 buster / sid
    v3.8.0 (2017-10-04)
    v3.7.0 (2017-09-04)
        bhyve: Support autoport for VNC ports
        qemu: Added support for setting heads of virtio GPU
    v3.6.0 (2017-08-02) - Ubuntu 17.10 artful / 18.04 bionic
        Handle hotplug change on VLAN configuration using OVS
        fix some minor bugs when using 'host-model' CPU.
    v3.0.0 (2017-01-17) - Debian 9 stretch & 8 jessie-backports
    v2.5.0 (2016-12-04) - Ubuntu 17.04 zesty

# install
https://help.ubuntu.com/community/KVM/Installation

    kvm-ok
    apt-get install qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils
    systemctl status libvirtd

# Config

    cd /etc/libvirt/qemu && virsh define foo.xml

https://wiki.libvirt.org/page/FAQ#Where_are_VM_config_files_stored.3F_How_do_I_edit_a_VM.27s_XML_config.3F

# Debug
https://fedoraproject.org/wiki/How_to_debug_Virtualization_problems

    virt-host-validate
    virsh capabilities

http://events.linuxfoundation.org/sites/events/files/slides/Debugging-libvirt-QEMU-in-OpenStack-2015-CloudOpen-Eu.pdf

    /etc/libvirt/libvirtd.conf
        log_filters="1:qemu 1:libvirt 3:security 3:event 3:util 3:file" log_outputs="1:file:/var/log/libvirt/libvirtd.log"
    systemctl restart libvirtd

https://libvirt.org/logging.html

    export LIBVIRT_DEBUG=1
    export LIBVIRT_LOG_FILTERS="1:qemu 1:libvirt"
    export LIBVIRT_LOG_OUTPUTS="1:journald 1:file:/tmp/virsh.log"

    LIBVIRT_LOG_FILTERS:
        x:name  (log message only)
        x:+name (log message + stack trace)
        1: DEBUG
        2: INFO
        3: WARNING
        4: ERROR

    LIBVIRT_LOG_OUTPUTS
        stderr output goes to stderr
        syslog:name use syslog for the output and use the given name as the ident
        file:file_path output to a file, with the given filepath
        journald output goes to systemd journal

gdb: https://access.redhat.com/blogs/766093/posts/2690881

# virsh

    virsh list --all
    virsh destroy ... # force off
    export EDITOR=vim # for `virsh edit`
    virsh dumpxml GuestID > guest.xml
    virsh define  guest.xml
    virsh domxml-to-native qemu-argv demo.xml > demo.sh
    virsh domxml-from-native qemu-argv demo.args > demo.xml

# snapshot

    virsh snapshot-create-as --domain debian --name 'snapshot1'
    virsh snapshot-list debian
    qemu-img snapshot -l debian.qcow2 # when VM off

# Pool
    virsh pool-edit default     # debian 9 default: /var/lib/libvirt/images/

# Driver
https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso  
https://github.com/torvalds/linux/blob/master/drivers/virtio/Kconfig  
VIRTIO_BALLOON supports increasing and decreasing the amount of memory within a KVM guest.  
VIRTIO_MMIO support for memory mapped virtio platform device driver.

# OVS
http://docs.openvswitch.org/en/latest/howto/libvirt/

    <interface type='bridge'>
        <mac address='52:54:00:71:b1:b6'/>
        <source bridge='br1'/>
        <virtualport type='openvswitch'/>
        <model type='virtio'/>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
    </interface>

# MacVTap
https://hicu.be/bridge-vs-macvlan

- Macvlan Bridge: VM-VM has bridge
- Macvlan private: VM-VM no communication
- Macvlan VEPA: VM-VM communicate via VEPA capable switch

https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Virtualization_Administration_Guide/sect-attch-nic-physdev.html    
`passthrough` attaches a virtual function of a SRIOV capable NIC directly to a VM **without losing the migration capability**.

https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Virtualization_Host_Configuration_and_Guest_Installation_Guide/App_Macvtap.html  
when a guest virtual machine is configured to use a type='direct' network interface such as macvtap, ..., the guest cannot communicate with its own host.

My workaround: deassign macvtap host NIC's IP, and communicate with host's 2nd NIC.

# Linux bridge
try if no dhcp:

    sysctl -w net.ipv4.conf.br0.bc_forwarding=1
    sysctl -w net.bridge.bridge-nf-call-iptables=0

# VLAN
## Macvlan Bridge

    ip link set dev enp4s0 promisc on

## OVS - VLAN tagging transparent
https://libvirt.org/formatdomain.html#setting-vlan-tag-on-supported-network-types-only

    <devices>
    <interface type='bridge'>
        <vlan>
            <tag id='42'/>
        </vlan>
        <source bridge='ovsbr0'/>

# Shutdown timeout

    vi /etc/init.d/libvirt-guests
        ON_SHUTDOWN=shutdown
        SHUTDOWN_TIMEOUT=10

    systemctl enable libvirt-guests.service

# Nested
booting with `kvm-intel.nested=1` argument on the kernel command line, or:  
https://www.linux-kvm.org/page/Nested_Guests#How_to_run

virt-manager：enable `Copy host CPU configuration` checkbox 

# virtiofs
https://libvirt.org/kbase/virtiofs.html

# vfio
https://www.kernel.org/doc/Documentation/vfio.txt

    echo '0000:42:00.1' | sudo tee /sys/bus/pci/devices/0000:42:00.1/driver/unbind
    echo 8086 1d02 | sudo tee /sys/bus/pci/drivers/vfio-pci/new_id

## Raw disk mapping
Support partion

    <disk type='block' device='disk'>
        <source dev='/dev/sdbX'/>    
        <target dev='vdb' bus='virtio'/>
    </disk>

        <source dev='/dev/disk/by-uuid/abcd1234'/>    

# GRUB
    cat /etc/default/grub | grep GRUB_CMDLINE_LINUX_DEFAULT
        intel_iommu=on kvm-intel.nested=1 modprobe.blacklist=megaraid_sas,ahci,radeon,nouveau,nvidiafb,snd_hda_intel,...
    update-grub

# UEFI
    apt install -y ovmf
    systemctl restart libvirtd
    # select UEFI while creating VM

# Troubleshooting

    error while adding virt-manager NFS pool:
        libvirtd[...]: cannot open volume '...': Transport endpoint is not connected
    => chmod +r
