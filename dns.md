<!-- TOC -->

- [Domain Name System Security Extensions (DNSSEC)](#domain-name-system-security-extensions-dnssec)
- [unbound - C](#unbound---c)
- [DNSCrypt](#dnscrypt)
    - [server - public](#server---public)
    - [server - custom](#server---custom)
    - [client](#client)
- [pdnsd](#pdnsd)

<!-- /TOC -->

# Domain Name System Security Extensions (DNSSEC)
https://wiki.archlinux.org/index.php/DNSSEC  
a suite of Internet Engineering Task Force (IETF) specifications


# unbound - C
 a validating, recursive, and caching DNS resolver.
https://unbound.net/

# DNSCrypt
## server - public
https://github.com/jedisct1/dnscrypt-proxy/blob/0bbec277e61325a4a2f00e29ab039a7d308fb6c2/dnscrypt-resolvers.csv

## server - custom
`DNSCrypt-Wrapper`, the reference server-side DNSCrypt proxy.  
https://hub.docker.com/r/jedisct1/unbound-dnscrypt-server/

`dnsdist`, compiled with `--enable-dnscrypt`.  
`unbound`, compiled with `--enable-dnscrypt`.  

## client

    sudo apt install -y dnscrypt-proxy
    vi /etc/conf.d/dnscrypt-proxy

    DNSCRYPT_LOCALIP=127.0.0.1
    DNSCRYPT_LOCALPORT=1053
    DNSCRYPT_USER=dnscrypt
    DNSCRYPT_PROVIDER_NAME=2.dnscrypt-cert.opendns.com
    DNSCRYPT_PROVIDER_KEY=B735:1140:206F:225D:3E2B:D822:D7FD:691E:A1C3:3CC8:D666:8D0C:BE04:BFAB:CA43:FB79
    DNSCRYPT_RESOLVERIP=208.67.220.220
    DNSCRYPT_RESOLVERPORT=443

# pdnsd
https://wiki.archlinux.org/index.php/pdnsd

# BIND - C
https://wiki.archlinux.org/index.php/BIND