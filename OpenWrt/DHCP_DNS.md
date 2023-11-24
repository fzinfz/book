- [Docs](#docs)
- [Static](#static)
    - [Luci](#luci)
    - [uci](#uci)
- [Lease Time](#lease-time)
    - [per client](#per-client)

# Docs
https://openwrt.org/docs/guide-user/base-system/dhcp_configuration

# Static
/etc/config/dhcp

## Luci
- all conf: http://wrt.lan/cgi-bin/luci/admin/network/dhcp
- dynamic -> static : http://wrt.lan/cgi-bin/luci/admin/status/overview

## uci

    uci show | grep dhcp | grep host

    uci add dhcp host         # will create `dhcp.@host[INDEX]=host`
    uci set dhcp.@host[-1].ITEM # -1 : last | -x: xth from last

    uci delete dhcp.@host[-1]

    uci commit dhcp         # refresh Luci
    service dnsmasq restart # reconnect client

# Lease Time

    cat /tmp/dhcp.leases 

    uci show | grep dhcp | grep lease
    => dhcp.lan.leasetime='12h'

    uci set dhcp.lan.leasetime='10m'
    uci commit dhcp; service odhcpd restart ; service dnsmasq restart

## per client
https://openwrt.org/docs/guide-user/dhcp/dhcp_configuration#dhcp_pools

luci: http://wrt.lan/cgi-bin/luci/admin/network/dhcp