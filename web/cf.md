- [Network ports](#network-ports)
- [SSL/TLS](#ssltls)
  - [SSL Modes](#ssl-modes)
  - [Edge Certificates](#edge-certificates)
  - [Origin CA](#origin-ca)
- [CNAME Flattening](#cname-flattening)

# Network ports
HTTP: 80 8080 | No caching: 8880 2052 2082 2086 2095  
HTTPS: 443 | No caching: 2053 2083 2087 2096 8443

# SSL/TLS
## SSL Modes
https://developers.cloudflare.com/ssl/origin-configuration/ssl-modes/  

    Flexible: visitor - Edge cert - cf
    Full: cf - self signed certificate - server
    Full (strict): cf - trusted CA  - server

## Edge Certificates
[Automatic HTTPS Rewrites](https://support.cloudflare.com/hc/en-us/articles/227227647) safely eliminates **mixed content** issues by rewriting insecure URLs dynamically from known secure hosts to their secure counterpart.

[Page Rules - Always Use HTTPS](https://support.cloudflare.com/hc/en-us/articles/218411427#https)

[Page Rules - Forwarding URL](https://support.cloudflare.com/hc/en-us/articles/200170536)

## Origin CA
15-years wildcard | visitor - Edge cert - cf - Origin CA - server： https://blog.cloudflare.com/cloudflare-ca-encryption-origin/  

    PEM: Apache httpd and NGINX
    PKCS#7: Microsoft’s IIS or Apache Tomcat

# CNAME Flattening
https://blog.cloudflare.com/introducing-cname-flattening-rfc-compliant-cnames-at-a-domains-root/

For example, CNAME 6equj5.wordplumblr.com for Foo.com. when Foo.com started using too many resources WordPlumblr could have updated the CNAME and isolated Foo.com from the rest of the customers.

the biggest edge case had to do with email sent from Microsoft Exchange mail servers.

"flattens" the CNAME chain, a way to support a CNAME at the root, but still follow the RFC and return an IP address for any query for the root record. 