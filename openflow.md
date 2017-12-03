
<!-- TOC -->

- [Roadmap](#roadmap)
- [Classifiers](#classifiers)
- [Architecture](#architecture)
- [Tracing](#tracing)
- [ovs-ofctl dump-flows br0](#ovs-ofctl-dump-flows-br0)

<!-- /TOC -->

# Roadmap
V1.0-1.5: http://speed.cis.nctu.edu.tw/~ydlin/miscpub/indep_frank.pdf (Page 5)

# Classifiers
V1.0-1.4: http://flowgrammable.org/sdn/openflow/classifiers/

    dl_type = 0x0806    # ARP, Optional: switch must indicate support in FeatureRes)
    dl_type = 0x0800    # IPv4
    nw_proto = 1    # ICMPv4
    nw_proto = 6    # TCP
    nw_proto: 17    # UDP
    tp_src: 68      # Bootpc, UDP 0.0.0.0:68 -> 255.255.255.255:67
    tp_dst: 67      # Bootps, 192.168.1.1:67 -> 255.255.255.255:68

# Architecture
https://github.com/faucetsdn/faucet/blob/master/docs/architecture.rst

# Tracing
http://docs.openvswitch.org/en/latest/topics/tracing/

# ovs-ofctl dump-flows br0
```
name                : "vnet0"
ofport              : 1
admin_state         : up
statistics          : {collisions=0, rx_bytes=36595, rx_crc_err=0, rx_dropped=0, rx_errors=0, rx_frame_err=0, rx_over_err=0, rx_packets=145, tx_bytes=1216, tx_dropped=0, tx_errors=0, tx_packets=16}
mac_in_use          : "fe:54:00:2c:f2:9f"

name                : "br0"
ofport              : 65534
admin_state         : down
statistics          : {collisions=0, rx_bytes=0, rx_crc_err=0, rx_dropped=0, rx_errors=0, rx_frame_err=0, rx_over_err=0, rx_packets=0, tx_bytes=0, tx_dropped=0, tx_errors=0, tx_packets=0}
mac_in_use          : "2a:18:94:e4:38:49"

http://openvswitch.org/support/dist-docs/ovs-ofctl.8.txt
              resubmit:port
              resubmit([port],[table])
              resubmit([port],[table],connection tracking state)

NXST_FLOW reply (xid=0x4):
Table 0： Port-based ACLs
 ..., table=0, n_packets=0, n_bytes=0, idle_age=5659, priority=9099,in_port=2 actions=resubmit(,1)
 ..., table=0, n_packets=0, n_bytes=0, idle_age=5659, priority=9099,in_port=3 actions=resubmit(,1)
 ..., table=0, n_packets=132, n_bytes=33998, idle_age=0, priority=9099,in_port=1 actions=resubmit(,1)
 ..., table=0, n_packets=0, n_bytes=0, idle_age=5659, priority=0 actions=drop

Table 1： Ingress VLAN processing
 ..., table=1, n_packets=0, n_bytes=0, idle_age=5659, priority=9099,dl_dst=01:80:c2:00:00:00 actions=drop
 ..., table=1, n_packets=0, n_bytes=0, idle_age=5659, priority=9099,dl_dst=01:00:0c:cc:cc:cd actions=drop
 ..., table=1, n_packets=0, n_bytes=0, idle_age=5659, priority=9099,dl_type=0x88cc actions=drop
 ..., table=1, n_packets=0, n_bytes=0, idle_age=5659, priority=9000,in_port=2,vlan_tci=0x0000/0x1fff actions=mod_vlan_vid:200,resubmit(,3)
 ..., table=1, n_packets=0, n_bytes=0, idle_age=5659, priority=9000,in_port=3,vlan_tci=0x0000/0x1fff actions=mod_vlan_vid:200,resubmit(,3)
 ..., table=1, n_packets=132, n_bytes=33998, idle_age=0, priority=9000,in_port=1,vlan_tci=0x0000/0x1fff actions=mod_vlan_vid:100,resubmit(,3)
 ..., table=1, n_packets=0, n_bytes=0, idle_age=5659, priority=0 actions=drop

Table 2： VLAN-based ACLs
 ..., table=2, n_packets=0, n_bytes=0, idle_age=5659, priority=0 actions=drop

Table 3： Ingress L2 processing, MAC learning
 ..., table=3, n_packets=0, n_bytes=0, idle_age=5659, priority=9099,dl_src=ff:ff:ff:ff:ff:ff actions=drop
 ..., table=3, n_packets=0, n_bytes=0, idle_age=5659, priority=9001,dl_src=0e:00:00:00:00:01 actions=drop
 ..., table=3, n_packets=3, n_bytes=1005, hard_timeout=305, idle_age=0, priority=9098,in_port=1,dl_vlan=100,dl_src=52:54:00:2c:f2:9f actions=resubmit(,7)
 ..., table=3, n_packets=0, n_bytes=0, idle_age=5659, priority=0 actions=drop
 ..., table=3, n_packets=19, n_bytes=5546, idle_age=193, priority=9000 actions=CONTROLLER:96,resubmit(,7)

Table 4： L3 forwarding for IPv4
 ..., table=4, n_packets=0, n_bytes=0, idle_age=5659, priority=0 actions=drop

Table 5： L3 forwarding for IPv6
 ..., table=5, n_packets=0, n_bytes=0, idle_age=5659, priority=0 actions=drop

Table 6： Virtual IP processing, e.g. for router IP addresses implemented by Faucet
 ..., table=6, n_packets=0, n_bytes=0, idle_age=5659, priority=0 actions=drop

Table 7： Egress L2 processing
 ..., table=7, n_packets=0, n_bytes=0, idle_timeout=305, idle_age=193, priority=9099,dl_vlan=100,dl_dst=52:54:00:2c:f2:9f actions=strip_vlan,output:1
 ..., table=7, n_packets=0, n_bytes=0, idle_age=5659, priority=0 actions=drop
 ..., table=7, n_packets=132, n_bytes=33998, idle_age=0, priority=9000 actions=resubmit(,8)

Table 8： Flooding
 ..., table=8, n_packets=0, n_bytes=0, idle_age=5659, priority=9008,in_port=2,dl_vlan=200,dl_dst=ff:ff:ff:ff:ff:ff actions=strip_vlan,output:3
 ..., table=8, n_packets=0, n_bytes=0, idle_age=5659, priority=9008,in_port=3,dl_vlan=200,dl_dst=ff:ff:ff:ff:ff:ff actions=strip_vlan,output:2
 ..., table=8, n_packets=106, n_bytes=31994, idle_age=0, priority=9008,in_port=1,dl_vlan=100,dl_dst=ff:ff:ff:ff:ff:ff actions=strip_vlan
 ..., table=8, n_packets=0, n_bytes=0, idle_age=5659, priority=9006,in_port=2,dl_vlan=200,dl_dst=33:33:00:00:00:00/ff:ff:00:00:00:00 actions=strip_vlan,output:3
 ..., table=8, n_packets=0, n_bytes=0, idle_age=5659, priority=9006,in_port=3,dl_vlan=200,dl_dst=33:33:00:00:00:00/ff:ff:00:00:00:00 actions=strip_vlan,output:2
 ..., table=8, n_packets=21, n_bytes=1686, idle_age=514, priority=9006,in_port=1,dl_vlan=100,dl_dst=33:33:00:00:00:00/ff:ff:00:00:00:00 actions=strip_vlan
 ..., table=8, n_packets=0, n_bytes=0, idle_age=5659, priority=9002,in_port=2,dl_vlan=200,dl_dst=01:80:c2:00:00:00/ff:ff:ff:00:00:00 actions=strip_vlan,output:3
 ..., table=8, n_packets=0, n_bytes=0, idle_age=5659, priority=9002,in_port=3,dl_vlan=200,dl_dst=01:80:c2:00:00:00/ff:ff:ff:00:00:00 actions=strip_vlan,output:2
 ..., table=8, n_packets=0, n_bytes=0, idle_age=5659, priority=9004,in_port=2,dl_vlan=200,dl_dst=01:00:5e:00:00:00/ff:ff:ff:00:00:00 actions=strip_vlan,output:3
 ..., table=8, n_packets=0, n_bytes=0, idle_age=5659, priority=9004,in_port=3,dl_vlan=200,dl_dst=01:00:5e:00:00:00/ff:ff:ff:00:00:00 actions=strip_vlan,output:2
 ..., table=8, n_packets=0, n_bytes=0, idle_age=5647, priority=9002,in_port=1,dl_vlan=100,dl_dst=01:80:c2:00:00:00/ff:ff:ff:00:00:00 actions=strip_vlan
 ..., table=8, n_packets=5, n_bytes=318, idle_age=1175, priority=9004,in_port=1,dl_vlan=100,dl_dst=01:00:5e:00:00:00/ff:ff:ff:00:00:00 actions=strip_vlan
 ..., table=8, n_packets=0, n_bytes=0, idle_age=5659, priority=9000,in_port=2,dl_vlan=200 actions=strip_vlan,output:3
 ..., table=8, n_packets=0, n_bytes=0, idle_age=5659, priority=9000,in_port=3,dl_vlan=200 actions=strip_vlan,output:2
 ..., table=8, n_packets=0, n_bytes=0, idle_age=5647, priority=9000,in_port=1,dl_vlan=100 actions=strip_vlan
 ..., table=8, n_packets=0, n_bytes=0, idle_age=5659, priority=0 actions=drop
```