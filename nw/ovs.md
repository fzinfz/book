<!-- TOC -->

- [br](#br)
    - [VLAN](#vlan)
    - [Port bonding](#port-bonding)
    - [Port mirroring](#port-mirroring)
- [Controller](#controller)
    - [Faucet](#faucet)
- [Misc](#misc)
- [UI](#ui)

<!-- /TOC -->

Features mapping: http://docs.openvswitch.org/en/latest/faq/releases/

    # Supported datapaths
    Linux upstream
    Linux OVS tree：implemented by the Linux kernel module distributed with the OVS source tree.
    Userspace：Also known as DPDK, dpif-netdev or dummy datapath. on NetBSD, FreeBSD and Mac OSX.
    Hyper-V：Also known as the Windows datapath.

https://docs.openvswitch.org/en/latest/faq/issues/
- A physical Ethernet device that is part of an Open vSwitch bridge should not have an IP address.

http://docs.openvswitch.org/en/latest/faq/openflow/  
version 2.8: OF 1.0-1.4; 1.5/1.6 missing features  
All current versions of ovs-ofctl enable only OpenFlow 1.0 by default.

    ovs-ofctl -O OpenFlow13 dump-flows br0  # enable support for later versions

https://github.com/openvswitch/ovs

- [ovs-vswitchd](http://openvswitch.org/support/dist-docs/ovs-vswitchd.8.html) | 
[ovs-vswitchd.conf.db](http://openvswitch.org/support/dist-docs/ovs-vswitchd.conf.db.5.html)  
- [ovsdb-server](http://openvswitch.org/support/dist-docs/ovsdb-server.1.html)  
- [ovs-dpctl](http://openvswitch.org/support/dist-docs/ovs-dpctl.8.html), a tool for configuring the switch kernel module.  
- [ovs-vsctl](http://openvswitch.org/support/dist-docs/ovs-vsctl.8.html), a utility for querying and updating the configuration of ovs-vswitchd.  
- [ovs-appctl](http://openvswitch.org/support/dist-docs/ovs-appctl.8.html), a utility that sends commands to running Open vSwitch daemons.  
- [ovs-ofctl](http://openvswitch.org/support/dist-docs/ovs-ofctl.8.html), a utility for querying and controlling OpenFlow switches and controllers.  
- [ovs-pki](http://openvswitch.org/support/dist-docs/ovs-pki.8.html), a utility for creating and managing the public-key infrastructure for OpenFlow switches.  
- [ovs-testcontroller](http://openvswitch.org/support/dist-docs/ovs-testcontroller.8.html), a simple OpenFlow controller that may be useful for testing
- A patch to tcpdump that enables it to parse OpenFlow messages.

http://docs.openvswitch.org/en/latest/ref/  
ovn-* ovsdb-* ovs-* vtep[-ctl]  
VTEP: VXLAN Tunnel End Point

# br
http://docs.openvswitch.org/en/latest/faq/configuration/

    ovs-vsctl add-br br0
    ovs-vsctl add-port br0 eth0             # trunk port (the default)

## VLAN

    ovs-vsctl add-port br0 tap0 tag=9       # access port
    ovs-vsctl add-port br0 eth0 tag=9 vlan_mode=native-tagged

    native-tagged
        A native-tagged port resembles a  trunk  port,  with  the
        exception  that  a  packet  without an 802.1Q header that
        ingresses on a native-tagged  port  is  in  the  ``native
        VLAN’’ (specified in the tag column).

    native-untagged
        A  native-untagged  port  resembles a native-tagged port,
        with the exception that  a  packet  that  egresses  on  a
        native-untagged  port in the native VLAN will not have an
        802.1Q header.

    ovs-vsctl set port tap0 tag=9           # set existing port

## Port bonding

    ovs-vsctl add-bond br0 bond0 eth0 eth1  # ovs-vswitchd.conf.db(5) for options

each of the interfaces in my bonded port shows up as an individual OpenFlow port.  
Open vSwitch makes individual bond interfaces visible as OpenFlow ports, rather than the bond as a whole.

## Port mirroring

    # eth0 + tap0 mirrored to tap1
    ovs-vsctl add-port br0 eth0
    ovs-vsctl set bridge br0 stp_enable=true    # not well tested
    ovs-vsctl add-port br0 tap0
    ovs-vsctl add-port br0 tap1 \
        -- --id=@p get port tap1 \
        -- --id=@m create mirror name=m0 select-all=true output-port=@p \
        -- set bridge br0 mirrors=@m
    ovs-vsctl clear bridge br0 mirrors # disable mirror

[RSPAN VLAN](https://github.com/osrg/openvswitch/blob/master/FAQ#L243), mirroring of all traffic to that VLAN. Mirroring to a VLAN can disrupt a network that contains unmanaged switches. 

# Controller 

    ovs-vsctl set-controller of-switch tcp:0.0.0.0:6633 # set Remote Controller
    
## Faucet

    IP_faucet=127.0.0.1   # don't use domain name
    ovs-vsctl add-br br0 \
         -- set bridge br0 other-config:datapath-id=0000000000000001 \
         -- set-controller br0 tcp:$IP_faucet:6653 \
         -- set controller br0 connection-mode=out-of-band
    ovs-vsctl add-port br0 enp3s0 -- set interface enp3s0 ofport_request=1
    ovs-vsctl -- --columns=name,ofport,link_speed,admin_state,statistics,mac_in_use list Interface   # mapping

    for i in 1 2 3; do
        ip tuntap add mode tap dev tap$i
        ovs-vsctl add-port br0 tap$i -- set interface tap$i ofport_request=$i
        ovs-ofctl mod-port br0 tap$i up
    done

    cat /var/log/openvswitch/ovs-vswitchd.log
    ovs-vsctl show
    ovs-vsctl --if-exists del-br br0
    ovs-appctl ofproto/trace br0 in_port=tap1

    ovs-appctl vlog/list
    ovs-appctl vlog/set ANY:file:dbg

    ovs-ofctl dump-flows br0

https://github.com/osrg/openvswitch/blob/master/FAQ  
"in-band": controllers are actually part of the network that is being controlled. occasionally they can cause unexpected behavior.

    ovs-appctl bridge/dump-flows br0      # full OpenFlow flow table, including hidden flows
    ovs-vsctl set bridge br0 other-config:disable-in-band=true # disables in-band control entirely


# Misc
A physical Ethernet device that is part of an Open vSwitch bridge should not have an IP address.

"normalization": a flow cannot match on an L3 field without saying what L3 protocol is in use.

    ovs-ofctl add-flow br0 ip,nw_dst=192.168.0.1,actions=drop
    ovs-ofctl add-flow br0 arp,nw_dst=192.168.0.1,actions=drop

"tp_src=1234" will be ignored. write "tcp,tp_src=1234", or "udp,tp_src=1234".

ofport value -1 means that the interface could not be created due to an error.  
ofport value [] means that the interface hasn't been created yet.

`ovs-dpctl dump-flows` queries a kernel datapath  
`ovs-ofctl dump-flows` queries an OpenFlow switch

[OVS with faucet](#ovs) | 
[Youtube](https://www.youtube.com/channel/UCH8GBLyxWkJDfZG32kr3Y4g)

# UI
https://github.com/nbonnand/ovs-toolbox/wiki
