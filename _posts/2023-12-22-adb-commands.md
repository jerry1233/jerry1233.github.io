---
layout: post
title: adb基础命令教程
categories: Android
description: 记一下常用adb基础命令
keywords: adb, Android
---

记一下常用adb基础命令，以备随时查阅

## adb工具下载及基本文件

官网：https://developer.android.com/tools/releases/platform-tools?hl=zh-cn#downloads

文件构成（Windows）：

adb.exe

AdbWinApi.dll

AdbWinUsbApi.dll

三个基本文件即可使用adb

## 基础命令

查看adb工具的版本

```
adb version
```

查看Android设备连接情况

```
adb devices
```

## adb普通命令

1.安装，卸载APK，保留数据降级软件

2.传输文件。

3.重启到recovery模式

命令格式：adb +命令

## adb shell 命令

非交互式 

```
adb shell +命令
```

交互式->

```
adb shell
```

活动管理器（AM）：启动指定界面，绕过开屏广告

```
am start 包名/活动名
```

```
am start com.android.test/com.android.test.MainActivity
```

活动名中有包名，可用.代替包名

```
am start com.android.test/.MainActivity
```

强制结束运行的软件

```
am force-stop com.android.test
```

包管理器（PM）：冻结，卸载系统软件，清除数据，授予权限，提取APK。

强制禁用软件

```
pm disable-user com.android.test
```

启用禁用的软件

```
pm enable com.android.test
```

卸载系统软件

```
pm uninstall --user 0 com.android.test
```

恢复卸载的系统软件

```
cmd package install-existing com.android.test
```

提取apk(获取apk路径)

```
pm path com.android.test
```

pull到电脑

```
adb pull /path/to/app.apk "C:/file"
```

获取所有apk包名(window 用 findstr Linux用grep 查找字符串)

```
pm list package | findstr com.android
```

窗口管理器（WM）：修改分辨率，DPI，缓解触摸失灵问题。

获取分辨率

```
wm size
```

设置分辨率

```
wm size 1920x1080
```

恢复分辨率

```
wm size reset
```

修改DPI（越高，字越大）

```
wm density 400
```

恢复DPI

```
wm density reset
```

输入控制（input）：模拟点击，滑动，长按，锁屏手势，自动化操作。

模拟点击屏幕(开发者指针位置获取当前触摸坐标)

```
input tap x y
```

模拟滑动屏幕（x1 y1起始坐标，x2 y2终点坐标，滑动时长单位毫秒。起点终点同一坐标实现长按效果）

```
input swipe x1 y1 x2 y2 滑动时长
```

模拟按键

```
input keyevent 键值
```

常用键值：

3 HOME键 4 返回键 5 打开拨号应用 6 挂断电话 24 增加音量

25 降低音量 26 电源键 27 拍照（先打开相机应用） 64 打开浏览器

82 菜单键 85 播放暂停 86 停止播放 87 播放下一首 88 播放上一首

122 移动光标到行首 123 移动光标到行末 126 恢复播放 127 暂停播放

164 静音 176 打开系统设置 187 切换应用 207 打开联系人 208 打开日历

289 打开音乐 210 打开计算器 220 降低屏幕亮度 221 提高屏幕亮度 223系统休眠

224 点亮屏幕 231 打开语音助手

发送文字（英文，数字，字符，不能发中文）

```
input text 内容
```

## -s参数：存在多台设备，指定其中的一台

例如：指定 DEVICE0X1 安装APK

```
adb -s DEVICE0X1 install app.apk
```
## adb install 安装apk

例如：安装当前目录APK

```
adb install app.apk
```

指定路径 C:\file 下的APK安装：

```
adb install C:\file\app.apk
```

路径存在空格，用英文引号引起：

```
adb install "C:\app file\app.apk"
```
## adb install 参数

使用方式

```
adb install -参数 xx.apk
```

-t 允许安装debug版测试包

-l 锁定应用程序

-s 将程序安装到sd卡上

-g 安装后自动授予所有权限

-r 替换已存在应用程序，强制安装

-d 允许降级安装

## adb uninstall 参数

使用方式

```
adb uninstall -参数 包名
```

-k 保留数据卸载

包名在设置可查看（小米），或用包名查看器。

## 传输文件 adb push 和 adb pull

adb push 传文件到手机

```
adb push file.mp4 /sdcard
```

adb pull 传文件到电脑

```
adb pull file.mp4 "C:\file"
```

adb pull 传文件（中文文件名）到电脑 路径后补全文件名(否则不带后缀名)

```
adb pull 文件名.mp4 "C:\file\文件名.mp4"
```

## adb reboot命令

重启手机

```
adb reboot
```

重启到恢复模式

```
adb reboot recovery
```

重启到fastboot模式，与VAB分区无关，通常刷boot，super等。

```
adb reboot bootloader
```

重启到fastbootd模式（VAB分区机型）此模式可刷super小分区，如system，vendor等。

```
adb reboot fastboot
```

重启到9008模式

```
adb reboot edl
```

重启到挖煤模式

```
adb reboot download
```

关机

```
adb reboot -p
```