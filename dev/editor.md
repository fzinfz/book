<!-- TOC -->

- [VSCode](#vscode)
  - [remote-ssh](#remote-ssh)
- [vi/vim](#vivim)
- [nano](#nano)

<!-- /TOC -->

# VSCode
- Regex - deleting empty lines: ^\s*$\n
- Command Palette: F1 / Ctrl+Shift+P
- Search Settings: Ctrl+, ==> search "XXX.YYY"
- github to web vscode: add "1s" in URL # https://github.com/conwnet/github1s
- extensions:
```
yzhang.markdown-all-in-one
shardulm94.trailing-spaces   # F1 => Trailing Spaces: Delete
```
- settings.json
```
"editor.renderWhitespace": "all",
"git.path": "D:\\sdk\\Git\\bin\\git.exe"
```

## remote-ssh
https://code.visualstudio.com/docs/remote/ssh  
extension: ms-vscode-remote.remote-ssh

    "remote.SSH.configFile": "D:\\conf\\ssh_config"

    Host 192.168.88.72
        HostName 192.168.88.72
        IdentityFile C:/Users/root/.ssh/id_rsa
        User root

F1 => Remote-SSH: Connect to Host...

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

# nano
CTRL + Shift + 6:   mark
CTRL + K:           cut/delete