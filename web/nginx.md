<!-- TOC -->

- [plain text/index/debug](#plain-textindexdebug)
- [Forward Proxy](#forward-proxy)
- [Reverse Proxy](#reverse-proxy)
    - [For Google](#for-google)

<!-- /TOC -->

# plain text/index/debug
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

# Forward Proxy
https://www.alibabacloud.com/blog/how-to-use-nginx-as-an-https-forward-proxy-server_595799

    server {
        listen  443;
        
        # dns resolver used by forward proxying
        resolver  114.114.114.114;

        # forward proxy for CONNECT request
        proxy_connect;
        proxy_connect_allow            443;
        proxy_connect_connect_timeout  10s;
        proxy_connect_read_timeout     10s;
        proxy_connect_send_timeout     10s;

        # forward proxy for non-CONNECT request
        location / {
            proxy_pass http://$host;
            proxy_set_header Host $host;
        }
    }


# Reverse Proxy
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

## For Google
https://github.com/bohanyang/onemirror  
OneMirror is a Docker image of Nginx, which already configured Google Search, Google Fonts and Gravatar proxy.
```
docker run -p 80:80 -d bohan/onemirror
```