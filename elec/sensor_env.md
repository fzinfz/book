- [TI/LM\*](#tilm)
- [ADI](#adi)
    - [DS18B20](#ds18b20)
- [aosong/ASAIR](#aosongasair)
    - [AHT25 vs DHT20 Sensor Comparison](#aht25-vs-dht20-sensor-comparison)
    - [AHT](#aht)


# TI/LM*
- chart compare: https://www.ti.com/product-category/sensors/temperature/analog/overview.html
- table filter: https://www.ti.com/product-category/sensors/temperature/analog/products.html

# ADI
- Analog  | https://www.analog.com/en/parametricsearch/2772#/
- Digital | https://www.analog.com/en/parametricsearch/2750#/

## DS18B20
https://www.analog.com/media/en/technical-documentation/data-sheets/ds18b20.pdf

| by Grok                 | DS18B20 (Temperature Only)                 | DHT20 (Temperature + Humidity)              |
|----------------- -------|--------------------------------------------|---------------------------------------------|
| **Interface**           | 1-Wire (multi-sensor support)              | I²C (single address)                       |
| **Temperature Range**   | -55°C to +125°C                            | -40°C to +85°C                             |
| **Temperature Accuracy**| ±0.5°C (from -10°C to +85°C)               | ±0.3°C (at 25°C)                           |

**Notes**: DS18B20 excels in precision temp monitoring (e.g., liquids)

# aosong/ASAIR
https://www.aosong.com/Products/list.aspx?lcid=1

## AHT25 vs DHT20 Sensor Comparison
DHT22 = AM2302 | 3.3-6V

## AHT

| by bing                    | AHT10                          | AHT20(Gen 2)                   | AHT21                          |
|----------------------------|--------------------------------|--------------------------------|--------------------------------|
| **Temperature Range**      | -40°C to +85°C                 | -40°C to +85°C                 |-40°C to +120°C                 |
| **Temperature Accuracy**   | ±0.3°C typical                 | ±0.3°C typical                 | ±0.3°C typical                 |
| **Humidity Accuracy**      | ±2% RH typical                 | ±2% RH typical                 | ±2% RH typical                 |
| **Voltage Range**          | 1.8V – 3.6V                    | 2.0V – 5.5V                    | 2.0V – 5.5V                    |
| **Current Consumption**    | ~400 µA                        | ~980 µA (typical)              | ~980 µA (typical)              |
