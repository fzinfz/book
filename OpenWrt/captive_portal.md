- [CoovaChilli](#coovachilli)
- [uspot](#uspot)
- [NoDogSplash (NDS)](#nodogsplash-nds)

https://openwrt.org/docs/guide-user/services/captive-portal/start

# CoovaChilli
- https://openwrt.org/docs/guide-user/services/captive-portal/wireless.hotspot.coova-chilli
- Config: https://github.com/coova/coova-chilli/blob/master/conf/defaults.in

        # /etc/config/chilli
        # HS_MACALLOW="..."      # List of MAC addresses to authenticate (comma seperated)

        /etc/init.d/chilli status

# uspot
drop-in replacement for CoovaChilli / nftables , RFC8908 Captive Portal API
- https://github.com/f00b4r0/uspot
    - credentials : a simple username/password authentication
    - click-to-continue
    - radius 
    - uam : remote RADIUS / MAC-based authentication bypass

# NoDogSplash (NDS)
a simple way to provide restricted access to the Internet by showing a splash page to the user before Internet access is granted.
- https://openwrt.org/docs/guide-user/services/captive-portal/nodogsplash
- Screenshot: https://user-images.githubusercontent.com/56849408/67450477-ed622100-f5f3-11e9-8a49-9323d2ff94e7.png