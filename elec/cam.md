- [ESP32](#esp32)
- [Sony](#sony)
- [DJI](#dji)
    - [Drone](#drone)


# ESP32
https://github.com/espressif/esp32-camera/blob/master/README.md#supported-sensor

| model   | max resolution | color type | output format                                                | Len Size |
| ------- | -------------- | ---------- | ------------------------------------------------------------ | -------- |
| OV2640  | 1600 x 1200    | color      | YUV(422/420)/YCbCr422<br>RGB565/555<br>8-bit compressed data<br>8/10-bit Raw RGB data | 1/4"     |

# Sony

| Feature | IMX323 | IMX335 | IMX415 | IMX678 |
| :--- | :--- | :--- | :--- | :--- |
| **Technology** | Exmor (Older BSI) | STARVIS | STARVIS (Stacked) | STARVIS 2 (Stacked) |
| **Max. Resolution** | Approx. 2.1MP (1080p/Full HD) | Approx. 5.1MP (5MP/2.5K) | Approx. 8.4MP (4K/UHD) | Approx. 8.4MP (4K/UHD) |
| **Sensor Size (Diagonal)** | Type $1/2.9"$ | Type $1/2.8"$ ($6.52 \text{mm}$) | Type $1/2.8"$ ($6.43 \text{mm}$) | Type $1/1.8"$ (Larger) |
| **Pixel Size** | $\sim 2.8 \mu \text{m}$ | $2.0 \mu \text{m}$ | $1.45 \mu \text{m}$ | $2.0 \mu \text{m}$ (Often larger than IMX415) |
| **Dynamic Range (HDR)** | Basic/Limited | DOL-HDR | DOL-HDR | Enhanced/Superior (DOL HDR, Clear HDR support) |

* **IMX678** uses **STARVIS 2**, the successor to STARVIS, which offers superior low-light performance, much higher dynamic range, and better motion clarity
* The **IMX415** is competent but is often overshadowed by the IMX335 in pure low-light sensitivity due to its smaller pixel pitch

# DJI
## Drone
inch | type | 视角 | 等效焦距 | 光圈 | 对焦点 | 变焦 | Model
-- | -- | -- | -- | -- | -- | -- | --
1/0.75 | 哈苏   | 72° | 28mm  | f/2.0-11 | 2m+  | 1-2.5倍 | Mavic4P
1/1    | 广角   | 84° | 24mm  | f/1.8 | 0.5m+   | 1-2.9倍 | Mini5P/Air3S
1/1.3  | 中长焦 | 35° | 70mm  | f/2.8 | 3m+     | 3-9倍  | Air3S/Mavic4P
1/1.5  | 长焦   | 15° | 168mm | f/2.8 | 3m+     | 6-24倍 | Mavic4P