<!-- TOC -->

- [network](#network)
    - [create](#create)

<!-- /TOC -->

# network
https://docs.podman.io/en/latest/markdown/podman-network.1.html
- Netavark is the default network backend and was added in Podman v4.0
- CNI will be deprecated

https://github.com/containers/common/blob/main/docs/containers.conf.5.md#network-table

    /etc/containers/

    [network]
    network_backend="" # cni / netavark

## create

https://docs.podman.io/en/latest/markdown/podman-network-create.1.html

`--driver`
- bridge
- macvlan
- ipvlan

`--ipam-driver`
- dhcp
- host-local
- none