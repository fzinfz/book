<!-- TOC -->

- [HAProxy Health Check](#haproxy-health-check)
- [Squid - caching HTTP, HTTPS, FTP, and more](#squid---caching-http-https-ftp-and-more)
- [Debugging](#debugging)
- [SNI](#sni)
- [Varnish](#varnish)
  - [Real IP](#real-ip)
- [Github pages](#github-pages)
- [Google Analytics](#google-analytics)
  - [Enhanced Link Attribution](#enhanced-link-attribution)

<!-- /TOC -->

# HAProxy Health Check
https://www.haproxy.com/documentation/aloha/7-0/haproxy/healthchecks/#checking-a-http-service

# Squid - caching HTTP, HTTPS, FTP, and more
http://www.squid-cache.org


# Debugging
https://mitmproxy.org/  
allows traffic flows to be intercepted, inspected, modified and replayed.

# SNI
Server Name Indication (SNI) is an extension to the TLS  
allows a server to present multiple certificates on the same IP address and TCP port number  
Wiki: https://en.wikipedia.org/wiki/Server_Name_Indication

# Varnish
https://hub.docker.com/r/centos/varnish-4-centos7/  
https://access.redhat.com/containers/?tab=overview#/search/varnish

## Real IP
https://support.cloudflare.com/hc/en-us/articles/200170986

https://support.cloudflare.com/hc/en-us/articles/200170706-How-do-I-restore-original-visitor-IP-with-Nginx-

# Github pages
*.github.io:    force https  
custom domain:  https ERR_CERT_COMMON_NAME_INVALID

https://help.github.com/articles/setting-up-an-apex-domain/

    192.30.252.153
    192.30.252.154

# Google Analytics
https://analytics.google.com/analytics/web/#/.../admin/property/settings

## Enhanced Link Attribution
all links for which you want enhanced click attribution should have an ID attribute