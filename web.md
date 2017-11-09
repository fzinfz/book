<!-- TOC -->

- [Debugging](#debugging)
- [Nginx](#nginx)
- [SNI](#sni)
- [Varnish](#varnish)

<!-- /TOC -->

# Debugging
https://mitmproxy.org/  
allows traffic flows to be intercepted, inspected, modified and replayed.

# Nginx

    # Display file as text
    location /code/ {
        # All files in it
        location ~* {
            add_header Content-Type text/plain;
        }
    }

    location /somedir {
            autoindex on;
    }

# SNI
Server Name Indication (SNI) is an extension to the TLS  
allows a server to present multiple certificates on the same IP address and TCP port number  
Wiki: https://en.wikipedia.org/wiki/Server_Name_Indication

# Varnish
https://hub.docker.com/r/centos/varnish-4-centos7/  
https://access.redhat.com/containers/?tab=overview#/search/varnish
