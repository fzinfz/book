<!-- TOC -->

- [pip](#pip)
    - [Proxy](#proxy)
    - [Installing from local](#installing-from-local)
- [VSCode](#vscode)
    - [Remote debugging](#remote-debugging)
- [Pythonista on IOS](#pythonista-on-ios)

<!-- /TOC -->

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
https://code.visualstudio.com/docs/python/debugging#_remote-debugging

    pip install ptvsd

# Pythonista on IOS
https://github.com/Pythonista-Tools/Pythonista-Tools/blob/master/Utilities.md