<!-- TOC -->

- [VSCode](#vscode)
    - [extensions](#extensions)
    - [User Config](#user-config)
    - [Tips](#tips)
    - [Debug Config](#debug-config)
    - [Web](#web)
    - [remtoe-ssh](#remtoe-ssh)
- [vi/vim](#vivim)

<!-- /TOC -->

# VSCode
## extensions

    huntertran.auto-markdown-toc
    shardulm94.trailing-spaces

## User Config
Ctrl+, ==> search "XXX.YYY" 

    "editor.renderWhitespace": "all", 
    "git.path": "D:\\sdk\\Git\\bin\\git.exe"  # open user's settings.json

## Tips
Regex for deleting empty lines: ^\s*$\n

## Debug Config
>launch.json

    "args": [
        "--help", ""
    ],

## Web
https://github.com/conwnet/github1s

## remtoe-ssh
>settings.json

    "remote.SSH.configFile": "D:\\conf\\ssh_config"

    Host 192.168.88.72
        HostName 192.168.88.72
        IdentityFile d:/conf/id_rsa
        User root


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

