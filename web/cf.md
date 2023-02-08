- [Network ports](#network-ports)
- [Rules](#rules)
- [SSL/TLS](#ssltls)
  - [SSL Modes](#ssl-modes)
  - [Edge Certificates](#edge-certificates)
  - [Origin CA](#origin-ca)
- [CNAME Flattening](#cname-flattening)
- [Workers](#workers)
  - [Wrangler (Workers CLI)](#wrangler-workers-cli)
- [Workers as Reverse Proxy](#workers-as-reverse-proxy)
  - [Bulk origin override](#bulk-origin-override)
  - [Reflare](#reflare)
- [Storage](#storage)
  - [R2 - S3 object](#r2---s3-object)
  - [KV - key-value](#kv---key-value)
  - [D1 - RDB](#d1---rdb)
  - [Durable Objects - Workers Paid plan](#durable-objects---workers-paid-plan)
  - [Queues - Workers Paid plan](#queues---workers-paid-plan)
- [Paid](#paid)

# Network ports
HTTP: 80 8080 | No caching: 8880 2052 2082 2086 2095  
HTTPS: 443 | No caching: 2053 2083 2087 2096 8443

# Rules
Settings - URL normalization: https://developers.cloudflare.com/rules/normalization/how-it-works/

https://developers.cloudflare.com/rules/
- [order](https://developers.cloudflare.com/rules/configuration-rules/#execution-order): Origin -> Cache -> Conf -> Single -> Page

|Name|Free|Desc|
|---|---|---|
[Transform Rules](https://developers.cloudflare.com/rules/transform/) | free 10 | no Regex support
[Origin Rules](https://developers.cloudflare.com/rules/origin-rules/) | 10 | Override destination port
[Cache Rules](https://developers.cloudflare.com/cache/about/cache-rules/)  | 10 | cache properties of your HTTP requests
[Configuration Rules](https://developers.cloudflare.com/rules/configuration-rules/) | 10 | [expressions](https://developers.cloudflare.com/firewall/cf-dashboard/edit-expressions/) / no Regex support
[Single Redirects](https://developers.cloudflare.com/rules/url-forwarding/bulk-redirects/concepts/) | 5~20 |
[Page Rules](https://support.cloudflare.com/hc/en-us/articles/218411427) | 3 | require a "proxied" DNS record, highest priority rule at the top

# SSL/TLS
## SSL Modes
https://developers.cloudflare.com/ssl/origin-configuration/ssl-modes/  

    Flexible: visitor - Edge cert - cf
    Full: cf - self signed certificate - server
    Full (strict): cf - trusted CA  - server

## Edge Certificates
[Automatic HTTPS Rewrites](https://support.cloudflare.com/hc/en-us/articles/227227647) safely eliminates **mixed content** issues by rewriting insecure URLs dynamically from known secure hosts to their secure counterpart.

[Page Rules - Always Use HTTPS](https://support.cloudflare.com/hc/en-us/articles/218411427#https)

[Page Rules - Forwarding URL](https://support.cloudflare.com/hc/en-us/articles/200170536)

## Origin CA
15-years wildcard | visitor - Edge cert - cf - Origin CA - server： https://blog.cloudflare.com/cloudflare-ca-encryption-origin/  

    PEM: Apache httpd and NGINX
    PKCS#7: Microsoft’s IIS or Apache Tomcat

# CNAME Flattening
- CNAME records normally can not be on the zone apex. We use CNAME flattening to make it possible.
- DNS/Settings

https://developers.cloudflare.com/dns/additional-options/cname-flattening/
- speeds up CNAME resolution
- CNAME flattening occurs by default

# Workers
Free Limits: https://developers.cloudflare.com/workers/platform/limits

## Wrangler (Workers CLI)
https://developers.cloudflare.com/workers/get-started/guide/

    npm install -g wrangler # nodejs v16.13.0+
    wrangler login  # install volta/nvm if error
    wrangler whoami # view permissions
    wrangler init <YOUR_WORKER> && cd <YOUR_WORKER>

`wrangler generate [name] [template]`: https://github.com/cloudflare/templates

    npm start # [l] turn on/off local mode
    npm test
    npm run deploy || wrangler publish # 1st time: wait 1min

Workers > Overview # re-login web if no menu
- Online dev: worker page > click `Quick edit`

`wrangler dev`: https://developers.cloudflare.com/workers/learning/debugging-workers/

`wrangler tail --format=pretty`: https://developers.cloudflare.com/workers/learning/logging-workers/

# Workers as Reverse Proxy
## Bulk origin override
https://developers.cloudflare.com/workers/examples/bulk-origin-proxy

## Reflare
https://github.com/xiaoyang-sde/reflare

    npm init cloudflare reflare-app https://github.com/xiaoyang-sde/reflare-template

# Storage
https://developers.cloudflare.com/workers/platform/storage-objects/

## R2 - S3 object
https://developers.cloudflare.com/r2/platform/pricing/

|Product|Free|Paid - Rates|
|---|---|---|
|Storage|10 GB / month|$0.015 / GB-month|
|Class A Operations|1 million requests / month|$4.50 / million requests|
|Class B Operations|10 million requests / month|$0.36 / million requests|

## KV - key-value
https://developers.cloudflare.com/workers/reference/storage/namespaces/

1 GB free: https://developers.cloudflare.com/workers/platform/pricing/#workers-kv

Value size 25MB / 100,000 reads per day: https://developers.cloudflare.com/workers/platform/limits#kv-limits

## D1 - RDB
https://developers.cloudflare.com/d1/platform/pricing/
- only be charged for base storage plus any database operations performed

## Durable Objects - Workers Paid plan
https://developers.cloudflare.com/workers/learning/using-durable-objects/

## Queues - Workers Paid plan
job queueing, batching and inter-Service (Worker to Worker) communication.

# Paid
|Product|Fee|Desc|
|---|---|---|
[Workers Paid plan](https://developers.cloudflare.com/workers/platform/pricing/) | $5 / month | separate from any other Cloudflare plan (Free, Professional, Business)
Images | $5 / month | Store, resize, optimize and serve images at scale
Stream | $5 / month | Live and on-demand video streaming in minutes
