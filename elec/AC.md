<!-- TOC -->

- [Power Connectors](#power-connectors)
  - [Industrial](#industrial)
- [Residual Current Device](#residual-current-device)
- [UPS](#ups)

<!-- /TOC -->

常见电气元件: http://www.sohu.com/a/216349064_488169  
导线趋肤效应和临近效应：http://www.sohu.com/a/221088726_488169  

ABB低压产品目录： https://library.e.abb.com/public/3ed9d6e55176101f48257d46000d1d62/1SXF000032X2001_022011_OEM.pdf

DLT645抄表：https://github.com/fzinfz/flask-DLT645

https://en.wikipedia.org/wiki/Mains_electricity_by_country#Table_of_mains_voltages,_frequencies,_and_plugs
![](https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/World_Map_of_Mains_Voltages_and_Frequencies%2C_Detailed.svg/1200px-World_Map_of_Mains_Voltages_and_Frequencies%2C_Detailed.svg.png)
- CN 220/380V 50Hz | UK 230V 50Hz | US 120/240V 60Hz

# Power Connectors
https://en.wikipedia.org/wiki/IEC_60320#Appliance_couplers  
C13/C14 and C15/C16 connectors for up to 15 A[10] (IEC maximum is 10 A)  
C15/C16's temperature rating is 120 °C rather than the 70 °C of the similar C13/C14 combination.  
C19/C20 and C21/C22 connectors for up to 20 A[11] (IEC maximum is 16 A)

https://en.wikipedia.org/wiki/NEMA_connector
![](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/NEMA_simplified_pins.svg/525px-NEMA_simplified_pins.svg.png)

## Industrial
https://en.wikipedia.org/wiki/Industrial_and_multiphase_power_plugs_and_sockets


# Residual Current Device
https://www.theiet.org/forums/forum/messageview.cfm?catid=205&threadid=9258

    RCD - Residual Current Device 
    RCCB - Residual Current Circuit Breaker 
    RCBO - Residual Current circuit Breakers integral Over current protection 
    ELCB - Earth Leakage Circuit Breaker 

RCD is the term that covers a family of devices.

RCCBs are RCDs without any overload protection.

RCBOs are RCDs with overcurrent protection included in the device.

CBRS are circuit breakers with residual current protection which may or may not be integral.

SRCDS are socket outlets with RCD protection.

PRCDS are RCDS built in to a plug.

MRCDS are independantly mounted devices that provide a signal to trip another device.

SRCBOS are sockets incorporating an RCD and overcurrent protection.

RCDs without overcurrent protection must be protected by a separate overcurrent device.

# UPS
- Online/double-conversion: the batteries are always connected to the inverter
- Offline/standby: https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Standby_UPS_Diagram_SVG.svg/525px-Standby_UPS_Diagram_SVG.svg.png  
- Line-interactive:  adjust if over/under normal voltage | 
https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Line-Interactive_UPS_Diagram_SVG.svg/750px-Line-Interactive_UPS_Diagram_SVG.svg.png

Compare: EEVBlog https://youtu.be/Fj7e3WGUKO8?t=521  

