<!-- TOC -->

- [Shell Commands](#shell-commands)
	- [Files](#files)
	- [Dropbox](#dropbox)
	- [install](#install)
		- [Debian/Ubuntu](#debianubuntu)
	- [Networking](#networking)
		- [iptables](#iptables)
		- [firewall-cmd](#firewall-cmd)
		- [systemctl](#systemctl)
- [Web](#web)
	- [System](#system)
- [My packages](#my-packages)
- [Scripts](#scripts)
	- [auto add ssh key](#auto-add-ssh-key)

<!-- /TOC -->

# Shell Commands

## Files
> find top largest files & clean space
```
sudo du -hcd 2  / | more
sudo  du -a / | sort -n -r | head -n 20
sudo apt-get autoclean
```

### Dropbox
> link account
- ~/.dropbox-dist/dropboxd
- dropboxd will create a ~/Dropbox folder and start synchronizing it after this step!
> unlink
- https://www.dropbox.com/account#security  

> Files Description  
- The ~/.bash_profile would be used once, at login.
- The ~/.bashrc script is read every time a shell is started.

## install
### Debian/Ubuntu
```
sudo apt-get update
sudo apt-get install packagename
sudo apt-get install -f
```

## Networking
- sudo dhclient -r eth0

### iptables
```
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables-save
sudo sh -c "iptables-save > /etc/iptables.rules"
```

### firewall-cmd
```
firewall-cmd --zone=public --add-port=8081/tcp --permanent

firewall-cmd --permanent --zone=public \
--add-rich-rule="rule family="ipv4" \
source address="1.2.3.4/32" \
port protocol="tcp" port="4567" accept"

firewall-cmd --reload
firewall-cmd --list-all
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

# Web
```
./certbot-auto certonly --webroot -w  /usr/share/nginx/www/ -d example.com  -d www.example.com
/etc/letsencrypt/live/example.com/ -> /etc/letsencrypt/archive/example.com/ 
cert.pem  chain.pem  fullchain.pem  privkey.pem -> cert1.pem  chain1.pem  fullchain1.pem  privkey1.pem

## Jupyter
http://jupyter-notebook.readthedocs.io/en/latest/public_server.html#using-lets-encrypt
jupyter notebook --generate-config
In [1]: from notebook.auth import passwd
In [2]: passwd("pwd")
jupyter notebook --certfile=cert1.pem --keyfile privkey1.pem
```

## System
> Check release & kernel
```
lsb_release -a
uname -a

cat /etc/*-release
```

> path
- PATH=$PATH:~/opt/bin

> Timezone
- TZ='Asia/Shanghai'; export TZ

> history without line numbers
- history | cut -c 8-

> Serial Console
https://wiki.openwrt.org/doc/hardware/port.serial
```
cat openwrt-lantiq-ram-u-boot.asc > /dev/ttyUSB0
screen /dev/ttyUSB0 115200
picocom -b 115200 /dev/ttyUSB0
```
> sudo  
- http://askubuntu.com/questions/376199/sudo-su-vs-sudo-i-vs-sudo-bin-bash-when-does-it-matter-which-is-used
```bash
fzinfz@SF3:/mnt/c/Users/fzinfz$ bash
ssh-agent running
fzinfz/.bashrc executed

fzinfz@SF3:/mnt/c/Users/fzinfz$ sudo su
[sudo] password for fzinfz:
/root/.bashrc executed
root@SF3:/mnt/c/Users/fzinfz# exit
exit

fzinfz@SF3:/mnt/c/Users/fzinfz$ sudo su -
/root/.bashrc executed
root@SF3:~# exit
logout

fzinfz@SF3:/mnt/c/Users/fzinfz$ sudo /bin/bash
ssh-agent running
fzinfz/.bashrc executed
root@SF3:/mnt/c/Users/fzinfz# exit
exit

fzinfz@SF3:/mnt/c/Users/fzinfz$ sudo -s
ssh-agent running
fzinfz/.bashrc executed
root@SF3:/mnt/c/Users/fzinfz# exit
exit

fzinfz@SF3:/mnt/c/Users/fzinfz$ sudo -i
/root/.bashrc executed
```

# My packages
```
apt-get install git
apt-get install ipython3
apt-get install aria2
```

# Scripts
## auto add ssh key
```shell
echo 'ps grep excluding grep pid'
RESULT_ssh_agent =`ps -aux | sed -n /[s]sh-agent/p`

if [ "${RESULT_ssh_agent:-null}" = null ]; then
	chmod 600 /home/fzinfz/.ssh/id_rsa_vultr
	eval $(ssh-agent -s)
	ssh-add /home/fzinfz/.ssh/id_rsa_vultr
else
    echo "ssh-agent running,skip adding"
fi

```
