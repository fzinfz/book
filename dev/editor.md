<!-- TOC -->

- [vi/vim](#vivim)
    - [VISUAL BLOCK mode](#visual-block-mode)
- [VSCode](#vscode)
    - [extensions](#extensions)
    - [Debug Config](#debug-config)

<!-- /TOC -->

# vi/vim
    go to line: Esc , line#, Shift-g
    :%s/pattern/replace/g_  # i/I: case in/sensitive    
    cw => change word
    ciw => change word from cursor
    :w !sudo tee %      ===> sudo save

## VISUAL BLOCK mode
    Ctrl+V；【select】；Shift + I; 【type text】; Esc

# VSCode
## extensions
    AlanWalk.markdown-toc # Settings(Ctrl+,): Set files.eol to "\n" or "\r\n" in vscode settings.
    shardulm94.trailing-spaces

## Debug Config
    # launch.json
    "args": [
        "--help", ""
    ],
