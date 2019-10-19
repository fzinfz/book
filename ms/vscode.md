
# remtoe-ssh
https://code.visualstudio.com/docs/remote/ssh

ssh.exe in sys PATH: C:\Program Files\Git\usr\bin

vscode conf:

    Host example-remote-linux-machine-with-identity-file
        User your-user-name-on-host
        HostName another-host-fqdn-or-ip-goes-here
        IdentityFile ~/.ssh/id_rsa-remote-ssh

