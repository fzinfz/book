<!-- TOC -->

- [plain text/index/debug/proxy](#plain-textindexdebugproxy)
- [upstream](#upstream)

<!-- /TOC -->

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