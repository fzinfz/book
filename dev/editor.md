<!-- TOC -->

- [Pritable](#pritable)
- [VSCode](#vscode)
    - [remote-ssh](#remote-ssh)
    - [Cloud IDE](#cloud-ide)
- [vi/vim](#vivim)
- [nano](#nano)
- [WebStorm](#webstorm)
    - [Terminal](#terminal)

<!-- /TOC -->

# Pritable
https://pandoc.org/getting-started.html

    pandoc -f html -t markdown                           # HTML to markdown
    pandoc test1.md -f markdown -t html -s -o test1.html # markdown to HTML
    # -s option says to create a “standalone” file, with a header and footer, not just a fragment. 

Chrome/Edge - print .md on Github: https://github.com/jerry1100/github-markdown-printer

# VSCode
- Regex - deleting empty lines: ^\s*$\n
- Command Palette: F1 / Ctrl+Shift+P
- Search Settings: Ctrl+, ==> search "XXX.YYY"
- github to web vscode: add "1s" in URL # https://github.com/conwnet/github1s
- extensions:
    - yzhang.markdown-all-in-one | https://github.com/yzhang-gh/vscode-markdown
    - huntertran.auto-markdown-toc | forked from alanwalk/markdown-toc | https://github.com/huntertran/markdown-toc
    - shardulm94.trailing-spaces   # F1 => Trailing Spaces: Delete
    - mhutchie.git-graph

- settings.json

        "editor.renderWhitespace": "all",
        "git.path": "D:\\sdk\\Git\\bin\\git.exe",
        "markdown.editor.pasteUrlAsFormattedLink.enabled": "never",
        "editor.detectIndentation": false,

## remote-ssh
https://code.visualstudio.com/docs/remote/ssh  
extension: ms-vscode-remote.remote-ssh

    "remote.SSH.configFile": "D:\\conf\\ssh_config"

    Host 192.168.88.72
        HostName 192.168.88.72
        IdentityFile C:/Users/root/.ssh/id_rsa  <== File permission: current user only
        User root

F1 => Remote-SSH: Connect to Host...

## Cloud IDE
https://theia-ide.org/docs/

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

# WebStorm
## Terminal
- Support ctrl+C/V , clickable links
- env != OS env: Settings | Tools | Terminal