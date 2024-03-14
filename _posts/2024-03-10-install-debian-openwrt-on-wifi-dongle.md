---
layout: post
title: USB随身WiFi刷入Debian作为Linux开发板
categories: Linux
description: USB随身WiFi刷入Debian作为Linux开发板
keywords: Linux, Debian, Wifi-Dongle
---

高通410芯片（MSM8916）随身WiFi刷入Debian作为Linux开发板

## 前言

很多平台走量卖的随身WiFi主要是卖里面的流量，所以设备卖的便宜，领券很多能0.01元购，很多人拿来插自己的卡上网或刷机。随身WiFi机型分为电池机和WiFi棒子，芯片分为**高通410(芯片印MSM8916)，高通210，ASR，紫光展锐，中兴微**等。其中高通芯片可玩性最高，根据板子的板号分为103s，uz801，sp970等。我目前买到两种板号的高通随身WiFi棒子分别是103s，uz801。下面以这两种板子为例刷入Debian系统。
![wifi-dongle](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\01_wifi-dongle.jpg)

## 前置步骤

#### 开启adb

对于uz801，首先把随身WiFi插入电脑usb接口，然后按照棒子上的WiFi名称和密码连接上，
在浏览器输入192.168.1.1/usbdebug.html,听到两声提示音表示棒子自动重启，这时候就已经开启了adb了。

对于103s设备，默认开启adb，无需操作。

#### 进入后台（非必须）

对于uz801（品牌本腾），后台192.168.0.1，账号admin，密码xscmadmin888，切卡密码xscm888

## 备份固件

刷机之前先做个全量备份，以免操作失误变砖无法恢复。

#### 进入9008模式

103s的板子进入9008模式，需要拆机找到9008按钮，按住9008按钮插入USB接口，在桌面此电脑右键，管理，设备管理器里端口出现高通9008端口，即进入9008模式。

![qualcomm9008](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\02_qualcomm9008.PNG)

uz801的板子，进入9008模式需拆机找到9008模式短接点，短接两点插入USB接口即进入9008模式（此方法进入的9008备份或刷机过程会断开，解决办法是一直短接，如有烙铁可以焊两根线上去方便短接）

![9008-1](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\03_9008-1.jpg)

短接另外两点可能进入fastboot模式，我没试过，待确认

![9008-2](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\04_9008-2.jpg)

另：想让uz801板子的9008长久不断开，也可以将USB接口引脚面朝自己，从左到右数3，4引脚短接，插入USB即可。（小心其它引脚短路会烧掉板子）

#### 使用miko备份全量固件

解压moko后，运行Loader.exe打开软件，确保设备管理器出现9008端口，依次点击Read，Partition Backup/Erase,Load Partition Structure,可以看到出现很多分区。

![05_miko](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\05_miko.PNG)

点击Read Full Image，命名并选择保存的位置，会出现一个.bin文件，大概3.6G，这个就是备份的全量包。（如果备份固件或刷机时掉出9008模式，需要一直长按短接按钮，或保持短接触点，保持9008不会掉出）

备注：miko软件、全量刷机包，文件名不要包含中文，也不要放在中文路径下。

#### 激活Qualcomm Premium Tool V2.4软件

Qualcomm Premium Tool V2.4以下简称QPT，下载解压的文件结构如下：

![06_QPT_dir](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\06_QPT_dir.PNG)

运行 “先点这个注册！.exe” ，点击GenerateKey，生成一个.key文件到任意位置，打开Qualcomm Premium Tool.exe软件，点击左上角的Help，点击Activate,选择刚刚生成的key文件，打开确定，右下角显示Activated，代表软件被激活。

#### 使用Qualcomm Premium Tool备份以下分区

点击Qualcomm，点击Qualcomm，partition，勾选Scan，点击Do job，软件左边Log窗口会显示信息，稍等一会儿显示OK，软件左下角显示process pass，右侧列表显示所有分区。

![07_QPT](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\07_QPT.PNG)

Scan跳到Backup，点击1号modem分区，点击Do job，选择保存位置，确定就开始备份了，软件左边Log窗口会显示Backing：modem -Finish就备份好了modem分区。同样操作备份modem，modems1，modemst2，fsg分区。其中modem分区备份的文件名为：NON-HLOS.bin，用7z解压NON-HLOS.bin得到image文件夹备用。（也可以勾选Backup All点击Do job备份全部分区） 

## 恢复固件（救砖）

有时会遇到误删分区，刷错包的情况，导致设备变砖，这时可以进入9008用全量包恢复设备初始状态。

#### 使用miko恢复全量固件

确认进入9008模式，在miko点flash，emmc block0 flasher，双击选.bin固件位置，点FLASH刷入全量包。

![08_miko_flash](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\08_miko_flash.PNG)

## 刷入固件

#### 刷入aboot.bin

解压苏苏小亮亮的openwrt（Debian）固件https://www.123pan.com/s/XwVDVv-WICn3，进入9008模式。

在Qualcomm Premium Tool里点击Qualcomm，点击partition，勾选Scan，点击Do job，右侧列表显示所有分区，勾选黄色字体的Write，
点击列表里的aboot分区，点击Do job，选择下载解压出来的苏苏小亮亮的openwrt（Debian）固件OpenWrt_UZ801里的aboot.bin文件，刷入aboot.bin。

#### 进入fastboot模式

勾选红色字体的Format，点击列表里的boot分区，点击Do job ，删除boot分区，重新拔插棒子（不要短接9008触点）， 棒子自动进入到fastboot模式。

![09_QPT_flash_aboot](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\09_QPT_flash_aboot.PNG)

此时在终端输入`fastboot devices`可发现设备，说明进入fastboot模式成功。(需添加adb工具到环境变量，或进入adb工具的路径使用)

![10_fastboot_devices](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\10_fastboot_devices.PNG)

#### fastboot模式下刷入Debian/openwrt

进入解压出来的openwrt(Debian)固件，双击flash.bat运行脚本，每刷一部分需要按提示继续，根据提示按任意键，稍等一会儿直到出现all done！！按任意键结束刷机。

![11_fastboot_flash](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\11_fastboot_flash.PNG)

## 后续步骤

#### ssh登录进Debian

此时设备会发出名为 debian-4G_UFI_123456 的WiFi，密码为12345678，使用ssh工具登录，IP：192.168.68.1，端口为22，用户名：root 密码：1

#### 解决插SIM卡不能上网的问题

查看sim卡状态

```
mmcli -m 0
```

如果返回`error: couldn't find modem`

将之前备份的modem分区的NON-HLOS.bin用7z解压得到的image文件夹，用SFTP软件上传到Debian的/root路径，然后在Debian里执行`cp -r /root/image/* /lib/firmware/`，将里面的文件复制到/lib/firmware/，然后`reboot`，可能会解决一部分的SIM卡不能上网的问题。

目前已知uz801的固件是不能用SIM卡上网的，103s切换卡槽可以上网

#### 从ESIM切换到卡槽SIM卡上网

默认上网是通过ESIM上网，需要切换到SIM卡卡槽

查看sim卡状态

```
mmcli -m 0
```

![12_nmcli](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\12_nmcli.PNG)

Debian切换esim

```
echo 0 > /sys/class/leds/sim\:sel/brightness
echo 1 > /sys/class/leds/sim\:sel2/brightness
systemctl restart rmtfs
systemctl restart ModemManager
```

Openwrt切换esim

```
echo 0 > /sys/class/leds/sim\:sel/brightness
echo 255 > /sys/class/leds/sim\:sel2/brightness
/etc/init.d/rmtfs restart
/etc/init.d/modemmanager restart
```

切换后插卡应该可以在Debian上网，使用`ping baidu.com`可以测试

#### 解决在Windows环境下无法通过USB与本机通信

在此电脑右键，管理，设备管理器，其它设备，会出现未知设备。右键点未知设备，更新驱动程序，浏览我的电脑以查找驱动程序，让我从计算机的可用驱动程序列表中选取，点击网络适配器，下一步，厂商选择：Microsoft，
型号选择：基于远程NDIS的internet共享设备，点击是，安装完成后点关闭关闭窗口。

![13_RNDIS_deiver](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\13_RNDIS_deiver.PNG)

这时可以通过USB网络连接Debian。断开WiFi，在cmd输入`ipconfig`可以看到ip为192.168.68.1的USB网络设备。可以通过ssh连接到Debian设备

#### 将WiFi从网桥（热点）改为连接模式联网

ssh进入Debian，输入

```
nmtui
```

进入网络管理器

![14_nmtui](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\14_nmtui.PNG)

使用上下左右键控制光标，回车进入菜单，ESC退出菜单。

![15_nmtui_wifi](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\15_nmtui_wifi.PNG)

进入编辑连接，进入网桥bridge，光标选择WiFi连接，点删除。

![16_nmtui_wifi_del](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\16_nmtui_wifi_del.PNG)

选择删除即可。

![16_nmtui_wifi_del](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\17_nmtui_connect.PNG)

ESC退出到主菜单，进入启用连接，

![18_nmtui_connect_wifi](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\18_nmtui_connect_wifi.PNG)

选择WiFi输入密码连接，已连接的WiFi前会有*号，这时已经有网络，可以通过`apt update`和`apt upgrade`更新软件包。

## 总结

此时随身WiFi棒子已经变成一个Debian的Linux电脑，可以实现WiFi联网，USB网口ssh通信，SIM卡4G上网等，其内存512M，存储4G，适合跑一些轻量化程序，dockers，青龙面板，LN(A)MP，web站点等。

最后看一下我本次的消费

![19_cost1](\images\posts\2024-03-10-install-debian-openwrt-on-wifi-dongle\19_cost1.PNG)

#### 参考资料

https://www.123pan.com/s/XwVDVv-WICn3

https://www.kancloud.cn/handsomehacker/openstick/2636505

https://www.kancloud.cn/a813630449/ufi_car/2779674

https://space.bilibili.com/4194125

https://qust.me/post/msm8916/

https://zyyme.com/msm8916-wifi.html

https://www.coolapk.com/feed/52159292?shareKey=YTBjNWYwZjU4NTBiNjVmMmZhMTY

感谢以上作者的无私奉献