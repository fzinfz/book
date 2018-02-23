
<!-- TOC -->

- [Interactive coding notes](#interactive-coding-notes)
- [Scripts of Powershell/Python/etc](#scripts-of-powershellpythonetc)
- [GraphQL](#graphql)
- [vi/vim](#vivim)
    - [VISUAL BLOCK mode](#visual-block-mode)
- [VSCode](#vscode)
    - [extensions](#extensions)
    - [Debug Config](#debug-config)
- [Markdown](#markdown)
    - [Parser](#parser)
    - [Converter](#converter)
- [Windows Universal](#windows-universal)
    - [OCR](#ocr)
- [Excel](#excel)
    - [CSharp](#csharp)

<!-- /TOC -->

# Interactive coding notes
http://nbviewer.jupyter.org/github/fzinfz/scripts/tree/master/jupyter/ 
[[Source](https://github.com/fzinfz/scripts/tree/master/jupyter)]

# Scripts of Powershell/Python/etc
https://github.com/fzinfz/scripts

# GraphQL
http://graphql.org/  
a query language and execution engine tied to any backend service. 

    enum Episode { NEWHOPE, EMPIRE, JEDI }

    interface Character {
        id: String
        name: String
        friends: [Character]
        appearsIn: [Episode]
    }

    type Human implements Character {
        id: String
        name: String
        friends: [Character]
        appearsIn: [Episode]
        homePlanet: String
    }

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
    AlanWalk.markdown-toc
    shardulm94.trailing-spaces

## Debug Config
    # launch.json
    "args": [
        "--help", ""
    ],

# Markdown
## Parser
http://demo.showdownjs.com/  
https://github.com/showdownjs/showdown#browser

    var converter = new showdown.Converter();
    var md = '- works in the server and in the **browser**';
    var html = converter.makeHtml(md);

https://github.com/chjj/marked#browser  
https://github.com/jonschlinkert/remarkable  
https://github.com/evilstreak/markdown-js  
https://github.com/markdown-it/markdown-it  
https://github.com/evilstreak/markdown-js#browser

## Converter
Text/HTML table: https://html.ferro.pro/md.html  
CSV/WIKI table: http://jakebathman.github.io/Markdown-Table-Generator/  
HTML(non table): https://domchristie.github.io/to-markdown/  

# Windows Universal
## OCR
https://github.com/Microsoft/Windows-universal-samples/tree/master/Samples/OCR  
https://docs.microsoft.com/en-us/uwp/api/Windows.Media.Ocr

# Excel
## CSharp
https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/interop/how-to-access-office-onterop-objects
