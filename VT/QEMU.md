<!-- TOC -->

- [qcow2](#qcow2)
    - [check](#check)
    - [copy with real size](#copy-with-real-size)
    - [mount](#mount)
- [qemu-img](#qemu-img)
    - [qemu-img-windows](#qemu-img-windows)
- [virtiofs](#virtiofs)
- [qemu-nbd](#qemu-nbd)
- [virtio-mem](#virtio-mem)
- [Releases](#releases)
- [qemu-system](#qemu-system)

<!-- /TOC -->

# qcow2

    apt install libguestfs-tools

## check

    virt-list-partitions -lht foo.qcow2

## copy with real size

    for f in $(ls); do 
        qemu-img convert -O qcow2 $f ${TARGET_DIR}/$f 
    done

## mount

    guestmount -a foo.qcow2 -i --ro /mnt/foo

# qemu-img

    qemu-img -h | tail -n1  # Supported formats
    tar -xvf x.ova
    qemu-img convert -O qcow2 x.vmdk x.qcow2    

    qemu-img resize foo.qcow2 +2G # file size will increase when actual size grows

## qemu-img-windows
https://cloudbase.it/qemu-img-windows/

# virtiofs
https://virtio-fs.gitlab.io/  
Virtio-fs is used in production and has been available since Linux 5.4, QEMU 5.0, and libvirt 6.2. 

https://libvirt.org/kbase/virtiofs.html

# qemu-nbd
https://manpages.debian.org/testing/qemu-utils/qemu-nbd.8.en.html

    Export a QEMU disk image using the NBD protocol.
    Bind a /dev/nbdX block device to a QEMU server (on Linux).
    As a client to query exports of a remote NBD server.

# virtio-mem
https://virtio-mem.gitlab.io/  

# Releases
https://wiki.qemu.org/ChangeLog

    5.2
        A new KVM feature which improves the handling of asynchronous page faults is available with -cpu ...,kvm-async-pf-int. This requires Linux 5.8.
    5.1
        Support for live migration of AMD systems with nested virtualization
        A first version of virtio-mem, including virtio-mem-pci, for x86-64 has been included in QEMU. 
    5.0
        Support for passing host filesystem directory to guest via virtiofsd
    4.2
        VMX features can be enabled/disabled via the "-cpu" flag.
        Audio devices support an "audiodev" property that can be used to choose a specific backend to connect to the device.    
    4.1
        virtio-gpu 2d/3d rendering may now be offloaded to an external vhost-user process, such as QEMU vhost-user-gpu. Use vhost-user-vga & vhost-user-gpu-pci for associated devices. 
    4.0
        EDID interface for supported mdevs (Intel vGPU, host kernel v5.0+). Use options xres= and yres= to specify display resolution.
        qcow2: Support for external data files
    3.1
        Support for AMD IOMMU interrupt remapping and guest virtual APIC mode.
    3.0
        Formatting of CPU models and flags reported with '-cpu help' has improved readability
    2.12
        The default NIC for the q35 machine type is now e1000e (Intel 82574)
        Support for the "dedicated physical CPU" performance hint ("-cpu kvm-hint-dedicated=on")
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




