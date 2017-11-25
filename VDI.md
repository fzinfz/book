<!-- TOC -->

- [GPU assignment](#gpu-assignment)
    - [virtio-gpu](#virtio-gpu)
- [NVIDIA Certified](#nvidia-certified)
- [AMD](#amd)
- [Intel® Graphics Virtualization Technology](#intel®-graphics-virtualization-technology)
- [Optional Firmware](#optional-firmware)
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

## virtio-gpu
https://www.linux-kvm.org/images/0/09/Qemu-gfx-2016.pdf  
https://github.com/qemu/qemu/blob/master/include/hw/virtio/virtio-gpu.h

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

Visit `Intel GVT-g` page for more.

# Optional Firmware
https://01.org/linuxgraphics/downloads/firmware

GuC：designed to perform graphics workload scheduling on the various graphics parallel engines.  
DMC: low-power idle states. It provides capability to save and restore display registers across these low-power states independently from the OS/Kernel.  
HUC: offload some of the media functions from the CPU to GPU.  

    ls /lib/firmware/i915/ -l

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