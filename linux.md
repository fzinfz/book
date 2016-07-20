### check release & kernel
```
lsb_release -a
uname -a

cat /etc/*-release
```

### systemctl
https://wiki.archlinux.org/index.php/systemd  
```
systemctl status

systemctl
systemctl --failed

systemctl list-unit-files
systemctl enable xxx
```