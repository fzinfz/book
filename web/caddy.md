<!-- TOC -->

- [install](#install)
- [config](#config)
- [reverse](#reverse)

<!-- /TOC -->

# install

    echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" | sudo tee -a /etc/apt/sources.list.d/caddy-fury.list
    apt update && apt install caddy

# config
visit homepage for 1st guide
        
    vi /etc/caddy/Caddyfile
        :80 => domain.name

    caddy reload || systemctl reload caddy

    journalctl --no-pager -u caddy

# reverse
https://caddyserver.com/docs/caddyfile/directives/reverse_proxy

    reverse_proxy localhost:8000

    {
        reverse_proxy /websocket localhost:10000
    }