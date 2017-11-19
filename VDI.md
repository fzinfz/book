<!-- TOC -->

- [GPU assignment](#gpu-assignment)
- [NVIDIA Certified](#nvidia-certified)
- [AMD](#amd)
- [Intel® Graphics Virtualization Technology](#intel®-graphics-virtualization-technology)
    - [GVT-g](#gvt-g)
- [SPICE & QXL guest driver](#spice--qxl-guest-driver)
- [XenServer](#xenserver)
- [VDI Solutions - Nvidia](#vdi-solutions---nvidia)
- [VDI Solutions - Open Source](#vdi-solutions---open-source)
    - [Apache Guacamole](#apache-guacamole)
    - [KVM-VDI by Vilnius University](#kvm-vdi-by-vilnius-university)
- [IDV](#idv)
    - [XenClient(discontinued)](#xenclientdiscontinued)

<!-- /TOC -->

# GPU assignment
The state of GPU assignment in QEMU/KVM: https://www.linux-kvm.org/images/b/b3/01x09b-VFIOandYou-small.pdf

https://wiki.debian.org/VGAPassthrough

# NVIDIA Certified
http://www.nvidia.com/object/grid-certified-servers.html  
GRID vGPU is a licensed feature on Tesla M6, Tesla M10, and Tesla M60.

# AMD
AMD MxGPU is the world’s first hardware-based virtualized GPU solution, is built on industry standard SR-IOV (Single-Root I/O Virtualization) technology. Supprot VMWARE & Citrix.

# Intel® Graphics Virtualization Technology
![](https://01.org/sites/default/files/users/u25480/gpu-virtualization-approaches.png)  
https://01.org/sites/default/files/users/u16902/graphics_virtualization_update_figure_1.png  
https://01.org/sites/default/files/users/u16902/graphics_virtualization_update_figure_2.png  
https://01.org/sites/default/files/users/u16902/graphics_virtualization_update_figure_3.png  

* –d (Intel® GVT –d): vDGA: virtual dedicated graphics acceleration (one VM to one physical GPU)
* –s (Intel® GVT -s): vSGA: virtual shared graphics acceleration (multiple VMs to one physical GPU)
* –g (Intel® GVT -g): vGPU: virtual graphics processing unit (multiple VMs to one physical GPU)

## GVT-g
https://01.org/igvt-g/blogs/wangbo85/2017/intel-gvt-g-kvmgt-public-release-q22017  
kernel 4.10+ / QEMU 2.9+ / [Xeon E3_v4+ / Core Gen 5th(Broadwell)+](https://en.wikipedia.org/wiki/List_of_Intel_graphics_processing_units#Eighth_generation)  
X11VNC for Linux guest  
TightVNC, HP RGS, RDP for Windows guest  

https://01.org/linuxgraphics/downloads/intel-graphics-update-tool-linux-os-v2.0.5

    wget https://download.01.org/gfx/RPM-GPG-GROUP-KEY-ilg
    sudo apt-key add RPM-GPG-GROUP-KEY-ilg

https://github.com/intel/gvt-linux/wiki/GVTg_Setup_Guide  
For KVMGT, you also can use the current upstream Linux kernel and QEMU directly since all the enabling patches have been upstreamed.  
For XenGT, you must use the repositories we provided.

    vi /etc/default/grub
        i915.hvm_boot_foreground=1 i915.enable_gvt=1 kvm.ignore_msrs=1 intel_iommu=igfx_off drm.debug=0

    ls /sys/bus/pci/devices/0000\:00\:02.0/mdev_supported_types/
        V4 means it is "Broadwell" platform, 
        V5 means it is "Skylake" or "Kabylake" platform

    uuid -n 3 | xargs -n1 -I {} sudo sh -c \
    "echo {} > /sys/bus/pci/devices/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_4/create"

    git clone -b stable-2.9.0 https://github.com/intel/Igvtg-qemu.git
    modprobe vfio_mdev
    modprobe vfio_iommu_type1

https://www.openstack.org/assets/presentation-media/Enable-GPU-virtualization-in-OpenStack.pdf

https://www.kraxel.org/blog/2017/01/virtual-gpu-support-landing-upstream/

    <qemu:commandline>
        <qemu:arg value='-device'/>
        <qemu:arg value='vfio-pci,addr=05.0,sysfsdev=/sys/class/mdev_bus/0000:00:02.0/673475f6-cd28-11e7-9d1e-773e86af553a'/>
    </qemu:commandline>

    /usr/bin/qemu-system-x86_64 \
        -m 2048 -smp 2 -M pc -cpu host \
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

# SPICE & QXL guest driver
https://www.spice-space.org/download.html

# XenServer
https://docs.citrix.com/content/dam/docs/en-us/xenserver/current-release/downloads/xenserver-configuring-graphics.pdf  
Graphics Virtualization is available for XenServer Enterprise Edition customers, or those who have access to
XenServer through their XenApp/XenDesktop entitlement. 

# VDI Solutions - Nvidia
http://www.nvidia.com/object/xendesktop-vgpu.html
(Right bottom section: "Partner Solutions")

    ## Virtualized Application Solutions (Shared GPU)
    Citrix XenApp 6.5 with OpenGL Add-on and Citrix XenDesktop 7 Hosted-Shared delivery

![](http://www.nvidia.com/content/cloud-computing/images/gridtechnology-softwarediagram-xenapp.png)

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

## Apache Guacamole
https://guacamole.incubator.apache.org/  
https://hub.docker.com/r/guacamole/guacamole/  
HTML5 remote desktop gateway. supports VNC, RDP, and SSH.

## KVM-VDI by Vilnius University
https://github.com/Seitanas/kvm-vdi/wiki  
supported backends: plain QEMU-KVM and OpenStack (still in development).

https://www.neblogas.lt/2016/07/18/technical-info-ovirt-agent-sso/

# IDV
## XenClient(discontinued)
Diagram: https://www.citrix.com/blogs/wp-content/uploads/2014/10/XenClient-Architectural-Diagram.jpg