<!-- TOC -->

- [HAProxy Health Check](#haproxy-health-check)
- [Squid - caching HTTP, HTTPS, FTP, and more](#squid---caching-http-https-ftp-and-more)
- [Debugging](#debugging)
- [SNI](#sni)
- [Varnish](#varnish)
  - [Real IP](#real-ip)
- [Free static site hosting](#free-static-site-hosting)
  - [Cloudflare Pages](#cloudflare-pages)
  - [Github pages](#github-pages)
    - [Github Actions - SSR](#github-actions---ssr)
- [Google Analytics](#google-analytics)
  - [Enhanced Link Attribution](#enhanced-link-attribution)

<!-- /TOC -->

# HAProxy Health Check
https://www.haproxy.com/documentation/aloha/7-0/haproxy/healthchecks/#checking-a-http-service

# Squid - caching HTTP, HTTPS, FTP, and more
http://www.squid-cache.org


# Debugging
https://mitmproxy.org/  
allows traffic flows to be intercepted, inspected, modified and replayed.

# SNI
Server Name Indication (SNI) is an extension to the TLS  
allows a server to present multiple certificates on the same IP address and TCP port number  
Wiki: https://en.wikipedia.org/wiki/Server_Name_Indication

# Varnish
https://hub.docker.com/r/centos/varnish-4-centos7/  
https://access.redhat.com/containers/?tab=overview#/search/varnish

## Real IP
https://support.cloudflare.com/hc/en-us/articles/200170986

https://support.cloudflare.com/hc/en-us/articles/200170706-How-do-I-restore-original-visitor-IP-with-Nginx-

# Free static site hosting
|Free|Storage|month|
|---|---|---|
|[Github](https://docs.github.com/en/billing/managing-billing-for-github-actions/about-billing-for-github-actions)|500 MB|2000 min|
|[Cloudflare](https://developers.cloudflare.com/pages/platform/limits/)|25MiB/site|500 times|
|[vercel](https://vercel.com/pricing)||100GB b/w|
|[netlify](https://www.netlify.com/pricing/#features)|500 sites|100GB b/w(then $55 per 100GB)|

## Cloudflare Pages
<YOUR_PROJECT_NAME>.pages.dev: https://developers.cloudflare.com/pages/platform/build-configuration/#framework-presets
- Static: Framework presets = None &
- Vue 3: env NODE_VERSION>14.18 : https://developers.cloudflare.com/pages/framework-guides/deploy-a-vite3-project/

1 github repo => 1 cf project = 1 build kernel ([ref](https://community.cloudflare.com/t/cloudflare-pages-multiple-projects-with-a-single/287910))

## Github pages
CNAME: <user>.github.io

Gihub token: https://github.com/settings/tokens

### Github Actions - SSR
https://docs.github.com/en/actions/quickstart

    .github/workflows

check usage: https://github.com/settings/billing

# Google Analytics
https://analytics.google.com/analytics/web/#/.../admin/property/settings

## Enhanced Link Attribution
all links for which you want enhanced click attribution should have an ID attribute