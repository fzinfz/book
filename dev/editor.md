<!-- TOC -->

- [Pritable](#pritable)
- [vscode](#vscode)
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

# vscode
[/ms/vscode.md](/ms/vscode.md)

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