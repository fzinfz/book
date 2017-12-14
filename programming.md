
<!-- TOC -->

- [Interactive coding notes](#interactive-coding-notes)
- [Scripts of Powershell/Python/etc](#scripts-of-powershellpythonetc)
- [Markdown](#markdown)
    - [Parser](#parser)
    - [Converter](#converter)
- [Windows Universal](#windows-universal)
    - [OCR](#ocr)

<!-- /TOC -->

# Interactive coding notes
http://nbviewer.jupyter.org/github/fzinfz/scripts/tree/master/jupyter/ 
[[Source](https://github.com/fzinfz/scripts/tree/master/jupyter)]

# Scripts of Powershell/Python/etc
https://github.com/fzinfz/scripts

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