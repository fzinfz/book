- [cli](#cli)
- [Tasks](#tasks)
- [GCS](#gcs)
- [fuse](#fuse)

# cli

    curl https://sdk.cloud.google.com | bash

    gcloud auth login

https://cloud.google.com/static/sdk/docs/images/gcloud-cheat-sheet.pdf

# Tasks
add project non-root ssh key: https://console.cloud.google.com/compute/metadata?tab=sshkeys  

# GCS

    export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
    echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install -y gcsfuse

    mkdir gcsfuse
    gcsfuse ferro-asia gcsfuse
    ls gcsfuse

# fuse
https://cloud.google.com/storage/docs/gcs-fuse

