<!-- TOC -->

- [MT3608](#mt3608)

<!-- /TOC -->

[More](./README.md#buck--boost)

Chips | Input | Output | Current | Leakage Current | mΩ
-- | -- | -- | -- | -- | --
MT3608 | 2 - 24 | 28 | 2A | Shutdown = 0.1 - 1 µA | 80


# MT3608
6-pin SOT-23 | https://www.olimex.com/Products/Breadboarding/BB-PWR-3608/resources/MT3608.pdf
- 5/1/2 = In/Out/Gnd | 6 = NC
  - Out = Ref(0.6V) * ( 1 + R1 / R2 )
- 4 EN | -0.3V to 26V
- 3 FB | -0.3V to 6V

