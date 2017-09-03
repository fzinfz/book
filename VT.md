<!-- TOC -->

- [KVM/libvirt](#kvmlibvirt)
    - [shutdown timeout](#shutdown-timeout)
    - [VT-d](#vt-d)
    - [QEMU](#qemu)
- [VSphere / ESXi](#vsphere--esxi)
    - [Raw disk mapping (RDM)](#raw-disk-mapping-rdm)
    - [Config](#config)
        - [Backup](#backup)
        - [Restore](#restore)
    - [vmdk](#vmdk)
- [vagrant](#vagrant)
- [Openstack](#openstack)
    - [Ubuntu](#ubuntu)

<!-- /TOC -->

# KVM/libvirt
## shutdown timeout
/etc/init.d/libvirt-guests
ON_SHUTDOWN=shutdown
SHUTDOWN_TIMEOUT=10

systemctl enable libvirt-guests.service

## VT-d
```
echo '0000:42:00.1' | sudo tee /sys/bus/pci/devices/0000:42:00.1/driver/unbind
echo 8086 1d02 | sudo tee /sys/bus/pci/drivers/vfio-pci/new_id
```

## QEMU
```
systool -m kvm_intel -v | grep nested

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


```


# VSphere / ESXi
## Raw disk mapping (RDM)
```
ls -alh /vmfs/devices/disks
vmkfstools -r /vmfs/devices/disks/<device> example.vmdk
vmkfstools -z /vmfs/devices/disks/<device> example.vmdk
```
[Ref](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1026256)

## Config
[Ref](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=2042141)

### Backup
`vim-cmd hostsvc/firmware/backup_config`

### Restore
```
vim-cmd hostsvc/maintenance_mode_enter
vim-cmd hostsvc/firmware/restore_config /tmp/configBundle.tgz
```

## vmdk
```
vmkfstools -i "source.vmdk" -d thin "destination.vmdk"
```
The tool also reverts a vmdk which was blown up, back into a thin file! ([Ref](http://www.how2blog.de/?p=98))


# vagrant
```
sudo apt-get install vagrant 
sudo apt-get install libz-dev
vagrant plugin install vagrant-mutate
vagrant mutate http://files.vagrantup.com/precise32.box libvirt
vagrant plugin install vagrant-libvirt

vagrant plugin install vagrant-lxc

```

# Openstack
## Ubuntu
```
sudo apt-add-repository ppa:juju/stable
sudo apt-add-repository ppa:conjure-up/next
sudo apt update && sudo apt install -y conjure-up &&  conjure-up
```