<!-- TOC -->

- [API](#api)
    - [Query](#query)
- [Python](#python)

<!-- /TOC -->

# API
## Query
https://grafana.com/docs/loki/latest/api/#examples

    curl -G -s  "http://localhost:3100/loki/api/v1/query" \
        --data-urlencode 'query=sum(rate({job="varlogs"}[10m])) by (level)' \
        | jq

# Python
https://pypi.org/project/python-logging-loki/        