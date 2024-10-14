- [WireGuard - C](#wireguard---c)
    - [key](#key)
    - [wg-quick](#wg-quick)
    - [forwarding](#forwarding)
- [Tailscale](#tailscale)
    - [Subnet](#subnet)
- [zerotier](#zerotier)
- [nebula - go](#nebula---go)

L4: [/nw/proxy/](/nw/proxy/)

# WireGuard - C
- debug: https://www.wireguard.com/quickstart/#debug-info
- Network Namespace: https://www.wireguard.com/netns/
- uci: https://wiki.archlinux.org/title/WireGuard
- docker: https://github.com/masipcat/wireguard-go-docker
- auto: https://github.com/burghardt/easy-wg-quick

## key

    wg genkey | tee privatekey | wg pubkey > publickey

https://github.com/axllent/wireguard-vanity-keygen/releases

    ./wireguard-vanity-keygen --case-sensitive --limit 1 PRE

https://www.wireguard.com/protocol/
- optional pre-shared key that is mixed into the public key cryptography, all-zeros if not in use

    wg genpsk > presharedkey

private-key file: https://ubuntu.com/server/docs/security-tips-for-wireguard-vpn#preventing-accidental-leakage-of-private-keys

    [Interface]
    PostUp = wg set %i private-key /etc/wireguard/%i.key

## wg-quick
https://github.com/WireGuard/wireguard-tools/blob/master/src/wg-quick/linux.bash

https://wiki.archlinux.org/title/WireGuard#wg-quick

    ls /etc/wireguard/*.conf | grep -Po '(?<=/)\w+(?=.conf)' | xargs -I % sh -c "wg-quick down % ; echo --- ; wg-quick up %"
    wg ; echo --- ; iptables -L -t nat -v ; echo --- ; iptables -L -v ; sysctl net.ipv4.conf.all.forwarding
    systemctl enable wg-quick@wgX

## forwarding
https://unix.stackexchange.com/a/722448

sever

    [Interface]
    PrivateKey = sever
    Address = 192.168.44.1/24
    ListenPort = 

    [Peer]
    PublicKey = client
    AllowedIPs = 192.168.44.11/32, 192.168.88.0/24 # ip route | grep wg

home gateway

    [Interface]
    PrivateKey = client
    Address = 192.168.44.11/24
    PreUp = sysctl -w net.ipv4.conf.all.forwarding=1
    PreUp =    iptables -t nat -A POSTROUTING -o ens18 -j MASQUERADE
    PostDown = iptables -t nat -D POSTROUTING -o ens18 -j MASQUERADE

    [Peer]
    PublicKey = server
    Endpoint = server:port
    AllowedIPs = 192.168.44.0/24
    PersistentKeepalive = 25

# Tailscale
Free for Personal: https://tailscale.com/pricing/  

    curl -fsSL https://tailscale.com/install.sh | sh
    sysctl -w net.ipv4.ip_forward=1
    sysctl -w net.ipv6.conf.all.forwarding=1
    tailscale up --advertise-exit-node # enable on WebUI: Edit route settings
    tailscale status

- Console: https://login.tailscale.com/admin/machines  
- relay: https://tailscale.com/kb/1118/custom-derp-servers/

## Subnet
https://tailscale.com/kb/1019/subnets#connect-to-tailscale-as-a-subnet-router

- Linux: Enable IP forwarding
- Web: Edit route settings / Access Controls
  
# zerotier

    curl -s https://install.zerotier.com | sudo bash
    service zerotier-one status
    zerotier-cli status
    zerotier-cli peers # PLANET/LEAF

## Moons
Own Roots (a.k.a. Moons): https://docs.zerotier.com/roots/

    zerotier-cli join ...
    cd /var/lib/zerotier-one
    zerotier-idtool initmoon identity.public >> moon.json
    chown zerotier-one:zerotier-one moon.json


# nebula - go
https://github.com/slackhq/nebula