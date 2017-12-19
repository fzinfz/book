<!-- TOC -->

- [Distribution Default](#distribution-default)
- [pip](#pip)
    - [Proxy](#proxy)
    - [Installing from local](#installing-from-local)
- [VSCode](#vscode)
    - [Remote debugging](#remote-debugging)
- [Pythonista on IOS](#pythonista-on-ios)

<!-- /TOC -->

# Distribution Default
Debian/Ubuntu
    wheey   2.7.3   /   3.2
    jessie  2.7.9   /   3.4
    stretch  2.7.13 /   3.5
    buster  2.7.14  /   3.6

# pip
## Proxy
    export all_proxy="socks5://x:y" # cause python error: Missing dependencies for SOCKS support.
    pip install --proxy=https://user@mydomain:port  somepackage

## Installing from local
    pip install --download DIR -r requirements.txt
    pip wheel --wheel-dir DIR -r requirements.txt
    pip install --no-index --find-links=DIR -r requirements.txt

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