- [Web](#web)
  - [Troubleshooting](#troubleshooting)
- [port](#port)
  - [http](#http)
- [/www/](#www)
- [/usr/lib/lua/luci/](#usrliblualuci)


# Web
Action | Addr
-- | -- 
conf firewall | http://wrt.lan/cgi-bin/luci/admin/network/firewall  
view iptables |  http://wrt.lan/cgi-bin/luci/admin/status/iptables  
view conn | http://wrt.lan/cgi-bin/luci/admin/status/realtime/connections 
SSH key | http://wrt.lan/cgi-bin/luci/admin/system/admin   

/etc/config/luci
- ping/traceroute/nslookup: http://wrt.lan/cgi-bin/luci/admin/network/diagnostics

## Troubleshooting
- http://wrt.lan/cgi-bin/luci/admin/status/routes
  - rm default gw of interface if unexpected 0.0.0.0/0
- firewall + DNS

# port
## http
    grep listen /etc/config/uhttpd /etc/nginx/conf.d/*

# /www/
- cgi-bin/luci

# /usr/lib/lua/luci/
- model/view/controller
- admin

