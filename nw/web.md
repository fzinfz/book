<!-- TOC -->

- [Cryptography](#cryptography)
    - [Key exchange or key establishment](#key-exchange-or-key-establishment)
    - [cipher or cypher](#cipher-or-cypher)
    - [Cryptography libraries compare](#cryptography-libraries-compare)
    - [X.509](#x509)
    - [Certificate Revocation List (or CRL)](#certificate-revocation-list-or-crl)
    - [TLS Extensions - Certificate Status Request](#tls-extensions---certificate-status-request)
    - [Certificate formats](#certificate-formats)
    - [ECDSA vs RSA](#ecdsa-vs-rsa)
- [SSL](#ssl)
    - [Private Key](#private-key)
    - [Let's Encrypt](#lets-encrypt)
        - [Wildcard](#wildcard)
    - [Cloudflare](#cloudflare)
    - [Mozilla SSL Configuration Generator](#mozilla-ssl-configuration-generator)
- [Nginx](#nginx)
    - [SSL](#ssl-1)
    - [plain text/index/debug/proxy](#plain-textindexdebugproxy)
    - [upstream](#upstream)
- [HAProxy Health Check](#haproxy-health-check)
- [Squid - caching HTTP, HTTPS, FTP, and more](#squid---caching-http-https-ftp-and-more)
- [Debugging](#debugging)
- [SNI](#sni)
- [Varnish](#varnish)
- [Github pages](#github-pages)
- [Cloudflare](#cloudflare-1)
    - [CNAME Flattening](#cname-flattening)
    - [SSL Modes](#ssl-modes)
    - [HTTPS](#https)
    - [Real IP](#real-ip)
- [Google Analytics](#google-analytics)
    - [Enhanced Link Attribution](#enhanced-link-attribution)

<!-- /TOC -->

# Cryptography
## Key exchange or key establishment
https://en.wikipedia.org/wiki/Key_exchange  
any method in cryptography by which cryptographic keys are exchanged between two parties, allowing use of a cryptographic algorithm.

`Diffie–Hellman key exchange (DH)` is a method of securely exchanging cryptographic keys over a public channel and was one of the first public-key protocols  
The D–H key exchange protocol, however, does not by itself address authentication  
Google Chrome Intent to deprecate DHE-based cipher suites

`Public key infrastructures (PKIs)` have been proposed as a way around this problem of identity authentication.  
https://en.wikipedia.org/wiki/Public_key_infrastructure  
![](https://en.wikipedia.org/wiki/File:Public-Key-Infrastructure.svg)

- `registration authority (RA)`: assures valid and correct registration. In a Microsoft PKI, a RA is usually called a `subordinate CA`.
- An entity must be uniquely identifiable within each `certificate authority (CA)` domain on the basis of information about that entity. A third-party `validation authority (VA)` can provide this entity information on behalf of the CA.

## cipher or cypher
an algorithm for performing encryption or decryption  

A stream cipher is a symmetric key cipher where plaintext digits are combined with a pseudorandom cipher digit stream (keystream).   
https://en.wikipedia.org/wiki/Stream_cipher#Comparison_of_stream_ciphers

Salsa20 is a stream cipher.  
Poly1305 is a cryptographic message authentication code (MAC)，can be used to verify the data integrity and the authenticity of a message.  
In NaCl Poly1305 is used with Salsa20 instead of AES, in TLS and SSH it is used with ChaCha20 keystream.

"Networking and Cryptography library"/NaCl (pronounced "salt"): high-speed software library for network communication, encryption, decryption, signatures, etc

Libsodium: a portable, cross-compilable, installable, packageable, API-compatible version of NaCl.  
macOS, Linux, OpenBSD, NetBSD, FreeBSD, DragonflyBSD, Android, iOS, 32 and 64-bit Windows (Visual Studio, MinGW, C++ Builder), NativeClient, QNX, JavaScript, AIX, MINIX, Solaris

## Cryptography libraries compare
https://en.wikipedia.org/wiki/Comparison_of_cryptography_libraries  
GnuTLS vs libsodium vs NaCL vs OpenSSL vs ...

## X.509
https://www.ietf.org/rfc/rfc5280.txt

https://en.wikipedia.org/wiki/X.509  
X.509 is a standard that defines the format of public key certificates.  
used in many Internet protocols, including TLS/SSL, which is the basis for HTTPS  
contains a public key and an identity (a hostname, or an organization, or an individual)  

## Certificate Revocation List (or CRL) 
"a list of digital certificates that have been revoked by the issuing Certificate Authority (CA) before their scheduled expiration date and should no longer be trusted."

## TLS Extensions - Certificate Status Request
https://tools.ietf.org/html/rfc4366#section-3.6  
Constrained clients may wish to use a certificate-status protocol such as [Online Certificate Status Protocol - OCSP](https://tools.ietf.org/html/rfc2560) to check the validity of server certificates,   in order to avoid transmission of CRLs and therefore save bandwidth on constrained networks.  
This extension allows for such information to be sent in the TLS handshake, saving roundtrips and resources.

https://en.wikipedia.org/wiki/Online_Certificate_Status_Protocol  

[Verifying](https://www.digicert.com/util/utility-test-ocsp-and-crl-access-from-a-server.htm)

## Certificate formats
https://serverfault.com/questions/9708

`PEM` Governed by RFCs can have a variety of extensions (.pem, .key, .cer, .cert, more)  
`DER`, a binary version of the base64-encoded PEM file.  
`PKCS7` An open standard used by Java (E.g. Tomcat) and supported by Windows. Does not contain private key material.  
`PKCS12`, enhanced security versus the plain-text PEM format. can contain private key material.

    certmgr.msc # Windows
    openssl x509 -noout -text -in cerfile.cer/.pem/.crt [-inform pem/der]   # Show Info
    openssl x509 -out converted.pem -inform der -in to-convert.der          # Convert
    openssl pkcs12 -in file-to-convert..pkcs12/.pfx/.p12 -out converted-file.pem -nodes

## ECDSA vs RSA
https://blog.cloudflare.com/ecdsa-the-digital-signature-algorithm-of-a-better-internet/  
with ECDSA you can get the same level of security as RSA but with smaller keys.  
legacy browsers may not support

# SSL
## Private Key
https://info.ssl.com/faq-what-is-a-private-key/  
private key is a text file used initially to generate a Certificate Signing Request (CSR), and later to secure and verify connections using the certificate created per that request. The private key is used to create a digital signature As you might imagine from the name.

## Let's Encrypt
https://certbot.eff.org/

    ./certbot-auto certonly --webroot -w  /usr/share/nginx/www/ -d example.com  -d www.example.com

    /etc/letsencrypt/live/example.com/ -> /etc/letsencrypt/archive/example.com/
       cert.pem  chain.pem  fullchain.pem  privkey.pem 
    -> cert1.pem  chain1.pem  fullchain1.pem  privkey1.pem

### Wildcard 
https://github.com/Neilpang/acme.sh#10-issue-wildcard-certificates

    acme.sh  --issue -d example.com  -d '*.example.com'  --dns dns_cf

## Cloudflare
https://blog.cloudflare.com/cloudflare-ca-encryption-origin/ (15-years wildcard)

## Mozilla SSL Configuration Generator
https://mozilla.github.io/server-side-tls/ssl-config-generator/

    Apache / Nginx / Lighttpd / HAProxy / AWS ELB

    Modern compatibility: IE 11 on Windows 7, Android 5.0
    Intermediate compatibility (default):  IE 7

# Nginx
## SSL
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    # certs sent to the client in SERVER HELLO are concatenated in ssl_certificate
    ssl_certificate /path/to/signed_cert_plus_intermediates;
    ssl_certificate_key /path/to/private_key;
    ssl_session_timeout 1d; # default 5m
    ssl_session_cache shared:SSL:50m;   # *none = lie | off = reject | builtin[:size] = 1 worker| shared:name:size
    ssl_session_tickets off; # default on. session resumption https://tools.ietf.org/html/rfc5077

    # intermediate configuration. tweak to your needs.
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers 'ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS';
    ssl_prefer_server_ciphers on;

    # OCSP Stapling ---
    # fetch OCSP records from URL in ssl_certificate and cache them
    ssl_stapling on;        # Default off.  stapling of OCSP responses
    resolver <IP DNS resolver>;

    ssl_stapling_verify on; # Default off.  verification of OCSP responses
    ## verify chain of trust of OCSP response using Root CA and Intermediate certs
    ssl_trusted_certificate /path/to/root_CA_cert_plus_intermediates;

## plain text/index/debug/proxy
https://www.nginx.com/resources/wiki/start/topics/examples/full/

    worker_processes  5;  ## Default: 1

    location /code/ {
        location ~* { # All files in it
            add_header Content-Type text/plain;                      # Display file as text
        }
    }

    location /sub_dir {
        autoindex on;                                                # list dir files
        autoindex_exact_size off;
        charset utf-8;
        root /root_path

        error_log /var/logs/nginx/debug.log debug;                   #   Debug
        # debug, info, notice, warn, error, crit, alert, or emerg
    }

    location / {
        proxy_pass http://foo:8000;                                  # Reverse Proxy
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

# Github pages
*.github.io:    force https  
custom domain:  https ERR_CERT_COMMON_NAME_INVALID

https://help.github.com/articles/setting-up-an-apex-domain/

    192.30.252.153
    192.30.252.154

# Cloudflare 
## CNAME Flattening
https://blog.cloudflare.com/introducing-cname-flattening-rfc-compliant-cnames-at-a-domains-root/

For example, CNAME 6equj5.wordplumblr.com for Foo.com. when Foo.com started using too many resources WordPlumblr could have updated the CNAME and isolated Foo.com from the rest of the customers.

the biggest edge case had to do with email sent from Microsoft Exchange mail servers.

"flattens" the CNAME chain, a way to support a CNAME at the root, but still follow the RFC and return an IP address for any query for the root record. 

## SSL Modes
https://www.cloudflare.com/ssl/  
`Flexible`: not encrypts traffic from Cloudflare to your origin server.  
`Full`: 3 options for certificates to install on your server: one issued by a CA (`Strict`), one issued by [Cloudflare (Origin CA)](#cloudflare), or a self signed certificate.

Modern TLS: PCI 3.2 compliance requires either TLS 1.2 or 1.3  
Opportunistic Encryption: for HTTP-only domains  
Data centers without access to private keys will experience a slight initial delay.  
HSTS forces clients to use secure connections for every request

## HTTPS
[Automatic HTTPS Rewrites](https://support.cloudflare.com/hc/en-us/articles/227227647) safely eliminates **mixed content** issues by rewriting insecure URLs dynamically from known secure hosts to their secure counterpart.

[Page Rules - Always Use HTTPS](https://support.cloudflare.com/hc/en-us/articles/218411427#https)

[Page Rules - Forwarding URL](https://support.cloudflare.com/hc/en-us/articles/200170536)

## Real IP
https://support.cloudflare.com/hc/en-us/articles/200170986

https://support.cloudflare.com/hc/en-us/articles/200170706-How-do-I-restore-original-visitor-IP-with-Nginx-

# Google Analytics
https://analytics.google.com/analytics/web/#/.../admin/property/settings

## Enhanced Link Attribution
all links for which you want enhanced click attribution should have an ID attribute