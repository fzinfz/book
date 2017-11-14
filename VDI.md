<!-- TOC -->

- [GPU assignment](#gpu-assignment)
- [NVIDIA Certified](#nvidia-certified)
- [AMD](#amd)
- [Intel® Graphics Virtualization Technology](#intel®-graphics-virtualization-technology)
    - [GVT-g](#gvt-g)
        - [KVMGT](#kvmgt)
- [SPICE & QXL guest driver](#spice--qxl-guest-driver)
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
![](https://01.org/sites/default/files/users/u16902/graphics_virtualization_update_figure_1.png) 
![](https://01.org/sites/default/files/users/u16902/graphics_virtualization_update_figure_2.png) 
![](https://01.org/sites/default/files/users/u16902/graphics_virtualization_update_figure_3.png)

* –d (Intel® GVT –d): vDGA: virtual dedicated graphics acceleration (one VM to one physical GPU)
* –s (Intel® GVT -s): vSGA: virtual shared graphics acceleration (multiple VMs to one physical GPU)
* –g (Intel® GVT -g): vGPU: virtual graphics processing unit (multiple VMs to one physical GPU)

## GVT-g
https://01.org/igvt-g/blogs/wangbo85/2017/intel-gvt-g-kvmgt-public-release-q22017  
kernel 4.10+ / QEMU 2.9+ / [Xeon E3_v4+ / Core Gen 5th(Broadwell)+](https://en.wikipedia.org/wiki/List_of_Intel_graphics_processing_units#Eighth_generation)  
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