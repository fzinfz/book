<!-- TOC -->

- [Doc](#doc)
- [Install](#install)
- [Management](#management)
    - [Policy](#policy)
- [Debug](#debug)

<!-- /TOC -->

# Doc
https://wiki.openwrt.org/doc/howto/mwan3
- A new routing table is created for each interface
- A monitoring script (mwan3track) runs in the background checking each WAN interface

# Install
- [mt7981](https://downloads.openwrt.org/snapshots/packages/aarch64_cortex-a53/packages/)

# Management
`/cgi-bin/luci/admin/network/mwan3`
- Globals
- Notify: /etc/mwan3.user(.sh)
- Rule -> Policy 
-> Member ( compare `weight` if same `metric`)
-> [Interface](https://oldwiki.archive.openwrt.org/doc/howto/mwan3#step_1configure_a_different_metric_for_each_wan_interface)

## Policy
https://openwrt.org/docs/guide-user/network/wan/multiwan/mwan3#policy_configuration

# Debug
`/cgi-bin/luci/admin/status/mwan3`: status/Diagnostics

    ip route show # Interface

