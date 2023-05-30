<!-- TOC -->

- [Config](#config)
- [CLI](#cli)
- [network](#network)
    - [Netavark](#netavark)
    - [CNI](#cni)
        - [DHCP](#dhcp)
    - [create](#create)

<!-- /TOC -->

# Config
V2: /etc/containers/registries.conf

    unqualified-search-registries = ["docker.io"]

# CLI

    podman search docker.io/KEYWORD

# network
https://docs.podman.io/en/latest/markdown/podman-network.1.html
- Netavark is the default network backend and was added in Podman v4.0
- CNI will be deprecated

https://github.com/containers/common/blob/main/docs/containers.conf.5.md#network-table

/etc/containers/containers.conf
```
[network]
network_backend="" # cni / netavark
```

    podman network inspect podman

## Netavark
https://www.redhat.com/sysadmin/podman-new-network-stack
- Better IPv6 support
- Improved support for containers in multiple networks
- Improved performance

## CNI
cni_config_dir in containers.conf: /etc/cni/net.d

DHCP: https://www.cni.dev/plugins/v0.8/ipam/dhcp/

## create

https://docs.podman.io/en/latest/markdown/podman-network-create.1.html

`--driver`
- bridge
- macvlan
- ipvlan

`--ipam-driver`
- dhcp: not yet supported with netavark | For CNI the dhcp plugin needs to be activated before.
- host-local
- none