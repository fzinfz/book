


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

# Cloudflare 
## CNAME Flattening
https://blog.cloudflare.com/introducing-cname-flattening-rfc-compliant-cnames-at-a-domains-root/

For example, CNAME 6equj5.wordplumblr.com for Foo.com. when Foo.com started using too many resources WordPlumblr could have updated the CNAME and isolated Foo.com from the rest of the customers.

the biggest edge case had to do with email sent from Microsoft Exchange mail servers.

"flattens" the CNAME chain, a way to support a CNAME at the root, but still follow the RFC and return an IP address for any query for the root record. 

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