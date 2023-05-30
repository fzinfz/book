<!-- TOC -->

- [Frameworks](#frameworks)
- [Basic](#basic)
  - [text](#text)
  - [export \& import](#export--import)
- [the default export can be imported with any name](#the-default-export-can-be-imported-with-any-name)
  - [this](#this)
  - [IIFE (Immediately Invokable Function Expression)](#iife-immediately-invokable-function-expression)
  - [Chrome Cross origin requests](#chrome-cross-origin-requests)
  - [pdf.js](#pdfjs)
- [JQuery](#jquery)
  - [events](#events)
- [JSX](#jsx)
- [MDX](#mdx)
- [node](#node)
  - [Version Manager](#version-manager)
    - [volta](#volta)
    - [nvm](#nvm)

<!-- /TOC -->

# Frameworks
- Vue: https://nuxtjs.org/
- React: https://nextjs.org/

# Basic

## text

    if ("ab"+"c".includes("bc")) { t="_3"; console.log(`t${t}`.replace(/\d/, "").length); } else if (true) {} else { } // Out: 2

## export & import
- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export
- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import

  # the default export can be imported with any name
  export default k;  // file test.js
  import anyName from "./test";

## this
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/this

    const test = {
      prop: 42,
      func: function() {
        return this.prop;
      },
    };

## IIFE (Immediately Invokable Function Expression)
    (function() {
        statements
    })();

## Chrome Cross origin requests
Cross origin requests are only supported for protocol schemes:  
http, data, chrome, chrome-extension, https.

## pdf.js
https://github.com/mozilla/pdf.js/tree/master/examples/helloworld

# JQuery
## events
http://api.jquery.com/category/events/

# JSX
an XML-like syntax extension to ECMAScript without any defined semantics: https://facebook.github.io/jsx/
`const element = <h1>Hello, world!</h1>;`: https://zh-hans.reactjs.org/docs/introducing-jsx.html

# MDX
JSX + Markdown: https://mdxjs.com/docs/what-is-mdx/

# node
Schedule
![](https://raw.githubusercontent.com/nodejs/Release/master/schedule.svg)

## Version Manager
### volta
https://volta.sh/

    volta list
    volta install node@18

### nvm
https://github.com/nvm-sh/nvm
