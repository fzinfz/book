- [WireGuard - C](#wireguard---c)
    - [tailscale](#tailscale)
- [zerotier](#zerotier)
- [nebula - go](#nebula---go)

L4: [/nw/proxy/](/nw/proxy/)

# WireGuard - C
https://www.wireguard.com/quickstart/  
https://wiki.archlinux.org/title/WireGuard  
Userspace: https://github.com/masipcat/wireguard-go-docker  

## tailscale
Free for Personal: https://tailscale.com/pricing/  

    curl -fsSL https://tailscale.com/install.sh | sh
    sysctl -w net.ipv4.ip_forward=1
    sysctl -w net.ipv6.conf.all.forwarding=1
    tailscale up --advertise-exit-node # enable on WebUI: Edit route settings
    tailscale status

- Console: https://login.tailscale.com/admin/machines  
- relay: https://tailscale.com/kb/1118/custom-derp-servers/

# Subnet
https://tailscale.com/kb/1019/subnets#connect-to-tailscale-as-a-subnet-router

- Linux: Enable IP forwarding
- Web: Edit route settings / Access Controls
  
# zerotier

    curl -s https://install.zerotier.com | sudo bash
    service zerotier-one status
    zerotier-cli status

# nebula - go
https://github.com/slackhq/nebula