---
layout: post
title: 用Arduino Leonardo开发板做一个Badusb虚拟键盘(平替rubber ducky橡皮鸭)仅供安全演示
categories: Hack
description: Arduino Leonardo的玩法记录
keywords: Arduino Leonardo, Badusb
---
记录用Arduino Leonardo开展HID attack的安全演示

## 什么是Bad USB

BadUSB是一种使用带有软件编程的USB设备硬件，可以模拟键盘输入，对目标计算机进行指定的操作如打开cmd或powershell输入指令。如有想象力可有更多操作。


## 什么是Arduino Leonardo开发板

Arduino Leonardo是Arduino的一种，与其它板子不同的是其可进行USB通信，所以可以用来模拟键盘和鼠标，价格约30元RMB。

## 什么是Rubber Ducky橡皮鸭

Rubber Ducky橡皮鸭是HAK5社区出售的一种badusb设备，价格79.99美元,考虑到性价比，因此用Arduino Leonardo作为平替。

## 安装Arduino IDE

下载：https://www.arduino.cc/en/software

## 环境准备

插入 Arduino Leonardo 在电脑。

在菜单栏->工具->开发板->Arduino AVR Boards->Arduino Leonardo选中。

在菜单栏->工具->端口->Arduino Leonardo所在的端口如COM3，选中。

## 了解基础语句

在Arduino IDE中，添加键盘相关头文件。 (去掉''单引号)

```
'#include <Keyboard.h>'  
```

开始键盘通讯

```
Keyboard.begin();
```

结束键盘通讯

```
Keyboard.end();
```

按下某按键

```
Keyboard.press();
```

松开某按键

```
Keyboard.release();
```

延迟一段时间，单位毫秒

```
delay(5000);
```

## 编写程序

以下程序示例为：win+r打开运行，开启cmd窗口，ping百度的域名，结束程序（为了稳定运行我在每个语句中加入暂停500毫秒的操作）。

```
#include <Keyboard.h>
void setup() {
  // put your setup code here, to run once:
  Keyboard.begin();
  delay(5000);
  Keyboard.press(KEY_LEFT_GUI);
  delay(500);
  Keyboard.press('r');
  delay(500);
  Keyboard.release('r');
  delay(500);
  Keyboard.release(KEY_LEFT_GUI);
  delay(500);
  Keyboard.press(KEY_CAPS_LOCK);
  delay(500);
  Keyboard.release(KEY_CAPS_LOCK);
  delay(500);
  Keyboard.println("CMD");
  delay(500);
  Keyboard.press(KEY_RETURN);
  delay(500);
  Keyboard.release(KEY_RETURN);
  delay(500);
  Keyboard.println("PING BAIDU.COM");
  delay(500);
  Keyboard.press(KEY_RETURN);
  delay(500);
  Keyboard.release(KEY_RETURN);
  delay(500);
  Keyboard.end();
}

void loop() {
  // put your main code here, to run repeatedly:

}

```

## 验证与上传

![images](\images\posts\2023-8-30-arduino-leonardo-badusb\arduino.PNG)

如图点击左上角验证，程序没有语法错误后上传到开发板。模拟键盘操作会在上传完成后开始。

为了保险起见我在程序开始时设置了五秒延迟，以防操作出bug导致无法再次刷入代码（之前键盘卡死在奇怪的地方导致鼠标没法使用，开发板差点变砖）。

再次拔出USB插入电脑以验证Bad USB正常工作。

可以看到Arduino Leonardo插入后打开了cmd窗口并进行一个ping百度域名的操作，实战中一般用来打开powershell从远端主机下载一个reverse-shell控制目标主机，但powershell一般会被Av拦截，因此Bad USB还是有一定局限性。

本文仅供安全演示。

