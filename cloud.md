<!-- TOC -->

- [Google](#google)
    - [gcloud](#gcloud)
    - [gcs](#gcs)
- [QCloud](#qcloud)
- [Vendors](#vendors)
    - [Pricing](#pricing)
        - [Instance](#instance)
        - [Traffic](#traffic)
    - [Free](#free)
- [HIDS uninstall](#hids-uninstall)
    - [jcloud](#jcloud)

<!-- /TOC -->

# Google
https://cloud.google.com/storage/docs/gcs-fuse

## gcloud
```
curl https://sdk.cloud.google.com | bash

gcloud auth application-default login
```

## gcs
```
export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y gcsfuse

mkdir gcsfuse
gcsfuse ferro-asia gcsfuse
ls gcsfuse
```

# QCloud
/usr/local/sa/agent
/usr/local/qcloud/monitor/barad/admin

# Vendors
## Pricing
https://aws.amazon.com/free/  
https://aws.amazon.com/ec2/pricing/  
https://aws.amazon.com/ec2/pricing/reserved-instances/pricing/
https://aws.amazon.com/blogs/aws/ec2-update-t2-nano-instances-now-available/  
Traffic: https://aws.amazon.com/ec2/pricing/on-demand/
https://calculator.s3.amazonaws.com/index.html

https://azure.microsoft.com/en-us/pricing/calculator/   
https://azure.microsoft.com/en-us/pricing/details/app-service/  
https://azure.microsoft.com/en-us/pricing/details/bandwidth/

https://cloud.google.com/pricing/  
https://cloud.google.com/compute/pricing  
https://cloud.google.com/storage/pricing

### Instance
Amazon: 5% vCPU + 0.5GB, 3 Year Reserved Instance $69  
Google: 20% vCPU + 0.60GB,	Free - $4.09  
Microsoft: 1vCPU + 0.75 GiB, 	~$13.40/mo

### Traffic
Amazon: 1GB to 10 TB / month $0.090 per GB, Singapore to China 	$0.120 per GB  
Google: $0.12 - $0.23 / GB, Singapore to China $0.23  
Microsoft: 5 GB - 10 TB 2 /Month $0.087 - $0.181 per GB, Japan to China $0.138 per GB

https://www.vultr.com/pricing/  
https://www.linode.com/pricing   
https://www.digitalocean.com/pricing/

https://www.aliyun.com/price/product?#/ecs/detail (Compute)  
https://help.aliyun.com/document_detail/25382.html (HDD)  
https://www.qcloud.com/document/product/213/2179  
https://www.qingcloud.com/pricing/plan
https://www.sinacloud.com/index/price.html   
https://www.daocloud.io/pricing/public.html  

## Free 
https://cloud.google.com/free/docs/always-free-usage-limits
https://aws.amazon.com/free/
https://tryappservice.azure.com 

$200: https://azure.microsoft.com/en-us/offers/ms-azr-0044p/  
DigitalOcean $20: https://cloud.docker.com

# HIDS uninstall
## jcloud
    wget http://hids.s-sq.jcloud.com/jcloudhids_linux64_V1.0.tar.gz
    tar zxvf jcloudhids_linux64_V1.0.tar.gz
    ./jcloudhids_linux64_V1.0.19216/uninstall.py
