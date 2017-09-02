<!-- TOC -->

- [KVM/libvirt](#kvmlibvirt)
    - [shutdown timeout](#shutdown-timeout)
- [ESXi](#esxi)
    - [vmdk](#vmdk)

<!-- /TOC -->

# KVM/libvirt
## shutdown timeout
/etc/init.d/libvirt-guests
ON_SHUTDOWN=shutdown
SHUTDOWN_TIMEOUT=10

systemctl enable libvirt-guests.service

# ESXi
## vmdk
```
vmkfstools -i "source.vmdk" -d thin "destination.vmdk"
```
The tool also reverts a vmdk which was blown up, back into a thin file! ([Ref](http://www.how2blog.de/?p=98))

