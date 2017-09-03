<!-- TOC -->

- [Nginx](#nginx)
    - [Display file as text](#display-file-as-text)
- [SNI](#sni)

<!-- /TOC -->

# Nginx
## Display file as text
```
location /code/ {
    # All files in it
    location ~* {
        add_header Content-Type text/plain;
    }
}

location /somedir {
        autoindex on;
}
```

# SNI
Server Name Indication (SNI) is an extension to the TLS
allows a server to present multiple certificates on the same IP address and TCP port number
Wiki: https://en.wikipedia.org/wiki/Server_Name_Indication