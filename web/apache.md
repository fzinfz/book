<!-- TOC -->

- [httpd.conf](#httpdconf)
- [apache2](#apache2)
- [IBM IHS](#ibm-ihs)
    - [Docker](#docker)
    - [Windows](#windows)

<!-- /TOC -->

# httpd.conf

    Options +Indexes

# apache2

    a2enmod ssl

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

