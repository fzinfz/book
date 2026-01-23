<!-- TOC -->

- [Quick Charge](#quick-charge)
- [Types](#types)
    - [Solar](#solar)
    - [Pb](#pb)
        - [充电](#充电)
        - [Repair](#repair)
            - [第一步：均衡充电 (Equalization)](#第一步均衡充电-equalization)
            - [第二步：调整电解液浓度（“调酸”）](#第二步调整电解液浓度调酸)
            - [第三步：补水（针对比重过高）](#第三步补水针对比重过高)
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

| byGrok            | 吸收/恒压阶段 (Bulk→Absorption) |     浮充阶段 (Float) |   均衡充电 (Equalization) | 备注                        |
|-------------------|----------------------------------|-------------------|--------------------------|-----------------------------|
| 富液式 (Flooded)     | 14.4–14.8V                      | 13.5–13.8V       | 15.0–15.6V              | 最常见，可加水              |
| EFB (增强富液)       | 14.4–14.8V                      | 13.6–13.8V       | 很少用                  | 启停车用，耐循环            |
| SLD (密封富液，类似普通密封) | 14.4–14.8V               | 13.6–13.8V       | 很少用                  | 部分称呼普通密封铅酸        |
| AGM (密封阀控)       | 14.4–14.7V (部分14.7–14.8V)     | 13.6–13.8V       | 14.6–15.0V (很少)       | 免维护，抗震                |
| 胶体 (Gel)           | 14.1–14.4V                     | 13.5–13.8V       | 一般不建议              | 耐深放，过充敏感            |

### 充电
| byGemini @25°C | 吸收电压 (Absorption) | 浮充电压 (Float) | 最大充电电流 (Max Current) | 备注 |
| --- | --- | --- | --- | --- |
| **FLOODED (富液)** | 14.4V - 14.8V | 13.2V - 13.5V | 0.1C - 0.2C | 需定期补水，耐过充性较好 |
| **AGM (贫液)**     | 14.4V - 14.7V | 13.5V - 13.8V | 0.2C - 0.3C | 充电速度快，内阻低，对高电压敏感 |
| **EFB (增强富液)** | 14.4V - 14.6V | 13.5V - 13.8V | 0.2C - 0.25C | 启动停止系统常用，循环寿命优于普通富液 |
| **SLD (密封免维护)** | 14.4V - 14.6V | 13.5V - 13.8V | 0.1C - 0.25C | 介于普通富液和AGM之间的密封设计 |
| **GEL (胶体)**     | 14.1V - 14.4V | 13.5V - 13.8V | 0.1C - 0.2C | **严禁高压**，否则易产生气泡导致电解质失水 |

1. 恒流阶段 (Bulk / Constant Current)

* **电流：** 此时充电器输出其能提供的**最大电流**（通常建议在  到  之间，例如 100Ah 电池使用 10A-20A 电流）。
* **目标：** 将电池电量快速补充到约 80%。
* **注意：** AGM 电池由于内阻极低，可以承受比 GEL 更大的初始电流而不至于过热。

2. 恒压阶段 (Absorption / Constant Voltage)

* **电压：** 保持在上述表格中的“吸收电压”。
* **电流：** 随着电池电量增加，其内阻增大，**电流会逐渐下降**。
* **结束条件：** 当电流下降到电池容量的 1% - 3%（例如 100Ah 电池电流降至 1A-3A）时，充电器应转入浮充阶段。

3. 浮充阶段 (Float)

* **电压：** 维持在较低的“浮充电压”，抵消电池的自放电。
* **电流：** **极小**，通常仅维持在数百毫安（mA）级别。
* **意义：** 此阶段可以无限期维持，以确保电池随时处于满电状态，同时防止电解液析气（水分解）。

### Repair
| byBing | 是否可用于铅酸电池 | 原因 |
|---------|----------------------|------|
| **蒸馏水（Distilled Water）** | ✔️ 推荐 | 纯度高、无离子、无矿物质，不会损伤极板 |
| **去离子水（Deionized Water）** | ✔️ 可用（质量好的） | 去除了大部分离子，纯度接近蒸馏水 |
| **超纯水（Ultrapure Water）** | ✔️ 最佳 | 实验室级别，电阻率高，非常纯净 |
| **纯净水（Purified Water）** | ⚠️ 勉强可用（不推荐） | 仍含少量矿物质，长期可能导致自放电 |

byGemini:

通过比重（Specific Gravity）来修复铅酸电池，本质上是针对**电解液分层**和**轻度硫化**的一种化学诊断与干预手段。

| 比重读数 (25°C) | 电池状态 | 建议操作 |
| --- | --- | --- |
| **1.265 - 1.285** | 满电且健康 | 无需干预 |
| **1.200 - 1.240** | 电量不足或轻度硫化 | 尝试均衡充电 |
| **低于 1.100** | 严重深度放电 | 尝试脱硫充电 |
| **单格间差异 > 0.05** | 某个单格失效 | 可能存在内部短路或损坏 |

基于比重的修复步骤

#### 第一步：均衡充电 (Equalization)

在尝试调整电解液之前，**必须先进行均衡充电**。

* **原理：** 很多时候比重低是因为硫酸根被“锁”在极板上（硫化）。通过高电压（15.5V - 16V）小电流充电，强行将硫酸根赶回电解液中。
* **现象：** 电解液会产生大量气泡（电解水），这能起到搅拌作用，消除电解液分层。
* **结果：** 充电结束后静置几小时再次测量。如果比重回升到 1.26 以上，说明修复成功。

#### 第二步：调整电解液浓度（“调酸”）

如果经过多次均衡充电，比重依然偏低且不再上升，说明部分酸液已损耗或被永久锁定。

1. **吸出部分旧液：** 使用吸管从比重低的单格中吸出约 1/4 的液体。
2. **补充高比重酸液：** 加入比重为 1.300 的储备电解液。
3. **混合：** 继续充电 1-2 小时，利用气泡促进混合。
4. **循环测试：** 测量比重，重复上述步骤直到各单格比重均匀。

#### 第三步：补水（针对比重过高）

如果比重**超过 1.300**，说明电解液中水分蒸发过多。

---

核心注意事项

* **温补修正：** 温度每升高 1°C，读数需加 0.0007；每降低 1°C，减 0.0007。
* **酸碱中和：** 操作时备好苏打水（碳酸氢钠溶液）。若强酸溅到皮肤，冲洗并中和。

- 如果单格比重完全不随充电改变，或者液体浑浊（极板活性物质脱落），说明电池物理寿命已尽，修复无效。
- 如果比重调整后容量提升不明显，可以配合使用**脉冲修复仪**，利用高频脉冲震碎极板上的坚硬硫酸铅结晶。

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
