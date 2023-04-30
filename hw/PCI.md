<!-- TOC -->

- [PCIe](#pcie)
    - [Check](#check)
- [Thunderbolt](#thunderbolt)
    - [Chip](#chip)
- [DisplayPort](#displayport)

<!-- /TOC -->

# PCIe
https://en.wikipedia.org/wiki/PCI_Express#History_and_revisions

Per lane:
- Version 1.0a: 2.5 GT/s is 2.5 Gbps on the encoded serial link. This corresponds to 2.0 Gbps of pre-coded data or 250 MB/s
- Version 2.x : 5 GT/s = 500 MB/s
- Version 3.x : 8  GT/s ~= 1 GB/s | upgraded the encoding scheme to 128b/130b from the previous 8b/10b encoding
- Version 4.0 : 16 GT/s ~= 2 GB/s

split: BIOS - PCIe Bifurcation

## Check
- Powershell: https://superuser.com/questions/1732084/is-there-a-way-to-identify-the-pcie-speed-for-a-device-using-powershell-win10
- devmgmt.msc : Properties - Details

# Thunderbolt
https://en.wikipedia.org/wiki/Thunderbolt_(interface)

- Superseded: IEEE 1394 (FireWire) / ExpressCard
- Connector: v1/v2 - Mini-DP ; v3/v4 - USB-C
- v3/v4: 40 Gbit/s (5 GB/s) bidirectional
    - Thunderbolt 3: 4× PCI Express 3.0, DisplayPort 1.2, USB 3.1 Gen 2
    - Thunderbolt 4: 4× PCI Express 3.0, DisplayPort 2.0, USB4	
- USB4 compatible with Thunderbolt 3, and backwards compatible with USB 3.2 and USB 2.0

## Chip
- Intel 6000 Series: https://www.thunderbolttechnology.net/sites/default/files/18-241_ThunderboltController_Brief_HI.pdf
    - JHL6340: 4 lanes
        - Peripherial Confiuration: 1

- Intel 7000 Series: https://www.thunderbolttechnology.net/sites/default/files/18-241_Thunder7000Controller_Brief_FIN_HI.pdf
    - JHL7440: 2 Ports, Downstream x4 lanes
        - Peripherial Confiuration: 2 Tunneled, 1 dedicated DP output

# DisplayPort
- 4 lanes: https://en.wikipedia.org/wiki/DisplayPort#Specifications
    - Thunderbolt 3 interface which implements up to 8 lanes of DisplayPort
