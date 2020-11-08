<!-- TOC -->

- [Relative imports in Python 3](#relative-imports-in-python-3)
- [Distribution Default](#distribution-default)
- [Jupyter](#jupyter)
- [pip](#pip)
    - [Installing from local](#installing-from-local)
    - [Proxy](#proxy)
- [pypi](#pypi)
- [Google Fire](#google-fire)
- [pendulum](#pendulum)
- [Web automation](#web-automation)
    - [requestium](#requestium)
- [VSCode](#vscode)
    - [Remote debugging](#remote-debugging)
- [Pythonista on IOS](#pythonista-on-ios)
- [MongoDB ORM](#mongodb-orm)
- [Web Frameworks](#web-frameworks)
    - [aiohttp](#aiohttp)
    - [Sanic](#sanic)
    - [API Server](#api-server)
- [WSDL](#wsdl)

<!-- /TOC -->

# Relative imports in Python 3
https://stackoverflow.com/a/49375740/4769874  
`from module1` intead of `from .module1`

    # __init__.py
    import os, sys
    sys.path.append(os.path.dirname(os.path.realpath(__file__)))

# Distribution Default

    Debian 7 wheezy   2.7.3   /   3.2
    Debian 8 jessie   2.7.9   /   3.4
    Debian 9 stretch  2.7.13  /   3.5
    Debian 10 buster  2.7.14  /   3.6

# Jupyter

  %reload_ext autoreload
  %autoreload 2

# pip
## Installing from local
    pip install --download DIR -r requirements.txt
    pip wheel --wheel-dir DIR -r requirements.txt
    pip install --no-index --find-links=DIR -r requirements.txt

## Proxy
    export all_proxy="socks5://x:y" # cause python error: Missing dependencies for SOCKS support.
    pip install --proxy=https://user@mydomain:port  somepackage

# pypi
https://packaging.python.org/tutorials/distributing-packages/

    twine upload --repository testpypi dist/*

# Google Fire
https://github.com/google/python-fire/blob/master/docs/guide.md#accessing-properties

```python
import fire

english = 'Hello World'
fire.Fire()

# .py english

fire.Fire(lambda obj: type(obj).__name__)

# .py 10 / "10"                 # output: int
# .py '"10"' / "'10'" / \"10\"  # output: str

# .py '{"name": "David Bieber"}' # notice the quote, output: dict
# .py {"name":"David Bieber"}    # Wrong. output: str

# .py --obj=True / --obj
# .py --obj=False / --noobj

def hello(name):
  return 'Hello {name}!'.format(name=name)

if __name__ == '__main__':
  fire.Fire()

# .py hello name_value

class Calculator(object):

  def add(self, x, y):
    return x + y

if __name__ == '__main__':
  fire.Fire(Calculator)

# .py add 10 20

class BrokenCalculator(object):

  def __init__(self, offset=1):
      self._offset = offset

  def add(self, x, y):
    return x + y + self._offset

if __name__ == '__main__':
  fire.Fire(BrokenCalculator)

# .py add 10 20 --offset=0

class Airport(object):

  def __init__(self, code):
    self.code = code
    self.name = fn_x(self.code)

if __name__ == '__main__':
  fire.Fire(Airport)

# .py --code=SJC name

```

# pendulum
https://github.com/sdispater/pendulum#pendulum

    tomorrow = pendulum.now().add(days=1)
    last_week = pendulum.now().subtract(weeks=1)

    if pendulum.now().is_weekend():
    past.diff_for_humans()

# Web automation
## requestium
https://github.com/tryolabs/requestium  
merges the power of Requests, Selenium, and Parsel into a single integrated tool

# VSCode
## Remote debugging
VS: https://youtu.be/y1Qq7BrV6Cc?t=228  
VSCode: https://code.visualstudio.com/docs/python/debugging#_remote-debugging  

    # bug: https://github.com/DonJayamanne/pythonVSCode/issues/981#issuecomment-308085243
    pip install ptvsd==3.0.0    

```python
import ptvsd
ptvsd.enable_attach("my_secret", address = ('0.0.0.0', 3000))

ptvsd.wait_for_attach()
```

# Pythonista on IOS
https://github.com/Pythonista-Tools/Pythonista-Tools/blob/master/Utilities.md

# MongoDB ORM
http://ming.readthedocs.io/en/latest/

http://turbogears.readthedocs.io/en/latest/turbogears/mongodb.html

# Web Frameworks
https://github.com/topics/web-framework?l=python  
https://wiki.python.org/moin/WebFrameworks

## aiohttp
https://github.com/aio-libs/aiohttp  
https://aiohttp.readthedocs.io/en/stable/  
Supports both client and server Web-Sockets  
Web-server has middlewares and pluggable routing.

## Sanic
https://github.com/channelcat/sanic

## API Server
http://www.hug.rest/

# WSDL
http://www.soapclient.com/xml/soapresponder.wsdl  
http://download.oracle.com/otn_hosted_doc/jdeveloper/1012/web_services/ws_wsdlstructure.html