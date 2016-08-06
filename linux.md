<!-- TOC -->

- [Shell Commands](#shell-commands)
	- [Check release & kernel](#check-release-kernel)
	- [systemctl](#systemctl)
	- [history without line numbers](#history-without-line-numbers)
	- [grep without self](#grep-without-self)
	- [sudo](#sudo)
- [my apt-get packages](#my-apt-get-packages)
- [Scripts](#scripts)
	- [auto add ssh key](#auto-add-ssh-key)
- [Files Description](#files-description)

<!-- /TOC -->

# Shell Commands
## Check release & kernel
```
lsb_release -a
uname -a

cat /etc/*-release
```
## history without line numbers
> history | cut -c 8-

## systemctl
https://wiki.archlinux.org/index.php/systemd

```
systemctl status

systemctl
systemctl --failed

systemctl list-unit-files
systemctl enable xxx
```


## sudo 
http://askubuntu.com/questions/376199/sudo-su-vs-sudo-i-vs-sudo-bin-bash-when-does-it-matter-which-is-used
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

# My Ubuntu/Debian packages
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
    sh /mnt/d/Dropbox/bash/add_ssh.sh
else
    echo "ssh-agent running"
fi
```

# Files Description
The ~/.bash_profile would be used once, at login.
The ~/.bashrc script is read every time a shell is started.