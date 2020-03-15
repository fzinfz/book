<!-- TOC -->

- [storage](#storage)
- [cli](#cli)
    - [vm](#vm)
    - [disk](#disk)

<!-- /TOC -->

# storage
https://docs.microsoft.com/en-us/azure/virtual-machines/windows/disks-types

||Ultra disk|Premium SSD|Standard SSD|Standard HDD|
|---|---|---|---|---|
|Max throughput|2,000 MiB/s|900 MiB/s|750 MiB/s|500 MiB/s|
|Max IOPS|160,000|20,000|6,000|2,000|

|Premium SSD sizes |P1*|P2*|P3*|P4|P6|P10|P15|P20|P30|P40|P50|P60|P70|P80|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|Disk size in GiB|4|8|16|32|64|128|256|512|1,024|2,048|4,096|8,192|16,384|32,767|
|IOPS per disk|120|120|120|120|240|500|1,100|2,300|5,000|7,500|7,500|16,000|18,000|20,000|

# cli
https://shell.azure.com/bash

    # Powershell
    Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

    # Linux apt
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

    # Linux all
    curl -L https://aka.ms/InstallAzureCli | bash
    
    docker run -it -v ${HOME}/.ssh:/root/.ssh mcr.microsoft.com/azure-cli
    
    az login
    az resource list

## vm
https://docs.microsoft.com/en-us/cli/azure/vm?view=azure-cli-latest
    
    az vm list --output table --show-details
    az vm stop/deallocate/start --resource-group linux --name ubuntu-2     

## disk
https://docs.microsoft.com/en-us/cli/azure/disk?view=azure-cli-latest#az-disk-update

    az disk list --resource-group linux --output table
    az disk update --resource-group linux --name ubuntu-2_OsDisk_1_74250d56f08040e1a48f38b9198148f7 --size-gb 32    
    az disk update --resource-group linux --name ubuntu-2_OsDisk_1_74250d56f08040e1a48f38b9198148f7 --sku Premium_LRS
