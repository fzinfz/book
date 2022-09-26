<!-- TOC -->

- [Docker Images](#docker-images)
    - [Community Stacks](#community-stacks)
        - [selenium](#selenium)

<!-- /TOC -->

  %reload_ext autoreload
  %autoreload 2

# Docker Images
https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#image-relationships

    base + git/vi/tzdata/unzip = minimal => 
    scipy | r => pyspark/tensorflow || datascience* => all-spark

jupyter/datascience-notebook

cell diff: https://jovian-py.readthedocs.io/en/latest/user-guide/version.html#view-differences

## Community Stacks
https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#community-stacks

### selenium
https://github.com/rgriffogoes/scraper-notebook  

    docker run -p8888:8888 -d -v $PWD:/home/jovyan/work rgriffogoes/scraper-notebook