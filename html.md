
<!-- TOC -->

- [HTML5](#html5)
    - [lang](#lang)
    - [Subresource Integrity](#subresource-integrity)
- [CSS box model](#css-box-model)
    - [box-sizing](#box-sizing)
    - [content](#content)
    - [padding](#padding)
    - [border](#border)
    - [margin](#margin)
- [Mobile](#mobile)
- [Bootstrap](#bootstrap)
    - [Version 3](#version-3)
    - [Version 4](#version-4)
    - [Grid system](#grid-system)
    - [Demo](#demo)

<!-- /TOC -->

# HTML5
https://www.w3.org/TR/html5

## lang
empty string indicates that the primary language is unknown

https://www.w3.org/TR/html5/dom.html#the-lang-and-xml:lang-attributes  
http://www.ietf.org/rfc/bcp/bcp47.txt  

## Subresource Integrity
https://www.w3.org/TR/SRI/#resource-integrity

# CSS box model
https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Box_Model/Introduction_to_the_CSS_box_model  
Every box is composed of four parts (or areas), defined by their respective edges.  
![](https://mdn.mozillademos.org/files/8685/boxmodel-(3).png)  

## box-sizing
https://developer.mozilla.org/en-US/docs/Web/CSS/box-sizing

`content-box` is the default.  
`border-box` tells the browser to account for any border and padding in the value you specify for width and height. 

## content
"real" content of the element  

size can be explicitly defined with the width, min-width, max-width, height, min-height, and max-height properties.  

When the content area has a background, it extends into the padding.

## padding
extends the content area to include the element's padding.

    dimensions: padding-box width/height
    thickness: padding[-top/right/bottomleft]

## border
extends the padding area to include the element's borders.

    dimensions: border-box width/height
    thickness: border[-width]

If the box-sizing property is set to border-box, the border area's size can be explicitly defined with the width, min-width, max-width, height, min-height, and max-height properties.

## margin
extends the border area to include an empty area used to separate the element from its neighbors.

    dimensions: margin-box width/height
    size: margin[-top/right/bottomleft]

When margin collapsing occurs, the margin area is not clearly defined since margins are shared between boxes.  
https://developer.mozilla.org/en/CSS/margin_collapsing

# Mobile
https://developer.mozilla.org/en-US/docs/Mozilla/Mobile/Viewport_meta_tag

    viewport: a virtual "window"
    viewport meta tag: let web developers control the viewport's size and scale.

https://developer.apple.com/library/content/documentation/AppleApplications/Reference/SafariHTMLRef/Articles/MetaTags.html#//apple_ref/doc/uid/TP40008193

    initial-scale: The default is calculated to fit the webpage in the visible area.
    maximum-scale:  The default is 5.0. The range is from >0 to 10.0.
    user-scalable: whether or not the user can zoom in and out. yes
    shrink-to-fit=no: override  "width=device-width" to prevent the page from scaling
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">

# Bootstrap
## Version 3
https://getbootstrap.com/docs/3.3/getting-started/#download-cdn  

## Version 4
https://v4-alpha.getbootstrap.com/getting-started/introduction/#starter-template

http://blog.getbootstrap.com/2017/08/10/bootstrap-4-beta/

- compiles faster than ever thanks to Libsass
- moved nearly everything to flexbox, added a new grid tier to better target mobile devices, and completely overhauled our source Sass with better variables, mixins, and now maps, too.
- https://getbootstrap.com/docs/4.0/components/card/
- move gradients, transitions, shadows, grid classes, and more into Sass variables. 
- drop support for IE8/IE9, Safari 8-, iOS 8-, etc
- JS plugins in ES6. new teardown methods, option type checking, new methods, and more.
- auto-placement of tooltips, popovers, and dropdowns from https://popper.js.org
- npm scripts instead of Grunt

## Grid system
https://getbootstrap.com/docs/3.3/css/#grid

Rows must be placed within a .container[-fluid] for proper alignment and padding.
Columns create gutters (gaps between column content) via `padding`. That padding is offset in rows for the first and last column via negative margin on `.rows`.

## Demo
https://fzinfz.github.io/scripts/