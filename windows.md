# Commands
## Run
> shell:startup

## Powershell
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
### check support: 
> systeminfo
 
### Turn Off  
```
C:\>bcdedit /copy {current} /d "No Hyper-V" 
The entry was successfully copied to {ff-23-113-824e-5c5144ea}. 

C:\>bcdedit /set {ff-23-113-824e-5c5144ea} hypervisorlaunchtype off 
The operation completed successfully.
```

# Installation
## Tools
> [winntsetup](http://www.msfn.org/board/topic/149612-winntsetup-v386/)

## Errors
* "Windows setup could not configure to run on this computer's hardware"
    - Shift+F10 
    - c:\windows\system32\oobe\msoobe.exe

* Fix boot partiton
    + EFI
        - bcdboot c:\windows /s h: /f UEFI