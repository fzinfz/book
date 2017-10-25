<!-- TOC -->

- [Web Vulnerability Scanner](#web-vulnerability-scanner)
- [WAF](#waf)
    - [ModSecurity](#modsecurity)
        - [Application Supported](#application-supported)
        - [pfsense](#pfsense)
        - [Open Web Application Security Project](#open-web-application-security-project)
    - [Nginx/OpenResty](#nginxopenresty)
    - [Cloud](#cloud)
    - [Hardware](#hardware)
- [Nginx](#nginx)
    - [Display file as text](#display-file-as-text)
- [SNI](#sni)

<!-- /TOC -->

# Web Vulnerability Scanner
https://github.com/anilbaranyelken/tulpar  
https://github.com/dpnishant/raptor

# WAF
## ModSecurity
https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual  
support Apache, IIS7 or Nginx  
Nginx: must be compiled with the source code of the main server

### Application Supported
https://modsecurity.org/application_coverage.html

### pfsense
http://pfsensesetup.com/wp-content/uploads/2014/10/pfsense_modsecurity01.png

### Open Web Application Security Project
https://coreruleset.org/
https://hub.docker.com/r/owasp/modsecurity/

## Nginx/OpenResty 
https://hub.docker.com/r/nodeintegration/nginx-modsecurity/  
https://github.com/p0pr0ck5/lua-resty-waf  
https://github.com/alexazhou/VeryNginx  
https://www.nginx.com/products/nginx-waf/#free-trial  
https://github.com/nbs-system/naxsi (Nginx Anti XSS & SQL Injection)

## Cloud
https://www.cloudflare.com/waf/  
https://aws.amazon.com/waf/  
https://www.aliyun.com/product/waf

## Hardware
http://help.sonicwall.com/help/sw/eng/8112/8/0/0/content/Chapter2_Overview.03.28.html  
https://www.cisco.com/c/en/us/products/collateral/application-networking-services/ace-web-application-firewall/data_sheet_c78-458627.html

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