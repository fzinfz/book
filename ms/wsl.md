- [Install](#install)
  - [Mount Linux Partitions](#mount-linux-partitions)
  - [network - bridged to host](#network---bridged-to-host)

# Install
Windows 10 version 2004 and higher (Build 19041 and higher) or Windows 11: https://learn.microsoft.com/en-us/windows/wsl/install

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