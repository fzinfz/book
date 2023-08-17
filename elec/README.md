<!-- TOC -->

- [Package](#package)
- [Symbol](#symbol)
- [MOSFET](#mosfet)
- [Buck & Boost](#buck--boost)
    - [Buck/step-down regulators](#buckstep-down-regulators)
        - [Synchronous Rectification](#synchronous-rectification)
    - [Boost/step-up regulators](#booststep-up-regulators)
    - [forward vs flybac](#forward-vs-flybac)
- [示波器](#%E7%A4%BA%E6%B3%A2%E5%99%A8)
- [Simulation Program](#simulation-program)

<!-- /TOC -->

# Package
https://en.wikipedia.org/wiki/List_of_integrated_circuit_packaging_types#Transistor,_diode,_small-pin-count_IC_packages

# Symbol
https://en.wikipedia.org/wiki/Electronic_symbol

# MOSFET
MOS管控制电源通断以及缓启动：https://www.bilibili.com/video/BV1fU4y1J7xi  

# Buck & Boost
by Eugene Khutoryansky: https://www.youtube.com/watch?v=vwJYIorz_Aw

More: [boost.md](boost.md) | [bulk.md](bulk.md)

## Buck/step-down regulators
https://learnabout-electronics.org/PSU/psu31.php 

15: https://www.bilibili.com/video/BV1nA411t7U4 

BUCK电源电感怎么选择： https://www.bilibili.com/video/BV1ig411P7dc?t=112.2   

### Synchronous Rectification
同/异步整流：https://www.bilibili.com/video/BV1Jv411P7Qc?t=369.7  
https://www.analog.com/en/analog-dialogue/raqs/raq-issue-147.html

## Boost/step-up regulators
https://learnabout-electronics.org/PSU/psu31.php

## forward vs flybac
https://www.eet-china.com/mp/a12732.html  
反激的变压器可以看作一个带变压功能的电感，是一个buck-boost电路。反激是初级工作，次级不工作，一般DCM模式。   
正激的变压器是只有变压功能，整体可以看成一个带变压器的buck电路。正激是初级工作次级也工作，次级不工作有续流电感续流，一般是CCM模式。  

反激式同步整流控制技术：https://www.bilibili.com/video/BV1bJ411W7Hi  

# 示波器
测量市电 - AB伪差分：[Siglent](https://youtu.be/kIir80Jnlyo?t=296) | [Tek](https://www.bilibili.com/video/BV1JU4y1K7cy?t=421.1)  
纹波：[Tek](https://www.bilibili.com/read/cv14145415) | [Rigol](https://www.bilibili.com/video/BV1my4y167ao?t=77.1)  
Micsig/汽修： https://space.bilibili.com/476743057/channel/seriesdetail?sid=862170  

# Simulation Program
Free: https://en.wikipedia.org/wiki/List_of_free_electronics_circuit_simulators  
Micro-cap | Original $4495, now free: http://www.spectrum-soft.com/download/download.shtm   

Non-free: Multisim/Matlab