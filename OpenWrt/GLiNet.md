- [Cloud Web](#cloud-web)
- [Device](#device)
- [Multi WAN](#multi-wan)
- [API](#api)

# Config

    ls -lh /etc/oui-tertf/client.db
    /etc/config

# Cloud Web
set firewall/lan subnet/ ; view clients
- CN : https://cloud.gl-inet.cn
- https://www.goodcloud.xyz

remote web/terminal : need pub ip? : https://docs.gl-inet.com/router/en/4/interface_guide/cloud/#remote-access-web-admin-panel

# Device
GL-MT6000 | eth1 + ( eth0 : lan1-5 )

# Multi WAN
wan
secondwan
wwan
tethering | USB | https://docs.gl-inet.com/router/en/4/interface_guide/internet_tethering/

    cat /etc/config/kmwan

        option level # TODO

    cat /etc/hotplug.d/iface/99-kmwan

    uci -q get kmwan.global.enable

sensitivity: detection time interval(unit:s)

# API
https://dev.gl-inet.com/