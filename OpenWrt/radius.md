# platform
https://www.radiusdesk.com/wiki24/products
- https://github.com/RADIUSdesk

# FreeRADIUS
https://openwrt.org/docs/guide-user/network/wifi/freeradius

- clients.conf -
    - client private-network-* { ipaddr + secret
- sites-enabled/default
    - listen {
    - authorize { filter_password # 
        - files: mods-config/files/authorize
        -  PAP (Password Authentication Protocol) | `pap: WARNING: Authentication will fail unless a "known good" password is available`

    opkg update && opkg install freeradius3-default
    apt install -y freeradius-utils # client tools
    ls -R /etc/freeradius3
    /etc/init.d/radiusd stop && radiusd -X # debug
    radtest bob hello wrt.lan 0 testing123 # 0 = NAS-port-number = any