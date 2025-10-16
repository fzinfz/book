<!-- TOC -->

- [Run](#run)
- [Docker Images](#docker-images)
  - [Community Stacks](#community-stacks)
    - [selenium](#selenium)

<!-- /TOC -->

Test: https://github.com/fzinfz/ipynb/blob/main/python/jupyter.ipynb

uv: https://docs.astral.sh/uv/guides/integration/jupyter/

# Run

    # win create shortcut
    d:\_soft\Anaconda3\python.exe d:\_soft\Anaconda3\cwp.py d:\_soft\Anaconda3 d:\_soft\Anaconda3\python.exe d:\_soft\Anaconda3\Scripts\jupyter-notebook-script.py "d:/"

    # linux
    jupyter notebook --generate-config # ~/.jupyter | jupyter_notebook_config.py
        c.NotebookApp.notebook_dir = ''
        c.NotebookApp.ip = '*'
        c.NotebookApp.open_browser = False 
        c.NotebookApp.password = u'type:salt:hashed-password' # from notebook.auth import passwd; passwd()

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
