<!-- TOC -->

- [httpd.conf](#httpdconf)
- [VirtualHost](#virtualhost)
- [a2enmod](#a2enmod)
- [mod_ssl](#mod_ssl)
- [mod_proxy](#mod_proxy)
    - [ProxyPass](#proxypass)
- [IBM IHS](#ibm-ihs)
    - [Docker](#docker)
    - [Windows](#windows)

<!-- /TOC -->

# httpd.conf

    Options +Indexes
    AddDefaultCharset utf-8

# VirtualHost

IndexOptions FancyIndexing VersionSort NameWidth=*

# a2enmod

    a2enmod ssl

# mod_ssl
SSLProxyEngine: https://httpd.apache.org/docs/2.4/mod/mod_ssl.html#sslproxyengine  

# mod_proxy
ProxyPreserveHost: https://httpd.apache.org/docs/2.4/mod/mod_proxy.html#proxypreservehost  

## ProxyPass
https://httpd.apache.org/docs/2.4/mod/mod_proxy.html#proxypass  
https://httpd.apache.org/docs/2.4/howto/reverse_proxy.html 

    for m in proxy proxy_http proxy_balancer lbmethod_byrequests; do a2enmod $m; echo ----; done
    systemctl restart apache2; systemctl status apache2

    ProxyPass /tsadmin http://localhost:8000/
    ProxyPassReverse /tsadmin  http://localhost:8000/

# IBM IHS
## Docker
https://hub.docker.com/r/ibmcom/ibm-http-server

    docker run --name ibm-http-server -h IHS \
    -d --restart unless-stopped \
    --net host -v /:/host \
    ibmcom/ibm-http-server  

## Windows

    httpd.exe -k install -n "IBM HTTP Server V9.0"
    # Fixed name to address error:
    # The system cannot find the file specified.  : AH00436: No installed service named "IBM HTTP Server V9.0".
    apache.exe -k start

