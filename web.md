<!-- TOC -->

- [Debugging](#debugging)
- [Nginx](#nginx)
    - [upstream](#upstream)
- [SNI](#sni)
- [Varnish](#varnish)
- [Let's Encrypt](#lets-encrypt)

<!-- /TOC -->

# Debugging
https://mitmproxy.org/  
allows traffic flows to be intercepted, inspected, modified and replayed.

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

        error_log /var/logs/nginx/error-foo.log debug;
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

health checks is available as part of commercial subscription.

# SNI
Server Name Indication (SNI) is an extension to the TLS  
allows a server to present multiple certificates on the same IP address and TCP port number  
Wiki: https://en.wikipedia.org/wiki/Server_Name_Indication

# Varnish
https://hub.docker.com/r/centos/varnish-4-centos7/  
https://access.redhat.com/containers/?tab=overview#/search/varnish

# Let's Encrypt
https://certbot.eff.org/

    ./certbot-auto certonly --webroot -w  /usr/share/nginx/www/ -d example.com  -d www.example.com

    /etc/letsencrypt/live/example.com/ -> /etc/letsencrypt/archive/example.com/
    cert.pem  chain.pem  fullchain.pem  privkey.pem -> cert1.pem  chain1.pem  fullchain1.pem  privkey1.pem