<!-- TOC -->

- [Domain Name lookup](#domain-name-lookup)
- [Object Storage](#object-storage)
- [HIDS uninstall](#hids-uninstall)
  - [jcloud](#jcloud)
  - [aliyun](#aliyun)
  - [qcloud](#qcloud)

<!-- /TOC -->

# Domain Name lookup
https://lookup.icann.org/

# Object Storage
China：tx COS | ali/jd OSS | hw OBS

# HIDS uninstall
## jcloud
    wget http://hids.s-sq.jcloud.com/jcloudhids_linux64_V1.0.tar.gz
    tar zxvf jcloudhids_linux64_V1.0.tar.gz
    ./jcloudhids_linux64_V1.0.19216/uninstall.py

## aliyun

    rm -f /usr/local/share/aliyun-assist/1.0.1.259/aliyun-service

## qcloud

    /usr/local/sa/agent
    /usr/local/qcloud/monitor/barad/admin