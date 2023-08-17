<!-- TOC -->

- [LM2596](#lm2596)
- [AMS1117](#ams1117)

<!-- /TOC -->

[More](./README.md#buck--boost)

Chips | Input | Output | Current | Leakage Current | mΩ
-- | -- | -- | -- | -- | --
LM2596 | 4.5 - 40 | 1.2 - 37 | 3A | < 50 µA
AMS1117 | 18 / max 30 / drop 1.3 |  1.25 to 12V | 1.4A | Standby = 2mA

# LM2596
5-Pin TO-220/263 | https://www.ti.com/lit/ds/symlink/lm2596.pdf
- 1/2/3 = In/Out/Gnd
  - Out = Ref(1.23V) * ( 1 + R2 / R1 )
- 4: FB | –0.3 to 25 V
- 5: ON = low < 1.3V | OFF = cmax 25V

# AMS1117
3-Pin SOT-223: https://datasheet.lcsc.com/szlcsc/2001081204_Shikues-AMS1117-1-2_C475600.pdf
- 3/2: In/Out
- 1: Gnd or ADJ ( Vout=1.25×(1+R2/R1)+IAdj×R2 , can ignore IAdj )