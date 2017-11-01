<!-- TOC -->

- [Open vSwitch](#open-vswitch)
    - [Tutorial](#tutorial)
    - [Remote Controller](#remote-controller)
- [Mininet](#mininet)
    - [Install](#install)
    - [Python Interpreter](#python-interpreter)
    - [custom topo & NAT](#custom-topo--nat)
- [Controller](#controller)
    - [Python - Ryu](#python---ryu)
    - [C++ - OpenContrail](#c---opencontrail)
    - [JAVA - ODL](#java---odl)
    - [JAVA - ONOS](#java---onos)
        - [Docker](#docker)
        - [Ports](#ports)
        - [WebUI](#webui)
        - [Running as a service](#running-as-a-service)
        - [Forming a cluster](#forming-a-cluster)
    - [JAVA - Floodlight](#java---floodlight)

<!-- /TOC -->

# Open vSwitch
https://github.com/openvswitch/ovs

    ovs-vswitchd
    ovsdb-server
    ovs-dpctl, a tool for configuring the switch kernel module.
    ovs-vsctl, a utility for querying and updating the configuration of ovs-vswitchd.
    ovs-appctl, a utility that sends commands to running Open vSwitch daemons.
    ovs-ofctl, a utility for querying and controlling OpenFlow switches and controllers.
    ovs-pki, a utility for creating and managing the public-key infrastructure for OpenFlow switches.
    ovs-testcontroller, a simple OpenFlow controller that may be useful for testing
    A patch to tcpdump that enables it to parse OpenFlow messages.

## Tutorial
http://en.community.dell.com/techcenter/networking/w/wiki/3820.openvswitch-openflow-lets-get-started

## Remote Controller
ovs-vsctl set-controller of-switch tcp:0.0.0.0:6633

# Mininet
## Install
    git clone https://github.com/mininet/mininet
    mininet/util/install.sh -w

    -a: (default) install (A)ll packages - good luck!
    -b: install controller (B)enchmark (oflops)
    -c: (C)lean up after kernel install
    -d: (D)elete some sensitive files from a VM image
    -e: install Mininet d(E)veloper dependencies
    -f: install Open(F)low
    -h: print this (H)elp message
    -i: install (I)ndigo Virtual Switch
    -k: install new (K)ernel
    -m: install Open vSwitch kernel (M)odule from source dir
    -n: install Mini(N)et dependencies + core files
    -p: install (P)OX OpenFlow Controller
    -r: remove existing Open vSwitch packages
    -s <dir>: place dependency (S)ource/build trees in <dir>
    -t: complete o(T)her Mininet VM setup tasks
    -v: install Open (V)switch
    -V <version>: install a particular version of Open (V)switch on Ubuntu
    -w: install OpenFlow (W)ireshark dissector 
    -y: install R(y)u Controller
    -x: install NO(X) Classic OpenFlow controller
    -0: (default) -0[fx] installs OpenFlow 1.0 versions
    -3: -3[fx] installs OpenFlow 1.3 versions

## Python Interpreter    
    mininet> py locals()
    mininet> py h1


## custom topo & NAT
http://mininet.org/api/classmininet_1_1topo_1_1Topo.html

    # https://github.com/mininet/mininet/blob/master/custom/topo-2sw-2host.py
    mn --custom mininet/custom/topo-2sw-2host.py --topo mytopo --nat

    mininet> dump
    <Host h1: h1-eth0:10.0.0.1 pid=5267>
    <Host h2: h2-eth0:10.0.0.2 pid=5269>
    <NAT nat0: nat0-eth0:10.0.0.3 pid=5418>
    <OVSSwitch s3: lo:127.0.0.1,s3-eth1:None,s3-eth2:None,s3-eth3:None pid=5274>
    <OVSSwitch s4: lo:127.0.0.1,s4-eth1:None,s4-eth2:None pid=5277>
    <Controller c0: 127.0.0.1:6653 pid=5260>

# Controller
## Python - Ryu
http://ryu.readthedocs.io/en/latest/getting_started.html
https://hub.docker.com/r/osrg/ryu-book/

## C++ - OpenContrail
https://github.com/Juniper/contrail-controller  
https://github.com/Juniper/contrail-vrouter

## JAVA - ODL
https://hub.docker.com/r/opendaylight/odl/  

## JAVA - ONOS
![](https://en.wikipedia.org/wiki/File:ONOS-Tiers.png)

### Docker
https://wiki.onosproject.org/display/ONOS/Running+the+published+Docker+ONOS+images  

    docker pull onosproject/onos

### Ports
    8181    for REST API and GUI
    8101    to access the ONOS CLI
    9876    for intra-cluster communication (communication between target machines)
    6653    optional, for OpenFlow
    6640    optional, for OVSDB

### WebUI
http://192.168.88.15:8181/onos/ui/login.html # onos/rocks

### Running as a service
https://wiki.onosproject.org/display/ONOS/Running+ONOS+as+a+service

### Forming a cluster
Form a cluster of three instances, from one of the target machines

    /opt/onos/bin/onos-form-cluster $TARGET_MACHINE_1_IP ... $TARGET_MACHINE_N_IP

## JAVA - Floodlight
https://github.com/floodlight/floodlight