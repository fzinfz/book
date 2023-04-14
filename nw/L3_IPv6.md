- [Basic](#basic)
- [Compare with v4](#compare-with-v4)
    - [Types \& Scopes](#types--scopes)
- [NPTv6](#nptv6)
- [Tools](#tools)
    - [Linux](#linux)
- [Firewall](#firewall)

# Basic
https://en.wikipedia.org/wiki/IPv6_address#Representation

- 16 bits * 8 groups = 128 bits
- prefer lower case letters
- https://[IPv6_addr]:PORT/
- Link Local - fe80::/10.../64 : last 24 bits are MAC address
- [Layer 3](/nw/L3/#ipv6-packet)

# Compare with v4
https://www.ibm.com/docs/en/i/7.2?topic=6-comparison-ipv4-ipv6

## Types & Scopes
- unicast: link-local and global
- multicast: 14 scopes
- anycast

# NPTv6
Network Prefix Translation： https://en.wikipedia.org/wiki/IPv6-to-IPv6_Network_Prefix_Translation

# Tools
## Linux

    tcpdump -i any ip6

https://www.kali.org/tools/ipv6toolkit/

    apt install ipv6toolkit

# Firewall
ChinaNet Modem: 安全-防火墙：IPV6 SESSION