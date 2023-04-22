

# tsocks
- https://github.com/zouguangxian/tsocks
- https://linux.die.net/man/8/tsocks

- `SOCKS server ... is not on a local subnet!` => `vi /root/.tsocks.conf or /etc/tsocks.conf` - `local =`

    TSOCKS_DEBUG: -1/no debug, 2/verbose
    TSOCKS_DEBUG=2 LD_PRELOAD=libtsocks.so curl -4 ip.gs