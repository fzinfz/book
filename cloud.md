<!-- TOC -->

- [Google](#google)
    - [gcloud](#gcloud)
    - [gcs](#gcs)
- [QCloud](#qcloud)

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
