<!-- TOC -->

- [Static Site Generator](#static-site-generator)
    - [MkDocs - Python](#mkdocs---python)
        - [mkdocs.yml](#mkdocsyml)
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

## MkDocs - Python
### mkdocs.yml
- https://github.com/mkdocs/mkdocs/blob/master/mkdocs.yml
- https://github.com/mkdocs/mkdocs/blob/master/mkdocs/tests/integration/complicated_config/mkdocs.yml
- https://gitlab.liris.cnrs.fr/pagoda/tools/mkdocs_template/-/blob/develop/user_config/mkdocs.local.yml

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
