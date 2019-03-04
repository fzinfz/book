<!-- TOC -->

- [DHCP Options](#dhcp-options)
- [PXE](#pxe)
    - [Setup](#setup)
        - [Server - Windows](#server---windows)
        - [Mikrotik](#mikrotik)
        - [Mikrotik + Windows](#mikrotik--windows)

<!-- /TOC -->


# DHCP Options
http://www.iana.org/assignments/bootp-dhcp-parameters/bootp-dhcp-parameters.xhtml

https://tools.ietf.org/html/rfc2132

# PXE
https://blogs.technet.microsoft.com/dominikheinz/2011/03/18/dhcp-pxe-basics/

https://techcommunity.microsoft.com/t5/Configuration-Manager-Blog/You-want-to-PXE-Boot-Don-t-use-DHCP-Options/ba-p/275562

    66: TFTP server name
    67: Bootfile name

## Setup
### Server - Windows
http://tftpd32.jounin.net/tftpd32_download.html

### Mikrotik
    add code=66 name=next-server value="'192.168.88.248'"
    add code=67 name=boot-file value="'CentOS-7-x86_64-NetInstall-1810.iso'"


### Mikrotik + Windows
https://gist.github.com/PatrickLang/d891d4ed4bdf1d23ec584c44df7b0478