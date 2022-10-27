<!-- TOC -->

- [Windows 11](#windows-11)
- [Components](#components)
- [Driver Backup](#driver-backup)
- [powercfg](#powercfg)
- [Disable BitLocker](#disable-bitlocker)
  - [Networking](#networking)
- [Restore OS](#restore-os)
- [DotNet versions query](#dotnet-versions-query)
- [Edition Unique Features](#edition-unique-features)
- [WSL](#wsl)
  - [Mount Linux Partitions](#mount-linux-partitions)
  - [network - bridged to host](#network---bridged-to-host)
- [RUN](#run)
  - [Startup Folder](#startup-folder)
  - [Date & Time](#date--time)
  - [Query .Net Framwork Versions](#query-net-framwork-versions)
  - [Auto Login](#auto-login)
- [Configuration](#configuration)
  - [Disable Windows Defender](#disable-windows-defender)
  - [Disable update](#disable-update)
  - [Registry locations](#registry-locations)
  - [NFS mount](#nfs-mount)
  - [Fix cifs/share mount:](#fix-cifsshare-mount)
- [Installation](#installation)
  - [Tools](#tools)
  - [Force OOBE](#force-oobe)
- [BCD](#bcd)
  - [Fix boot](#fix-boot)
    - [update-grub](#update-grub)
  - [Fix boot partiton](#fix-boot-partiton)
    - [EFI](#efi)
  - [Copy Boot Entries](#copy-boot-entries)
  - [IDE to AHCI after Installation](#ide-to-ahci-after-installation)
  - [Uninstall software in safemode](#uninstall-software-in-safemode)
- [services.msc](#servicesmsc)
- [VS proxy](#vs-proxy)
- [AD](#ad)
  - [DC DNS](#dc-dns)
- [Graphic](#graphic)
- [Storge](#storge)
- [CMD Tools](#cmd-tools)
  - [Check and unclock file](#check-and-unclock-file)
- [Server Core](#server-core)
  - [MMC](#mmc)
- [GUI Tools](#gui-tools)
  - [sysinternals tools](#sysinternals-tools)
- [Linux Clients](#linux-clients)
- [WLAN Hosted Network](#wlan-hosted-network)
- [简繁体转换](#简繁体转换)
- [mstsc](#mstsc)
  - [GPU - NVIDIA](#gpu---nvidia)
  - [CredSSP](#credssp)
- [Disk tools](#disk-tools)
- [KMS Activation](#kms-activation)
  - [Windows](#windows)
  - [Office](#office)

<!-- /TOC -->

# Windows 11

    # Disable "Show more options" context menu
    reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

# Components

    DirextX Runtime: dxwebsetup
    .Net 4: dotNetFx40_Full_x86_x64.exe

# Driver Backup

    dism /online /export-driver /destination:d:\_drivers

# powercfg

    powercfg /a
    powercfg /hibernate off

# Disable BitLocker

    manage-bde -status
    manage-bde -off C:

    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\BitLocker]
    "PreventDeviceEncryption"=dword:00000001

## Networking
```CMD
netsh interface ipv4 show excludedportrange protocol=tcp

netstat -ano | findstr LISTEN
netsh interface portproxy add v4tov4 listenport=3333 listenaddress=0.0.0.0 connectport=3213 connectaddress=127.0.0.1 
route add 192.168.0.0  MASK 255.255.0.0 10.0.0.1
route add 172.16.0.0  MASK 255.255.0.0 10.0.0.1
netsh interface ip set address "Ether..." static 192.168.3.5 255.255.255.0 192.168.3.2

SUBST X: "D:\Folder_to_map"
```

# Restore OS
https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/boot-windows-to-audit-mode-or-oobe

    sysprep /generalize
    CTRL+SHIFT+F3 to audio mode

# DotNet versions query

    reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Version

# Edition Unique Features
10: Free RemoteFX, WSL  
2016: NFS Server, Hyper-V DDA

# WSL
https://learn.microsoft.com/en-us/windows/wsl/install

    wsl --list --online
    wsl --install -d Debian # default: Ubuntu
    wsl -l -v    # check installed Distributions
    wsl --status # check wsl kernel
    wsl --shutdown

https://learn.microsoft.com/en-us/windows/wsl/wsl-config

    # WSL2   global: C:\Users\<UserName>\.wslconfig
    # WSL1/2 per-distribution: /etc/wsl.conf  => automount, network, interop, user

    [boot]
    systemd=true

    [automount]
    

## Mount Linux Partitions

    wsl -v # Windows 11 Build 22000 or higher
    GET-CimInstance -query "SELECT * from Win32_DiskDrive"
    wsl --mount \\.\PHYSICALDRIVE0 --bare # attach but don't mount
    wsl --mount \\.\PHYSICALDRIVE2 --partition 2 --type  btrfs

## network - bridged to host
install hyper-v + manager, start WSL linux, change vSwitch type

    ip addr flush dev eth0
    dhclient eth0

# RUN
## Startup Folder
- shell:startup

## Date & Time
    timedate.cpl
        ntp.sjtu.edu.cn [202.120.2.100]

## Query .Net Framwork Versions
    reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP

## Auto Login
    netplwiz.exe

# Configuration
gpupdate

## Disable Windows Defender
- gpedit.msc: Computer Configuration/Administrative Templates/Windows Components/Windows Defender

## Disable update

  1. 计算机配置 -> 管理模板 -> Windows 组件 -> Windows 更新 -> Windows 更新不包括驱动程序
  2. 计算机配置 -> 管理模板 -> 系统 -> 设备安装 -> 指定设备驱动程序源位置的搜索顺序：启用并选择“不搜索 Windows 更新”

## Registry locations
- %WINDIR%\System32\config\
- https://technet.microsoft.com/en-in/library/cc750583(en-us).aspx

## NFS mount
Turn Windows features on or off -> Services for NFS

    # seems not working anymore (Dec 2019)
    Get-WindowsFeature -Name NFS*
    Install-WindowsFeature -Name NFS-Client

    mount 192.168.88.21:/  x:
    mount # show mounted
    umount -f z:

https://unix.stackexchange.com/questions/276292

    [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default]
    "AnonymousUid"=dword:000003e8
    "AnonymousGid"=dword:000003e8

## Fix cifs/share mount:
```
net use * /del /yes
net use h: \\192.168.0.1\docs /user:ServerB\user Password 
```

# Installation
## Tools
- [winntsetup](http://www.msfn.org/board/topic/149612-winntsetup-v386/)

## Force OOBE
- Shift+F10 
- c:\windows\system32\oobe\msoobe.exe

# BCD
GUI editor: http://www.zezula.net/en/fstools/bellavista.html

## Fix boot
https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/adding-boot-entries#adding-a-new-boot-en

### update-grub

    Found Windows Boot Manager on /dev/sdf1@/EFI/Microsoft/Boot/bootmgfw.efi

## Fix boot partiton
https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/bcdboot-command-line-options-techref-di#command-line-options

    bcdboot C:\Windows /s S: /f all

### EFI
\EFI\Boot\bootx64.efi

    diskpart
    convert
    create partition efi size=512
    select partition 2
    assign letter=b

    bcdboot c:\windows /s h: /f UEFI

## Copy Boot Entries 

    diskpart>
    list disk # check column Gpt
    list vol  # check column Label/Info: "System"

    # Do Not use PowerShell
    bcdedit /store g:\boot/bcd
    bcdedit /copy {current} /d "new" 
    bcdedit /set {}  device partition=W:
    bcdedit /set {}  osdevice partition=W:
    bcdedit /set {current} description "Windows 11 21H2"

## IDE to AHCI after Installation
- HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\  

    Win7  -> msahci：
    Win10 -> iaStorV,iaStorAV,storahci: 
        Start => 0  
        \StartOverride => DELETE

## Uninstall software in safemode
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer" /VE /T REG_SZ /F /D "Service"
net start msiserver

# services.msc

    sc create srv_name binpath= D:\_soft\foo.exe type= share start= auto 
sc delete srv_name

# VS proxy
%ProgramFiles%\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe.config
find the <system.net> block, and add this code:
  
    <defaultProxy enabled="true" useDefaultCredentials="true">  
        <proxy bypassonlocal="True" proxyaddress=" HYPERLINK "http://<yourproxy:port#" http://<yourproxy:port#>"/>  
    </defaultProxy> 

# AD
## DC DNS
https://blogs.msdn.microsoft.com/servergeeks/2014/07/12/dns-records-that-are-required-for-proper-functionality-of-active-directory/ (4. DC Record - _ldap._tcp.dc._msdcs.<DnsDomainName>)  

# Graphic
https://docs.microsoft.com/en-us/windows-hardware/drivers/display/  
https://en.wikipedia.org/wiki/Windows_Display_Driver_Model

XDDM/XPDM:Windows 2000 and Windows XP, removal of XDDM from Windows 8  
Windows Display Driver Model (WDDM): Windows Vista+  

    WDDM 2.0 - Windows 10+
        reduce workload on the kernel-mode driver for GPUs that support virtual memory addressing
        DXGI 1.4
            Cheaper adapter enumeration
            Video memory budget tracking
            Direct3D 12 Swapchain Changes

    WDDM 2.1 - 1607+
        Shader Model 6.0 (mandatory for feature levels 12_0 and 12_1)
        DXGI 1.5
            HDR10 - a 10-bit high dynamic range
            Wide Color Gamut

    WDDM 2.2 - 1703+
        tailored for virtual, augmented and mixed reality with stereoscopic rendering for the Windows Holographic platform
        DXGI 1.6: High Dynamic Range (HDR) Detection

    WDDM 2.3 - 1709+
        10-bit HDR playback over HDMI
        Video processing and video decode acceleration in DirectX* 12

# Storge
dynamic disks support the creation of new multipartition volumes

# CMD Tools
## Check and unclock file
- https://download.sysinternals.com/files/Handle.zip
- http://unlocker.en.softonic.com/

# Server Core
https://technet.microsoft.com/en-us/library/jj574205(v=ws.11).aspx

    cscript C:\Windows\System32\Scregedit.wsf /ar 0    # Enable RDS

## MMC
    Enable-NetFirewallRule -DisplayGroup "Remote Administration"

    cmdkey /add:<ServerName> /user:<UserName> /pass:<password>

# GUI Tools
List: https://www.hanselman.com/tools  
SoftPerfect RAM Disk: https://www.softperfect.com/products/ramdisk

## sysinternals tools
https://docs.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite

    process explorer
    - search opened file
    - locate handle process

# Linux Clients
http://www.freerdp.com/

# WLAN Hosted Network
    NETSH WLAN show drivers | findstr "Hosted network supported"
    NETSH WLAN set hostednetwork mode=allow ssid=SF3 key=12345678
    NETSH WLAN start hostednetwork

# 简繁体转换
win10: 先Ctrl+F，按住Ctrl，再按Shift+F

# mstsc
## GPU - NVIDIA
https://developer.nvidia.com/nvidia-opengl-rdp  
GeForce drivers R440 or later.

## CredSSP
gpedit.msc - Computer Configuration > Administrative Templates > System > Credentials Delegation
Encryption Oracle Remediation policy: Enabled > Protection Level: Vulnerable

# Disk tools
DM Disk Editor and Data Recovery  https://dmde.com/  (view for viewing)

# KMS Activation
## Windows

    CSCRIPT /NOLOGO C:\Windows\System32\SLMGR.VBS /?  # echo on console
    
https://technet.microsoft.com/en-us/library/jj612867.aspx

    slmgr /SKMS 192.168.88.72
    slmgr /ipk {GVLK}
    slmgr /ATO
    slmgr /dli
    slmgr /upk # back to trial

## Office
2016/2019/O365 Retail -> VL: https://github.com/kkkgo/office-C2R-to-VOL

https://docs.microsoft.com/en-us/deployoffice/vlactivation/gvlks

    cd OFFICE_DIR
    CSCRIPT OSPP.VBS /SETHST:192.168.88.101
    CSCRIPT OSPP.VBS /ACT