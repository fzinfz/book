<!-- TOC -->

- [Windows](#windows)
- [QT](#qt)
    - [proxy](#proxy)
- [Apps](#apps)
    - [Browser](#browser)
        - [qutebrowser](#qutebrowser)
        - [admbrowser](#admbrowser)

<!-- /TOC -->

# Windows

https://pypi.org/project/auto-py-to-exe/

    pip install --upgrade PyQt5
    pip install auto-py-to-exe
    auto-py-to-exe        # GUI
    auto-py-to-exe --help # cli
    Win+R -> shell:startup

# QT

    pip install --upgrade PyQt5
    # or
    pip install --upgrade PySide6 # Qt 6.0+

## proxy
https://www.google.com/search?q=python+QNetworkProxy+code+sample

    # 1. Create a QNetworkProxy instance
    proxy = QNetworkProxy()

    # 2. Set the proxy type (e.g., Socks5Proxy, HttpProxy)
    proxy.setType(QNetworkProxy.Socks5Proxy)

    # 3. Set the proxy host and port
    proxy.setHostName("localhost")  # Replace with your proxy server address
    proxy.setPort(9050)             # Replace with your proxy server port

# Apps
## Browser
### qutebrowser
Install: https://github.com/qutebrowser/qutebrowser/blob/master/doc/install.asciidoc#manual-install  
Windows + tox + conda: https://stackoverflow.com/questions/30555943/is-it-possible-to-use-tox-with-conda-based-python-installations  

Proxy Types: https://github.com/qutebrowser/qutebrowser/blob/86fca3e99ee4836f5f591831eb93a09ffb8231d2/qutebrowser/utils/urlutils.py#L599

### admbrowser
https://github.com/alandmoore/admbrowser

    HTTPS, FTP, SOCKS, or authenticated proxy is not currently supported






