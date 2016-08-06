<!-- TOC -->

- [CMD](#cmd)
- [CMD Tools](#cmd-tools)
- [GUI Tools](#gui-tools)
- [Configuration](#configuration)
- [Powershell](#powershell)
- [VT](#vt)
	- [Hyper-V](#hyper-v)
- [Installation](#installation)

<!-- /TOC -->

# CMD
> startup DIR
- shell:startup

> Auto Login
- netplwiz.exe

> Run console background  
- START /B program > log.txt

> Networking
- netstat -ano | findstr LISTEN
- netsh interface portproxy add v4tov4 listenport=3333 listenaddress=0.0.0.0 connectport=3213 connectaddress=127.0.0.1 

# CMD Tools
> Check which process opening the file
- https://download.sysinternals.com/files/Handle.zip

# GUI Tools
- [SoftPerfect RAM Disk](https://www.softperfect.com/products/ramdisk/)

# Configuration
> Disable Windows Defender
- gpedit.msc: Computer Configuration/Administrative Templates/Windows Components/Windows Defender

> Registry locations
- %WINDIR%\System32\config\
- https://technet.microsoft.com/en-in/library/cc750583(en-us).aspx

> NFS mount
- mount ip-of-NFS-Server:/Share-Name  x:

> fix cifs/share mount:
```
net use * /del /yes
net use h: \\192.168.0.1\docs /user:ServerB\user Password 
```

# Powershell
```Powershell
#list top processes sort by memory
Get-Process | Sort WorkingSet -Descending  | select-object  Id, Name, 
@{Name='WorkingSet(Mb)';Expression={"{0:N2}" -f ($_.WorkingSet / 1Mb)}}, 
@{Name='PrivateMemorySize(Mb)';Expression={"{0:N2}" -f ($_.PrivateMemorySize / 1Mb)}}, 
@{Name='PM(Mb)';Expression={"{0:N2}" -f ($_. PM/ 1Mb)}}, 
@{Name='NPM(Mb)';Expression={"{0:N2}" -f ($_. NPM/ 1Mb)}}  `
 -First 10 | Format-Table

#sum memory of all processes
Get-Process  | measure-object -sum 'PrivateMemorySize', PM,NPM,WS  |  
select-object  @{Name='Sum(Gb)';Expression={"{0:N2}" -f ($_.sum / 1Gb  ) }  } ,count, Property

#list and grep process members
Get-Process | Get-Member | findstr Mem

#another way to query process
Get-WMIObject Win32_Process | 
```

# VT
## Hyper-V 
> check support
- systeminfo
 
> Turn Off  
```
C:\>bcdedit /copy {current} /d "No Hyper-V" 
The entry was successfully copied to {ff-23-113-824e-5c5144ea}. 

C:\>bcdedit /set {ff-23-113-824e-5c5144ea} hypervisorlaunchtype off 
The operation completed successfully.
```

# Installation
> Tools
- [winntsetup](http://www.msfn.org/board/topic/149612-winntsetup-v386/)

> Force OOBE
- Shift+F10 
- c:\windows\system32\oobe\msoobe.exe

> Fix boot partiton
+ EFI
    - bcdboot c:\windows /s h: /f UEFI

> IDE to AHCI after Installation
- HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\  
    iaStorV,iaStorAV,storahci: Start => 0  
    StartOverride => DELETE
