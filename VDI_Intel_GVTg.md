<!-- TOC -->

- [Requirements](#requirements)
- [Update tool](#update-tool)
- [Guide](#guide)
- [Kernel Compiling](#kernel-compiling)
    - [KVMGT](#kvmgt)
    - [XENGT](#xengt)
- [vfio](#vfio)
- [GRUB](#grub)
- [mdev](#mdev)
- [QEMU](#qemu)
- [libvirt](#libvirt)
- [Openstack](#openstack)

<!-- /TOC -->

# Requirements
https://01.org/igvt-g/blogs/wangbo85/2017/intel-gvt-g-kvmgt-public-release-q22017  
[Xeon E3_v4+ / Core Gen 5th(Broadwell)+](https://en.wikipedia.org/wiki/List_of_Intel_graphics_processing_units#Eighth_generation)

    lspci -v -s 00:02.0

# Update tool
https://01.org/linuxgraphics/downloads/intel-graphics-update-tool-linux-os-v2.0.5

    wget https://download.01.org/gfx/RPM-GPG-GROUP-KEY-ilg
    sudo apt-key add RPM-GPG-GROUP-KEY-ilg

    apt install -y libgtk-3-0
    apt --fix-broken install

# Guide
https://github.com/intel/gvt-linux/wiki/GVTg_Setup_Guide  
https://www.kraxel.org/blog/2017/01/virtual-gpu-support-landing-upstream/

# Kernel Compiling
    CONFIG_DRM_I915_GVT
    CONFIG_DRM_I915_GVT_KVMGT # KVMGT
    CONFIG_DRM_I915_GVT_XENGT # XENGT
    CONFIG_VFIO_MDEV
    CONFIG_VFIO_MDEV_DEVICE
    cat .config | grep -P 'I915|VFIO'

## KVMGT
For KVMGT, you also can use the current upstream Linux kernel and QEMU directly since all the enabling patches have been upstreamed.  
https://github.com/intel/gvt-linux/tree/gvt-staging/drivers/gpu/drm/i915/gvt

    https://github.com/intel/gvt-linux/releases (~150MB)
    git clone -b gvt-stable-4.12 https://github.com/intel/gvt-linux.git  # >20G?
    echo ""|make oldconfig

## XENGT
For XenGT, you must use the repositories we provided.  
https://github.com/intel/Igvtg-xen/tree/xengt-stable-4.9/

https://github.com/intel/gvt-linux/wiki/GVTg_Setup_Guide#332-build-qemu--xen-for-xengt

    git clone -b xengt-stable-4.9 https://github.com/01org/igvtg-xen  # ~111MB

# vfio
    modprobe vfio_mdev
    modprobe vfio_iommu_type1
    lsmod | grep -P -i 'vfio|kvm|i915'

# GRUB
    vi /etc/default/grub # KVMGT
        i915.hvm_boot_foreground=1 i915.enable_gvt=1 kvm.ignore_msrs=1 intel_iommu=igfx_off drm.debug=0

# mdev
    ls /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/
        V4 means it is "Broadwell" platform, 
        V5 means it is "Skylake" or "Kabylake" platform

    vgpu_create="/sys/bus/pci/devices/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_4/create"
    echo "673475f6-cd28-11e7-9d1e-773e86af553a" > $vgpu_create
    uuid -n 1 | xargs -n1 -I {} sudo sh -c "echo {} > $vgpu_create"
    ls /sys/bus/pci/devices/0000:00:02.0/   # check created vgpu

    /sys/bus/pci/devices/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_4/description
    low_gm_size: 128MB
    high_gm_size: 512MB
    fence: 4
    resolution: 1920x1200
    weight: 4

    /sys/bus/pci/devices/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_8/description
    low_gm_size: 64MB
    high_gm_size: 384MB
    fence: 4
    resolution: 1024x768
    weight: 2

# QEMU
    git clone -b stable-2.9.0 https://github.com/intel/Igvtg-qemu.git  # ~184MB
    apt-get install -y libsdl2-dev libpixman-1-dev libspice-server-dev
    qemu-system-x86_64 --version

    /usr/bin/qemu-system-x86_64 \
        -m 4048 -smp 4 -M pc -cpu host \
        -name gvt-g-guest \
        -cdrom /data/win10.iso \
        -drive file=/data/win10.img,index=0,media=disk,format=raw  \
        -bios /usr/bin/bios.bin -enable-kvm \
        -vga qxl \
        -k en-us \
        -serial stdio \
        -vnc :1 \
        -machine kernel_irqchip=on \
        -global PIIX4_PM.disable_s3=1 -global PIIX4_PM.disable_s4=1 \
        -usb -usbdevice tablet \
        -device vfio-pci,sysfsdev=/sys/bus/pci/devices/0000:00:02.0/673475f6-cd28-11e7-9d1e-773e86af553a,rombar=0

# libvirt
    <os>
        <loader readonly='yes' secure='no' type='rom'>/usr/bin/bios.bin</loader>

    <domain type='kvm' xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'>
        <qemu:commandline>
            <qemu:arg value='-device'/>
            <qemu:arg value='vfio-pci,addr=05.0,sysfsdev=/sys/class/mdev_bus/0000:00:02.0/673475f6-cd28-11e7-9d1e-773e86af553a'/>
        </qemu:commandline>

    https://mpolednik.github.io/2017/05/21/vfio-mdev/
    Since 3.2.0
    <devices>
        <hostdev mode='subsystem' type='mdev' model='vfio-pci'>
            <source>
                <address uuid='673475f6-cd28-11e7-9d1e-773e86af553a'/>
            </source>
        </hostdev>

    https://libvirt.org/drvnodedev.html#MDEV (Since 3.4.0)

    # workaround "error: cannot load AppArmor profile"
    /etc/libvirtd/qemu.conf
        security_driver = "none"

    # workaround 'error opening /dev/vfio/#: Permission denied'
    sudo aa-complain /usr/sbin/libvirtd
    sudo aa-complain /etc/apparmor.d/libvirt/libvirt-*

# Openstack
https://www.openstack.org/assets/presentation-media/Enable-GPU-virtualization-in-OpenStack.pdf