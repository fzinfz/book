- [Tasks](#tasks)
    - [Check support](#check-support)
    - [Turn Off](#turn-off)
- [GPU](#gpu)

# Tasks
## Check support

    systeminfo

## Turn Off
```
C:\>bcdedit /copy {current} /d "No Hyper-V" 
The entry was successfully copied to {ff-23-113-824e-5c5144ea}. 

C:\>bcdedit /set {ff-23-113-824e-5c5144ea} hypervisorlaunchtype off 
The operation completed successfully.
```

# GPU
GPU-PV allows you to partition your systems dedicated or integrated GPU and assign it to several Hyper-V VMs. It's the same technology that is used in WSL2, and Windows Sandbox.
- https://github.com/jamesstringerparsec/Easy-GPU-PV