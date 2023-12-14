---
layout: post
title: Kail-Nethunter安装在Nexus6p上的记录
categories: Hack
description: Kail-Nethunter折腾记录
keywords: Kail, Nethunter
---
让手机变成移动的kali-linux

## 什么是Kail-Nethunter

Kail-Nethunter即安装在手机上的Kalilinux系统，适合用来移动渗透测试。用来使用无线审计测试。

## 硬件准备

1.kali官网支持列表中的nexus 6p手机一部，购买自咸鱼，约150元。

![images](\images\posts\2023-8-16-nethunter\phone.PNG)

2.OTG转接头一个，购买自抖音，0.01元子。

3.kali官网列出的无线网卡，Rtl8188eus，体积极小，无线鼠标接收器大小，20元。

![images](\images\posts\2023-8-16-nethunter\otg.PNG)

4.电脑一台（win10和ubuntu双系统）。

备注：实际测试，Rtl8188eus操作与普通网卡不一样，经了解后建议购买用于nethunter无线审计的网卡为：AR9271（单频2.4g），RTL8812au(双频)。缺点：体积略大。

## 软件准备

1.Nethunter for nexus 6p oreo (angler)，下载 https://kali.download/nethunter-images/kali-2022.4/nethunter-2022.4-angler-oreo-kalifs-full.zip

2.谷歌工厂镜像:https://developers.google.com/android/images?hl=zh-cn#angler

3.twrp,下载：https://dl.twrp.me/angler/

4.magisk,下载：https://github.com/topjohnwu/Magisk/releases

5.安卓调试桥。下载：https://developer.android.com/studio/releases/platform-tools?hl=zh-cn

6.其他：fastboot驱动等。

## 刷入原生系统

1.手机打开开发者模式，adb调试

2.进入fastboot模式

```
adb reboot bootloader
```

3.解压angler-opm7.181205.001后运行flash-all.bat脚本开始刷机

4.成功刷入android8.1

## 刷入twrp

1.手机打开开发者模式，adb调试

2.进入fastboot模式

```
adb reboot bootloader
```

3.刷入recovery

```
fastboot flash recovery twrp-3.7.0_9-0-angler.img
```

4.重启

```
fastboot reboot
```

5.输入可进入twrp

```
adb reboot recovery
```

## 刷入面具magisk（获取root权限）

1.解压工厂镜像中的image-angler-opm7.181205.001获取boot.img

2.将boot.img复制到手机存储任意路径

3.使用magisk修补boot.img，修补后的镜像与boot.img出现在同一路径下

4.进入fastboot模式

```
adb reboot bootloader
```

5.刷入boot镜像

```
fastboot flash boot magisk_patched-26100_ezDBt.img
```

6.重启

```
fastboot reboot
```

7.root权限获取成功

## 刷入Kali-Nethunter

1.复制nethunter-2022.4-angler-oreo-kalifs-full.zip到手机存储任意路径

2.打开magisk,模块，从本地安装，选择nethunter-2022.4-angler-oreo-kalifs-full.zip安装，重启

3.打开nethunter APP,start kali chroot

4.nethunter安装完成。

## 构建Kali Nethunter 内核

注意：需要linux环境，由于网络原因，我使用的是机房VPS搭载ubuntu。

1.

```
git clone https://gitlab.com/kalilinux/nethunter/build-scripts/kali-nethunter-project
```

2.

```
cd kali-nethunter-project/nethunter-installer
```

3.

```
./bootstrap.sh
```

4.

```
python3 build.py -h
```

5.

```
python3 build.py –d angler -o -k
```

## 刷入Kali Nethunter 内核

1.将构建好的内核复制到手机存储
  
2.进入twrp

```
adb reboot recovery
```

3.选择install,选择内核文件，刷入内核（默认勾选跳过签名验证，不要选刷入后重启）

4.wipe dalvik后reboot system

6.内核安装完成

## 后续步骤

在kali的shell里更新软件：

```
apt update && apt upgrade -y
```

或

```
apt update && apt full-upgrade -y
```

在nethunter->kali chroot manager->start kail chroot  
重启手机，插入OTG和USB网卡，打开nethunter终端输入

```
ifconfig -a
```

或

```
airmin-ng
```

即可查看OTG上的网卡设备，如wlan1

此时你拥有一个移动的kali linux设备，同时支持外接USB设备

Happy Hunting!

End.
