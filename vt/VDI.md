<!-- TOC -->

- [GPU assignment](#gpu-assignment)
  - [Error handling](#error-handling)
  - [virtio-gpu](#virtio-gpu)
- [Hardware](#hardware)
  - [NVIDIA Certified](#nvidia-certified)
    - [VDI Solutions - Nvidia](#vdi-solutions---nvidia)
  - [AMD](#amd)
  - [Intel® Graphics Virtualization Technology](#intel-graphics-virtualization-technology)
    - [Optional Firmware](#optional-firmware)
- [Citrix](#citrix)
  - [XenServer](#xenserver)
  - [XenClient(IDV, discontinued)](#xenclientidv-discontinued)
- [Remote Desktop](#remote-desktop)
  - [OpenStack](#openstack)
  - [Apache Guacamole](#apache-guacamole)
  - [Hardware - pikvm](#hardware---pikvm)
  - [KVM-VDI(discontinued)](#kvm-vdidiscontinued)
- [SPICE & QXL guest driver](#spice--qxl-guest-driver)
- [Streaming](#streaming)

<!-- /TOC -->

# GPU assignment
The state of GPU assignment in QEMU/KVM: https://www.linux-kvm.org/images/b/b3/01x09b-VFIOandYou-small.pdf

https://wiki.debian.org/VGAPassthrough

https://wiki.gentoo.org/wiki/GPU_passthrough_with_libvirt_qemu_kvm

https://pve.proxmox.com/wiki/Pci_passthrough

## Error handling
- Windows BSOD: system thread exception not handled

    echo "options kvm ignore_msrs=1" > /etc/modprobe.d/kvm.conf

- Linux tty: Radeon kernel modesetting for r600 or later requires firmware-amd-graphics 

    apt-get install firmware-amd-graphics

## virtio-gpu
https://www.linux-kvm.org/images/0/09/Qemu-gfx-2016.pdf 
 
https://github.com/qemu/qemu/blob/master/hw/display/virtio-gpu.c

ARMv8/arm-64: use virtio-gpu because the legacy VGA framebuffer is very troublesome on aarch64

https://docs.opennebula.org/5.4/deployment/open_cloud_host_setup/pci_passthrough.html#loading-vfio-driver-in-initrd

# Hardware
## NVIDIA Certified
http://www.nvidia.com/object/grid-certified-servers.html  
GRID vGPU is a licensed feature on Tesla M6, Tesla M10, and Tesla M60.

### VDI Solutions - Nvidia
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

## AMD
AMD MxGPU is the world’s first hardware-based virtualized GPU solution, is built on industry standard SR-IOV (Single-Root I/O Virtualization) technology. Supprot VMWARE & Citrix.

## Intel® Graphics Virtualization Technology 
![](https://01.org/sites/default/files/users/u25480/gpu-virtualization-approaches.png)  
https://01.org/sites/default/files/users/u16902/graphics_virtualization_update_figure_1.png  
https://01.org/sites/default/files/users/u16902/graphics_virtualization_update_figure_2.png  
https://01.org/sites/default/files/users/u16902/graphics_virtualization_update_figure_3.png  

* –d (Intel® GVT –d): vDGA: virtual dedicated graphics acceleration (one VM to one physical GPU)
* –s (Intel® GVT -s): vSGA: virtual shared graphics acceleration (multiple VMs to one physical GPU)
* –g (Intel® GVT -g): vGPU: virtual graphics processing unit (multiple VMs to one physical GPU)

Visit `Intel GVT-g` page for more.

### Optional Firmware
https://01.org/linuxgraphics/downloads/firmware

GuC：designed to perform graphics workload scheduling on the various graphics parallel engines.  
DMC: low-power idle states. It provides capability to save and restore display registers across these low-power states independently from the OS/Kernel.  
HUC: offload some of the media functions from the CPU to GPU.  

    ls /lib/firmware/i915/ -l

# Citrix
## XenServer
https://docs.citrix.com/content/dam/docs/en-us/xenserver/current-release/downloads/xenserver-configuring-graphics.pdf  
Graphics Virtualization is available for XenServer Enterprise Edition customers, or those who have access to
XenServer through their XenApp/XenDesktop entitlement. 

## XenClient(IDV, discontinued)
Diagram: https://www.citrix.com/blogs/wp-content/uploads/2014/10/XenClient-Architectural-Diagram.jpg

# Remote Desktop
## OpenStack
https://www.openstack.org/videos/boston-2017/virtual-desktop-infrastructure-vdi-with-openstack

## Apache Guacamole
https://guacamole.incubator.apache.org/  
https://hub.docker.com/r/guacamole/guacamole/  
HTML5 remote desktop gateway. supports VNC, RDP, and SSH.

## Hardware - pikvm
https://github.com/pikvm/pikvm  
Supported Raspberry Pi 2, 3, 4 and ZeroW

## KVM-VDI(discontinued)
https://github.com/Seitanas/kvm-vdi/wiki  
supported backends: plain QEMU-KVM and OpenStack

https://www.neblogas.lt/2016/07/18/technical-info-ovirt-agent-sso/

# SPICE & QXL guest driver
https://www.spice-space.org/download.html

# Streaming
ref: https://github.com/mbroemme/vdi-stream-client

Method                | Local | Remote | 3D
----------------------|-------|--------|------------------
[QXL with Spice](https://www.spice-space.org/)        | Yes   | Yes    | No
[GPU Passthrough](https://www.kernel.org/doc/Documentation/vfio.txt)       | Yes   | No     | Yes
[KVM FrameRelay](https://looking-glass.io/)        | Yes   | No     | Yes
[iGVT-g](https://www.kernel.org/doc/Documentation/vfio-mediated-device.txt)                | Yes   | No     | Yes (Intel only)
[Virgil 3D](https://virgil3d.github.io/)             | Yes   | Yes    | Yes (Linux only)
[SPICE Streaming Agent](https://gitlab.freedesktop.org/spice/spice-streaming-agent) | Yes   | Yes    | Yes (Linux only)
[Moonlight](https://moonlight-stream.org/)             | Yes   | Yes    | Yes (Nvidia only)
[Parsec](https://parsec.app/)                | Yes   | Yes    | Yes
[AirGame](https://mycloudgame.com/download.html) | Yes   | Yes    | Yes