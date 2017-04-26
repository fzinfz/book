<!-- TOC -->

- [Unique Features](#unique-features)
- [RUN](#run)
    - [Startup Folder](#startup-folder)
    - [Date & Time](#date--time)
    - [Query .Net Framwork Versions](#query-net-framwork-versions)
    - [Auto Login](#auto-login)
- [CMD Commands](#cmd-commands)
    - [Networking](#networking)
- [CMD Tools](#cmd-tools)
    - [Check and unclock file](#check-and-unclock-file)
- [GUI Tools](#gui-tools)
    - [Cross-Platform](#cross-platform)
- [Configuration](#configuration)
    - [Disable Windows Defender](#disable-windows-defender)
    - [Registry locations](#registry-locations)
    - [NFS mount](#nfs-mount)
    - [Fix cifs/share mount:](#fix-cifsshare-mount)
- [Powershell](#powershell)
- [Hyper-V](#hyper-v)
    - [Check support](#check-support)
    - [Turn Off](#turn-off)
- [Installation](#installation)
    - [Tools](#tools)
    - [Force OOBE](#force-oobe)
    - [Fix boot partiton](#fix-boot-partiton)
    - [IDE to AHCI after Installation](#ide-to-ahci-after-installation)
    - [Uninstall software in safemode](#uninstall-software-in-safemode)

<!-- /TOC -->
# Unique Features
10: Free RemoteFX, WSL
2016: NFS Server, Hyper-V DDA

# RUN
## Startup Folder
- shell:startup
## Date & Time
- timedate.cpl
ntp.sjtu.edu.cn [202.120.2.100]

## Query .Net Framwork Versions
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP

## Auto Login
- netplwiz.exe


# CMD Commands
## Networking
```CMD
netstat -ano | findstr LISTEN
netsh interface portproxy add v4tov4 listenport=3333 listenaddress=0.0.0.0 connectport=3213 connectaddress=127.0.0.1 
route add 192.168.0.0  MASK 255.255.0.0 10.0.0.1
route add 172.16.0.0  MASK 255.255.0.0 10.0.0.1
netsh interface ip set address "Ethernet adapter Ethernet 2" static 192.168.3.5 255.255.255.0 192.168.3.2
```

# CMD Tools
## Check and unclock file
- https://download.sysinternals.com/files/Handle.zip
- http://unlocker.en.softonic.com/

# GUI Tools
- [SoftPerfect RAM Disk](https://www.softperfect.com/products/ramdisk/)

## Cross-Platform
- http://www.freerdp.com/
- [Password Recovery](https://hashcat.net/hashcat/)

# Configuration
## Disable Windows Defender
- gpedit.msc: Computer Configuration/Administrative Templates/Windows Components/Windows Defender

## Registry locations
- %WINDIR%\System32\config\
- https://technet.microsoft.com/en-in/library/cc750583(en-us).aspx

## NFS mount
- mount ip-of-NFS-Server:/Share-Name  x:

## Fix cifs/share mount:
```
net use * /del /yes
net use h: \\192.168.0.1\docs /user:ServerB\user Password 
```

# Powershell
Set-ExecutionPolicy RemoteSigned
Enable-PSRemoting -Force

Import-Module ServerManager
Add-WindowsFeature RDS-Virtualization

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

# Hyper-V 
## Check support
- systeminfo
 
## Turn Off  
```
C:\>bcdedit /copy {current} /d "No Hyper-V" 
The entry was successfully copied to {ff-23-113-824e-5c5144ea}. 

C:\>bcdedit /set {ff-23-113-824e-5c5144ea} hypervisorlaunchtype off 
The operation completed successfully.
```

# Installation
## Tools
- [winntsetup](http://www.msfn.org/board/topic/149612-winntsetup-v386/)

## Force OOBE
- Shift+F10 
- c:\windows\system32\oobe\msoobe.exe

## Fix boot partiton
+ EFI
```
diskpart
convert
create partition efi size=512
select partition 2
assign letter=b

bcdboot c:\windows /s h: /f UEFI
```

## IDE to AHCI after Installation
- HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\  
    iaStorV,iaStorAV,storahci: Start => 0  
    StartOverride => DELETE

## Uninstall software in safemode
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer" /VE /T REG_SZ /F /D "Service"
net start msiserver