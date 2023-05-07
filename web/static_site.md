<!-- TOC -->

- [Static Site Generator](#static-site-generator)
- [for Wiki](#for-wiki)
    - [Sphinx - Python](#sphinx---python)
        - [Builtin themes](#builtin-themes)
        - [Static Files](#static-files)
        - [Table](#table)
        - [Diagrams](#diagrams)
    - [MkDocs - Python](#mkdocs---python)
        - [mkdocs.yml](#mkdocsyml)
- [for Blogs](#for-blogs)
    - [Pelican - Python](#pelican---python)
- [Cloudflare Pages](#cloudflare-pages)
- [Github pages](#github-pages)
    - [Github Actions - SSR](#github-actions---ssr)
    - [Issue Blog](#issue-blog)
- [Free Hosting](#free-hosting)
- [Demos](#demos)

<!-- /TOC -->

# Static Site Generator
- ISR (incremental static regeneration)
- CSR(client-side rendering)
- SSG (Static Site Generation) 
- SSR (server-side rendering)

https://github.com/myles/awesome-static-generators

+ Vite powered/Unused JavaScript: https://astro.build/  
+ Vite & Vue powered: https://github.com/vuejs/vitepress  
+ Jekyll theme with search : https://github.com/just-the-docs/just-the-docs
+ Antora: multi repo into 1: https://docs.antora.org/antora/latest/
+ Jupyter: https://curvenote.com/docs/web/notebooks

# for Wiki
## Sphinx - Python
reStructuredText -> HTML, PDF, plain text, EPUB, TeX
- https://www.sphinx-doc.org/en/master/tutorial/getting-started.html

GraphiQL: https://github.com/hasura/sphinx-graphiql

### Builtin themes
https://www.sphinx-doc.org/en/master/usage/theming.html#builtin-themes
- only the Alabaster and Scrolls themes are mobile-optimated

### Static Files
https://www.sphinx-doc.org/en/master/usage/configuration.html
- html_static_path / html_css_files / html_js_files
- html_additional_pages: .html files

### Table
https://docs.espressif.com/projects/esp-docs/en/latest/writing-documentation/table.html
    - span: https://return42.github.io/linuxdoc/linuxdoc-howto/table-markup.html#flat-table

### Diagrams
https://chiplicity.readthedocs.io/en/latest/Using_Sphinx/UsingGraphicsAndDiagramsInSphinx.html

## MkDocs - Python
### mkdocs.yml
- https://github.com/mkdocs/mkdocs/blob/master/mkdocs.yml
- https://github.com/mkdocs/mkdocs/blob/master/mkdocs/tests/integration/complicated_config/mkdocs.yml
- https://gitlab.liris.cnrs.fr/pagoda/tools/mkdocs_template/-/blob/develop/user_config/mkdocs.local.yml

# for Blogs
## Pelican - Python
Markdown, reStructuredText, and HTML
- default theme -> blog : https://www.smashingmagazine.com/
- https://github.com/getpelican/pelican
- https://docs.getpelican.com/en/latest/index.html#documentation

# Cloudflare Pages
<YOUR_PROJECT_NAME>.pages.dev: https://developers.cloudflare.com/pages/platform/build-configuration/#framework-presets
- Static: Framework presets = None
- [Vue 3](https://developers.cloudflare.com/pages/framework-guides/deploy-a-vite3-project/): env NODE_VERSION>14.18

1 github repo => 1 cf project = 1 build kernel ([ref](https://community.cloudflare.com/t/cloudflare-pages-multiple-projects-with-a-single/287910))

# Github pages
CNAME: <user>.github.io

Gihub token: https://github.com/settings/tokens

## Github Actions - SSR
https://docs.github.com/en/actions/quickstart

    .github/workflows

check usage: https://github.com/settings/billing

## Issue Blog
Vue + JS: https://github.com/Yidadaa/Issue-Blog-With-Github-Action

# Free Hosting
|Free|Storage|month|
|---|---|---|
|[Github](https://docs.github.com/en/billing/managing-billing-for-github-actions/about-billing-for-github-actions)|500 MB|2000 min|
|[Cloudflare](https://developers.cloudflare.com/pages/platform/limits/)|25MiB/site|500 times|
|[vercel](https://vercel.com/pricing)||100GB b/w|
|[netlify](https://www.netlify.com/pricing/#features)|500 sites|100GB b/w(then $55 per 100GB)|

# Demos
- `vite --template vue` : https://github.com/fzinfz/test-vue3/tree/vite-js-quasar
  - https://test-vue3.pages.dev/
- `astro --template blog` : https://github.com/fzinfz/test-pages/tree/astro.blog
  - https://test-pages-7ku.pages.dev/
