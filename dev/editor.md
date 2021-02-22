<!-- TOC -->

- [vi/vim](#vivim)
- [Markdown + LaTeX](#markdown--latex)
- [VSCode](#vscode)
    - [extensions](#extensions)
    - [User Config](#user-config)
    - [Git](#git)
    - [Debug Config](#debug-config)
    - [Web](#web)
    - [remtoe-ssh](#remtoe-ssh)

<!-- /TOC -->

# vi/vim

    go to line: Esc , line#, Shift-g
    :%s/pattern/replace/g_  # i/I: case in/sensitive    
    cw => change word
    ciw => change word from cursor
    :w !sudo tee %      ===> sudo save

    ~/.vimrc
    set nocompatible # fix array not working in insert mode

* Visual Insert Mode  
    paste: Shift+Insert
    
* VISUAL BLOCK mode  
    Ctrl+V；【select block】；Shift + I; 【type text】; Esc

# Markdown + LaTeX
https://github.com/pandao/editor.md

# VSCode
## extensions

    AlanWalk.markdown-toc # Settings(Ctrl+,): Set files.eol to "\n" or "\r\n" in vscode settings.
    shardulm94.trailing-spaces

## User Config
Ctrl+, (Ctrl + P => type ">User Settings") ==> search "foo.bar"

## Git

    "git.path": "C:\\...\\git.exe",

## Debug Config

    # launch.json
    "args": [
        "--help", ""
    ],

## Web
https://github.com/conwnet/github1s

## remtoe-ssh
https://code.visualstudio.com/docs/remote/ssh

ssh.exe in sys PATH: C:\Program Files\Git\usr\bin

vscode conf:

    Host example-remote-linux-machine-with-identity-file
        User your-user-name-on-host
        HostName another-host-fqdn-or-ip-goes-here
        IdentityFile ~/.ssh/id_rsa-remote-ssh