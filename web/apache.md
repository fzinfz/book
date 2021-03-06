<!-- TOC -->

- [httpd.conf](#httpdconf)
- [a2enmod](#a2enmod)
- [ProxyPass](#proxypass)
- [IBM IHS](#ibm-ihs)
    - [Docker](#docker)
    - [Windows](#windows)

<!-- /TOC -->

# httpd.conf

    Options +Indexes

# a2enmod

    a2enmod ssl

# ProxyPass
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

