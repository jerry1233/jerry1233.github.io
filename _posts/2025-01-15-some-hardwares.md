---
layout: post
title: 跟着开源项目做的几个硬件（Blue Jammer、BW16 deauther、EvilAppleJuice）
categories: Hardware
description: 跟着开源项目做的几个硬件（Blue Jammer、BW16 deauther、EvilAppleJuice）
keywords: Hardware, BW16, Esp32
---

最近跟着开源项目做的硬件

# Blue Jammer

Blue Jammer是一款用于阻塞2.4g 信号（wifi 蓝牙等）的开源硬件

正面

![1](\images\posts\2025-01-15-some-hardwares\bulejammer1.jpg)

侧面

![1](\images\posts\2025-01-15-some-hardwares\bulejammer2.jpg)

## 项目地址

带屏，根据原项目修改，封装好bin文件的版本（使用这个）

https://github.com/W0rthlessS0ul/nRF24_jammer

Blue Jammer 原项目

https://github.com/EmenstaNougat/ESP32-BlueJammer

## 所需硬件



| 硬件                     | 数量 |
| ------------------------ | ---- |
| ESP32开发板 30PIN        | 1    |
| 4PIN 0.96寸 OLED 屏幕    | 1    |
| NRF24L01+PA+LNA 无线模块 | 2    |
| 开关及按钮               | 若干 |
| 锂电池充放电模块（可选） | 1    |
| 16V 100uf 电解电容       | 3    |

## 接线

### HSPI Connection

| NRF24L01引脚 | ESP32引脚 | 电解电容      |
| ------------ | --------- | ------------- |
| VCC          | 3.3V      | (+) capacitor |
| GND          | GND       | (-) capacitor |
| CE           | GPIO 16   |               |
| CSN          | GPIO 15   |               |
| SCK          | GPIO 14   |               |
| MOSI         | GPIO 13   |               |
| MISO         | GPIO 12   |               |
| IRQ          |           |               |

### VSPI Connection

| NRF24L01引脚 | ESP32引脚 | 电解电容      |
| ------------ | --------- | ------------- |
| VCC          | 3.3V      | (+) capacitor |
| GND          | GND       | (-) capacitor |
| CE           | GPIO 22   |               |
| CSN          | GPIO 21   |               |
| SCK          | GPIO 18   |               |
| MOSI         | GPIO 23   |               |
| MISO         | GPIO 19   |               |
| IRQ          |           |               |

### OLED Connection

| OLED 4PIN 引脚 | ESP32引脚 |
| -------------- | --------- |
| VCC            | 3.3V      |
| GND            | GND       |
| SCL            | GPIO 22   |
| SDA            | GPIO 21   |

### Button Connection

| BUTTON | ESP32引脚 |
| ------ | --------- |
| GND    | GND       |
| BUTTON | GPIO 25   |

# BW16 Deauther

BW16 Deauther 可以向2.4g 和 5g WIFI 发送解除认证帧的一款工具，与之前的ESP8266相比多了5ｇ频段支持。



正面

![1](\images\posts\2025-01-15-some-hardwares\bw161.jpg)

侧面

![1](\images\posts\2025-01-15-some-hardwares\bw162.jpg)

## 项目地址

注意，这个作者没有开源，GitHub上有相关的项目，但有很多BUG，由于我对C代码不是很精通，没有继续研究了。

https://space.bilibili.com/3493128258455752/

## 所需硬件

| 硬件                  | 数量 |
| --------------------- | ---- |
| 4PIN 0.96寸 OLED 屏幕 | 1    |
| BW16                  | 1    |
| 按钮及开关            | 若干 |
| 锂电池（可选）        | 1    |
| 锂电充放模块（可选）  | 1    |

## 接线

OLED接线

| OLED | BW16 | 功能     |
| ---- | ---- | -------- |
| VCC  | 3V3  | 3.3v正极 |
| GND  | GND  | 接地     |
| SCK  | PA25 | I2C时钟  |
| SDA  | PA26 | I2C数据  |

button 接线

| Button    | BW16 | 说明   |
| --------- | ---- | ------ |
| GND->PA14 | PA14 | UP     |
| GND->PA30 | PA30 | DOWN   |
| GND->PA12 | PA12 | SELECT |
| GND->PA7  | PA7  | BACK   |

![1](\images\posts\2025-01-15-some-hardwares\bw163.jpg)

# EvilAppleJuice

能让apple设备无限弹窗的一个硬件，直接烧录在ESP32 C3上，无需接线。

![1](\images\posts\2025-01-15-some-hardwares\evilapplejuice.jpg)

## 项目地址

https://github.com/ckcr4lyf/EvilAppleJuice-ESP32