<!-- TOC -->

- [Nginx](#nginx)
    - [upstream](#upstream)
- [HAProxy Health Check](#haproxy-health-check)
- [Debugging](#debugging)
- [SNI](#sni)
- [Varnish](#varnish)
- [Cryptography](#cryptography)
- [Let's Encrypt](#lets-encrypt)
- [Github pages](#github-pages)
- [Cloudflare](#cloudflare)
    - [Universal SSL](#universal-ssl)
    - [CNAME Flattening](#cname-flattening)
    - [page rule](#page-rule)
- [Google Analytics](#google-analytics)
    - [Enhanced Link Attribution](#enhanced-link-attribution)

<!-- /TOC -->

# Nginx
https://www.nginx.com/resources/wiki/start/topics/examples/full/

worker_processes  5;  ## Default: 1

    location /code/ {
        location ~* { # All files in it
            add_header Content-Type text/plain;  # Display file as text
        }
    }

    location /sub_dir {
        autoindex on;
        autoindex_exact_size off;
        charset utf-8;
        root /root_path

        error_log /var/logs/nginx/debug.log debug;
        # debug, info, notice, warn, error, crit, alert, or emerg
    }

    location / {
        proxy_pass http://foo:8000;
    }

## upstream
http://nginx.org/en/docs/http/ngx_http_upstream_hc_module.html

    upstream backend {
        server backend1.example.com       weight=5; # by default 1
        server backend2.example.com:8080;
        server unix:/tmp/backend3;

        server backup1.example.com:8080   backup;
        server backup2.example.com:8080   backup;
    }

    server {
        location / {
            proxy_pass http://backend;  # same name of upstream
        }
    }

Nginx health checks is available as part of commercial subscription.

# HAProxy Health Check
https://www.haproxy.com/documentation/aloha/7-0/haproxy/healthchecks/#checking-a-http-service

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

# Cryptography
https://www.ietf.org/rfc/rfc5280.txt

https://en.wikipedia.org/wiki/X.509  
X.509 is a standard that defines the format of public key certificates.  
used in many Internet protocols, including TLS/SSL, which is the basis for HTTPS  
contains a public key and an identity (a hostname, or an organization, or an individual)  

https://serverfault.com/questions/9708

`PEM` Governed by RFCs can have a variety of extensions (.pem, .key, .cer, .cert, more)  
`DER`, a binary version of the base64-encoded PEM file.  
`PKCS7` An open standard used by Java and supported by Windows. Does not contain private key material.  
`PKCS12`, enhanced security versus the plain-text PEM format. can contain private key material.

    certmgr.msc # Windows
    openssl x509 -noout -text -in cerfile.cer/.pem/.crt [-inform pem/der]   # Show Info
    openssl x509 -out converted.pem -inform der -in to-convert.der          # Convert
    openssl pkcs12 -in file-to-convert..pkcs12/.pfx/.p12 -out converted-file.pem -nodes

# Let's Encrypt
https://certbot.eff.org/

    ./certbot-auto certonly --webroot -w  /usr/share/nginx/www/ -d example.com  -d www.example.com

    /etc/letsencrypt/live/example.com/ -> /etc/letsencrypt/archive/example.com/
       cert.pem  chain.pem  fullchain.pem  privkey.pem 
    -> cert1.pem  chain1.pem  fullchain1.pem  privkey1.pem

# Github pages
*.github.io:    force https
custom domain:  https ERR_CERT_COMMON_NAME_INVALID

https://help.github.com/articles/setting-up-an-apex-domain/

    192.30.252.153
    192.30.252.154

# Cloudflare 
## Universal SSL
https://blog.cloudflare.com/introducing-universal-ssl/  

## CNAME Flattening
https://blog.cloudflare.com/introducing-cname-flattening-rfc-compliant-cnames-at-a-domains-root/

## page rule
https://support.cloudflare.com/hc/en-us/articles/218411427

HTTPS Rewrites:  
https://www.cloudflare.com/website-optimization/automatic-https-rewrite/   
Automatic-HTTPS-Rewrites：https://support.cloudflare.com/hc/en-us/articles/227227647  
redirect to HTTPS/SSL： https://support.cloudflare.com/hc/en-us/articles/200170536

Forcing HTTPS does not resolve issues with mixed content, as browsers check the protocol of included resources before making a request. You will need to use only relative links or HTTPS links on pages that you force to HTTPS. 

The "Always Use HTTPS" option will only appear if your zone has an active SSL certificate associated with it on Cloudflare.

# Google Analytics
https://analytics.google.com/analytics/web/#/.../admin/property/settings

## Enhanced Link Attribution
 all links for which you want enhanced click attribution should have an ID attribute