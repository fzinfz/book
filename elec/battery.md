<!-- TOC -->

- [Quick Charge](#quick-charge)
- [Types](#types)
    - [Solar](#solar)
    - [Pb](#pb)
    - [Ni](#ni)
    - [Li](#li)
- [DC UPS](#dc-ups)

<!-- /TOC -->

# Quick Charge
- USB Promoters Group : https://en.wikipedia.org/wiki/USB_hardware#USB_Power_Delivery
- Qualcomm ： https://en.wikipedia.org/wiki/Quick_Charge

tech | year | max power
-- | -- | --
QC3 | 2016 | 36 W (12 V × 3 A)
QC4 | 2017 | 100 W (20 V × 5 A)
QC3+ | 2020 | 20mV steps from QC4
PD2.0 / USB 3.1 | 2014 | 100W ( 20V x 5A )
PD3.0 | 2015/2017 | 100W
PD3.1 | 2021 https://www.usb.org/usb-charger-pd | 240W ( 48V x 5A )

# Types
https://zh.wikipedia.org/wiki/%E8%93%84%E9%9B%BB%E6%B1%A0#%E8%93%84%E9%9B%BB%E6%B1%A0%E7%A8%AE%E9%A1%9E%E5%88%97%E8%A1%A8

## Solar
open-circuit 0.5 to 0.6 volts: https://en.wikipedia.org/wiki/Solar_cell

## Pb
https://en.wikipedia.org/wiki/Lead%E2%80%93acid_battery
- 1.8V loaded at full discharge, to 
- 2.1V in an open circuit at full charge

https://www.blazartheory.com/files/notes/phy2049/Lead_Acid_Batteries.pdf
- lead (Pb 铅) terminal
- lead(IV) oxide (PbO2) terminal
- sulfuric(硫酸) acid(酸) (H2 SO4) bath

## Ni
https://en.wikipedia.org/wiki/Nickel%E2%80%93metal_hydride_battery
- starting voltage 1.4V
- NiMH(镍氢) batteries have replaced NiCd(镍镉)

## Li
https://en.wikipedia.org/wiki/Comparison_of_commercial_battery_types

Name | Discharge | V
-- | -- | --
ICR LiCoO2 钴酸锂 | 1-2C | 2.5 / 3.7 / 4.2
INR 三元锂 | 5-7C | 2.5 / 3.6 / 4.2
IMR LiMn2O4 锰酸锂 | 10-15C | 2.5 / 3.9 / 4.2
IFR LiFePO4 磷酸铁锂 | 25-35C | 2 / 3.2 / 3.65

# DC UPS
Type | Vendor | Power | Link
-- | -- | -- | --
Pb/Li | MeanWell | 120W~600W | https://www.meanwell.com/newsInfo.aspx?c=1&i=1106
Li/Pb | sw open | 60W+ | https://github.com/mini-box/ups
Li 2S LED | hw open | 60W | https://github.com/TobleMiner/DC-UPS
