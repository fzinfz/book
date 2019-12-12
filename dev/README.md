
<!-- TOC -->

- [Interactive coding notes](#interactive-coding-notes)
- [Scripts of Powershell/Python/etc](#scripts-of-powershellpythonetc)
- [GraphQL](#graphql)
- [Markdown](#markdown)
    - [Parser](#parser)
    - [Converter](#converter)
- [Windows Universal](#windows-universal)
    - [OCR](#ocr)
- [Excel](#excel)
    - [Formula](#formula)
    - [CSharp](#csharp)
- [CSharp](#csharp-1)
- [.Net Core](#net-core)

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
## Formula
https://exceljet.net/sites/default/files/styles/function_screen/public/images/formulas/Split%20text%20string%20at%20specific%20character.png?itok=WM1v7nsL

    =LEFT(B5,FIND("_",B5)-1)
    =RIGHT(B5,LEN(B5)-FIND("_",B5))

## CSharp
https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/interop/how-to-access-office-onterop-objects

# CSharp
async：https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/async/

# .Net Core
https://github.com/thangchung/awesome-dotnet-core