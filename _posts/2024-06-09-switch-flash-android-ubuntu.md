---
layout: post
title: Switch 刷入安卓（Lineage OS）和 Ubuntu
categories: Switch
description: Switch 刷入安卓（Lineage OS）和 Ubuntu
keywords: Switch, Android, Ubuntu
---

记录一下 Switch 刷入安卓（Lineage OS）和 Ubuntu

## 前置步骤

1. 已经硬破的Nintendo Switch一台，破解的芯片为hwfly 芯片即常称的国产芯片（第四代芯片可升级固件）
2. 用于升级的hwfly-nx固件0.7.2版本，因我此前购买的芯片固件版本低，无法引导进入Lineage OS，此版本固件可引导安卓和Ubuntu等系统，GitHub：https://github.com/hwfly-nx/firmware
3. switchroot项目提供的Android和Ubuntu等系统文件，https://download.switchroot.org
4. 大气层整合包已安装到SD卡上。

## hwfly 固件升级

hwfly 芯片由商家焊接在Switch主机内部，个人不便拆机刷入，因此通过内存卡更新固件即可。

1. 下载hwfly-nx固件0.7.2版本https://github.com/hwfly-nx/firmware
2. 将解压出的 **hwfly_toolbox.bin** 放到 sd 卡的 **/bootloader/payloads/** 中
3. 将解压出的 **sdloader.enc** 放进 sd 卡的根目录。
4. 开机进入 hekate，选择 playload 然后选择运行 **hwfly_toolbox.bin**
5. 从 hwfly_toolbox 的菜单中更新 SD loader
6. 从hekate菜单关闭 switch 主机
7. 将 **firmware.bin**  放到 sd 卡根目录
8. 开机进入 hekate 运行 **hwfly_toolbox.bin**
9. 从菜单更新固件（firmware）
10. 重新启动 switch 完成更新

更新后拔出SD卡开机，出现HEKATE图标，下面有Failed to init SD Card字样，说明hwfly-nx固件已更新为0.7.2版本。

## HEKATE给SD卡Android和Ubuntu分区

1. 开机进入HEKATE

   ![1](\images\posts\2024-06-09-switch-flash-android-ubuntu\1.png)

2. 在Tools功能页面选择Partition SD Card选项

   ![2](\images\posts\2024-06-09-switch-flash-android-ubuntu\2.png)

3. 弹出窗口选择不要备份

   ![3](\images\posts\2024-06-09-switch-flash-android-ubuntu\3.png)

4. 这里拖动选择要给安卓和Ubuntu Linux分配多少空间，其中HOS是留给大气层虚拟系统的分区，等下要把Android和Ubuntu安装包放进这个分区所以要预留一部分。

   ![4](\images\posts\2024-06-09-switch-flash-android-ubuntu\4.png)

5. 选择好后点start开始分区，例如128G的SD卡，我把Linux（Ubuntu）分了32G，Android分64G，剩下的留给HOS。（图片为网图并非我实际分区情况）

   ![5](\images\posts\2024-06-09-switch-flash-android-ubuntu\5.png)

6. switch数据线连接电脑，选择SD UMS后把从switchroot下载的 nx-tab-beta2.75-20230705-rel （Android 11）文件解压复制进SD卡目录，theofficialgman-ubuntu-jammy-5.1.2-2024-03-29 解压后复制进SD卡目录。从电脑安全弹出  SD UMS后，分别点Flash Linux和 Flash Android。

7. 回到HEKATE主页，点More Configs （更多设置）可看到Lineage OS和 Ubuntu 系统入口。

   ![6](\images\posts\2024-06-09-switch-flash-android-ubuntu\6.jpg)

8. 进入Ubuntu系统

   ![7](\images\posts\2024-06-09-switch-flash-android-ubuntu\7.jpg)

9. 进入Lineage OS系统

   ![8](\images\posts\2024-06-09-switch-flash-android-ubuntu\8.jpg)

## 参考资料

更新hwfly固件0.7.2版本图文教程：https://www.marsshen.com/posts/53cdbb65/

安装Android（Lineage OS）视频教程：https://www.bilibili.com/video/BV1h94y1T7ZK

DeepSea大气层整合包：https://github.com/Team-Neptune/DeepSea/releases

hwfly-nx固件0.7.2版本下载：https://github.com/hwfly-nx/firmware

switchroot项目系统文件：https://download.switchroot.org

