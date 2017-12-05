<!-- TOC -->

- [systemctl](#systemctl)
- [Units](#units)
- [target](#target)
- [Config](#config)
- [debug](#debug)
- [journald](#journald)
- [systemd-networkd.service](#systemd-networkdservice)
- [systemd.netdev](#systemdnetdev)
    - [Kind](#kind)
    - [Examples](#examples)
        - [bridge.netdev](#bridgenetdev)
        - [dummy.netdev](#dummynetdev)
        - [vlan1.netdev](#vlan1netdev)
        - [macvtap.netdev](#macvtapnetdev)
- [systemd.network](#systemdnetwork)
    - [static.network](#staticnetwork)
    - [dhcp.network](#dhcpnetwork)
    - [A bridge with two enslaved links](#a-bridge-with-two-enslaved-links)
    - [bridge-slave-interface-vlan.network](#bridge-slave-interface-vlannetwork)
    - [macvtap.network](#macvtapnetwork)
- [systemd.link](#systemdlink)

<!-- /TOC -->

# systemctl
https://wiki.archlinux.org/index.php/systemd

```
systemctl list-dependencies
systemctl list-dependencies libvirtd --all

systemctl status [___.service]
systemctl | grep ssh
systemctl --failed
systemctl daemon-reload    # scanning for new or changed units

systemctl enable unit   # start on boot
systemctl mask unit     # make it impossible to start

sudo systemd-analyze plot > /tmp/systemd-startup.svg
fbi /tmp/systemd-startup.svg
```

# Units
- .service: default
- name@string.service:  instances of a template unit， actually 'instance_identifier@.service 
- .mount, E.g.: `/home` is equivalent to `home.mount`
- .device, E.g.: `/dev/sda2` is equivalent to `dev-sda2.device`
- .socket
- .slice

More: https://www.freedesktop.org/software/systemd/man/systemd.unit.html

    # when running in system mode (--system)
    ls -l /run/systemd/system	    # Runtime units
    ls -l /usr/lib/systemd/system	# Units of installed packages
    ls -l /etc/systemd/system	    # Local configuration, by SA

# target
https://wiki.archlinux.org/index.php/systemd#Create_custom_target

    SysV Runlevel	systemd Target	                                        Notes
    0	            runlevel0.target, poweroff.target	                    Halt the system.
    1, s, single	runlevel1.target, rescue.target	                        Single user mode.
    2, 4	        runlevel2.target, runlevel4.target, multi-user.target	User-defined/Site-specific runlevels. By default, identical to 3.
    3	            runlevel3.target, multi-user.target	                    usually login via multiple consoles or network.
    5	            runlevel5.target, graphical.target	                    Multi-user, graphical.
    6	            runlevel6.target, reboot.target	                        Reboot
    emergency	    emergency.target	                                    Emergency shell

    systemctl isolate multi-user.target         # switch to target
    systemctl get-default                       # current target
    systemctl set-default multi-user.target

# Config
http://fedoraproject.org/wiki/Systemd#How_do_I_customize_a_unit_file.2F_add_a_custom_unit_file.3F  
/etc/systemd/system/foobar.service.d/*.conf # override settings

    systemctl cat unit
    systemctl edit --full ssh
    systemctl edit --force new

    [Unit]
    Description=new

    [Service]
    ExecStart=/usr/sbin/new-daemon

    [Install]
    WantedBy=multi-user.target

# debug
https://wiki.debian.org/systemd#Debugging

    /etc/systemd/system.conf
        LogLevel=debug
        LogTarget=syslog-or-kmsg

# journald
    # http://man7.org/linux/man-pages/man5/journald.conf.5.html
    sudo mkdir -p /var/log/journal  # persistent storage

    journalctl -u unit

    SYSTEMD_LESS="FRXMK" journalctl -u docker -n 100
    -S, --since=, -U, --until=

https://wiki.archlinux.org/index.php/systemd#Journal

# systemd-networkd.service
/usr/lib/systemd/systemd-networkd  
https://wiki.archlinux.org/index.php/systemd-networkd  
https://www.freedesktop.org/software/systemd/man/systemd.netdev.html#

```
systemctl status systemd-networkd.service
systemctl restart systemd-networkd.service

# networkctl list
IDX LINK             TYPE               OPERATIONAL SETUP     
  1 lo               loopback           carrier     unmanaged 
  2 enp3s0           ether              no-carrier  unmanaged 
  3 eno1             ether              degraded    unmanaged 
  4 eno2             ether              degraded    configured
  7 docker0          ether              routable    unmanaged 
  9 vethec09cbe      ether              degraded    unmanaged 
 11 veth5185e04      ether              degraded    unmanaged 
 12 zt0              ether              routable    unmanaged 
 13 br0              ether              routable    configured
 14 macvtap0         ether              degraded    unmanaged 
 15 vnet0            ether              degraded    unmanaged 
 16 br8              ether              off         unmanaged 
 18 macvtap1         ether              degraded    unmanaged 
 19 vnet1            ether              degraded    unmanaged 
```

# systemd.netdev
    ls /etc/systemd/network     # local administration network directory
    ls /usr/lib/systemd/network # system network directory
    ls /run/systemd/network     # volatile runtime network directory
    `/run` is temporary and `/usr/lib` is for vendors
    symlink with the same name pointing to `/dev/null` disables the configuration file entirely

## Kind
    `bridge`	A bridge device is a software switch, and each of its slave devices and the bridge itself are ports of the switch.
    `tap`	A persistent Level 2 tunnel between a network device and a device node.
    `tun`	A persistent Level 3 tunnel between a network device and a device node.
    `veth`	An Ethernet tunnel between a pair of network devices.
    `sit`	An IPv6 over IPv4 tunnel.
    `vti`	An IPv4 over IPSec tunnel.

## Examples
### bridge.netdev
    [NetDev]
    Name=bridge0
    Kind=bridge

    [Match]
    Virtualization=no

### dummy.netdev
    [NetDev]
    Name=dummy-test
    Kind=dummy
    MACAddress=12:34:56:78:9a:bc

### vlan1.netdev
    [NetDev]
    Name=vlan1
    Kind=vlan

    [VLAN]
    Id=1

### macvtap.netdev 
    [NetDev]
    Name=macvtap-test
    Kind=macvtap

Compare with macvtap.network below.

# systemd.network
https://www.freedesktop.org/software/systemd/man/systemd.network.html

## static.network
    [Match]
    Name=enp2s0

    [Network]
    Address=192.168.0.15/24
    Gateway=192.168.0.1

## dhcp.network
    [Match]
    Name=en*

    [Network]
    DHCP=yes

## A bridge with two enslaved links
    # /etc/systemd/network/25-bridge-static.network
    [Match]
    Name=bridge0

    [Network]
    ...

    # /etc/systemd/network/25-bridge-slave-interface-1.network
    [Match]
    Name=enp2s0

    [Network]
    Bridge=bridge0

    # /etc/systemd/network/25-bridge-slave-interface-x.network 

## bridge-slave-interface-vlan.network
    [Match]
    Name=enp2s0

    [Network]
    Bridge=bridge0

    [BridgeVLAN]
    VLAN=1-32
    PVID=42
    EgressUntagged=42

    [BridgeVLAN]
    VLAN=100-200

    [BridgeVLAN]
    EgressUntagged=300-400

    VLAN=
    The VLAN ID allowed on the port. 

    EgressUntagged=
    The VLAN ID specified here will be used to untag frames on egress. 
    Configuring EgressUntagged= implicates the use of VLAN= above and will enable the VLAN ID for ingress as well. 

    PVID=
    The Port VLAN ID specified here is assigned to all untagged frames at ingress. PVID= can be used only once. 
    Configuring PVID= implicates the use of VLAN= above and will enable the VLAN ID for ingress as well.

## macvtap.network
    [Match]
    Name=enp0s25

    [Network]
    MACVTAP=macvtap-test

# systemd.link
Network link configuration is performed by the net_setup_link udev builtin.  
udev (userspace /dev) is a device manager for the Linux kernel. As the successor of devfsd and hotplug, udev primarily manages device nodes in the /dev directory.