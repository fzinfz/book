<!-- TOC -->

- [Requirements](#requirements)
- [Guide](#guide)
- [Source - KVMGT](#source---kvmgt)
- [Source - XENGT](#source---xengt)
- [Kernel Compiling](#kernel-compiling)
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

# Guide
https://github.com/intel/gvt-linux/wiki/GVTg_Setup_Guide  
https://www.kraxel.org/blog/2017/01/virtual-gpu-support-landing-upstream/

# Source - KVMGT
For KVMGT, you also can use the current upstream Linux kernel and QEMU directly since all the enabling patches have been upstreamed.  
https://github.com/intel/gvt-linux/tree/gvt-staging/drivers/gpu/drm/i915/gvt

    https://github.com/intel/gvt-linux/releases (~150MB)
    git clone -b gvt-stable-4.12 https://github.com/intel/gvt-linux.git  # >20G?
    git clone -b gvt-staging https://github.com/intel/gvt-linux.git ./gvt-linux-staging  # >20G?

# Source - XENGT
For XenGT, you must use the repositories we provided.  
https://github.com/intel/Igvtg-xen/tree/xengt-stable-4.9/

    git clone -b xengt-stable-4.9 https://github.com/01org/igvtg-xen  # ~150MB

# Kernel Compiling
    echo ""|make oldconfig
    CONFIG_DRM_I915_GVT
    CONFIG_DRM_I915_GVT_KVMGT
    CONFIG_DRM_I915_GVT_XENGT
    CONFIG_VFIO_MDEV
    CONFIG_VFIO_MDEV_DEVICE
    cat .config | grep -P 'I915|VFIO'

# vfio
    modprobe vfio_mdev
    modprobe vfio_iommu_type1

# GRUB
    vi /etc/default/grub # KVMGT
        i915.hvm_boot_foreground=1 i915.enable_gvt=1 kvm.ignore_msrs=1 intel_iommu=igfx_off drm.debug=0

# mdev
    ls /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/
        V4 means it is "Broadwell" platform, 
        V5 means it is "Skylake" or "Kabylake" platform

    vgpu_create="/sys/bus/pci/devices/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_4/create"
    echo "673475f6-cd28-11e7-9d1e-773e86af553a" > $vgpu_create    
    uuid -n 3 | xargs -n1 -I {} sudo sh -c "echo {} > $vgpu_create"
    ls /sys/bus/pci/devices/0000:00:02.0/

# QEMU
    git clone -b stable-2.9.0 https://github.com/intel/Igvtg-qemu.git

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
    <domain type='kvm' xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'>
        <qemu:commandline>
            <qemu:arg value='-device'/>
            <qemu:arg value='vfio-pci,addr=05.0,sysfsdev=/sys/class/mdev_bus/0000:00:02.0/673475f6-cd28-11e7-9d1e-773e86af553a'/>
        </qemu:commandline>

# Openstack
https://www.openstack.org/assets/presentation-media/Enable-GPU-virtualization-in-OpenStack.pdf