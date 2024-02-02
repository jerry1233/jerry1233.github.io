---
layout: post
title: CentOS7使用ISO镜像文件作为离线yum源(离线使用yum)
categories: Linux
description: CentOS7使用ISO镜像文件作为离线yum源(离线使用yum)
keywords: Linux, yum，CentOS
---

最近遇到这种需求，抄了一份文章，原文：https://developer.aliyun.com/article/899138

##背景

最近客户需要在centos服务器上使用一些工具，但服务器是离线状态，因保密需求不能联网。所以需要在离线状态使用yum命令安装工具。

##CentOS下载镜像

```
https://www.centos.org/download/
```

##创建ISO存放目录以及挂载目录

```
mkdir /mnt/iso /mnt/cdrom
```

##上传ISO镜像文件至/mnt/iso

```
省略...
```

##挂载ISO镜像到挂载目录

```
mount -o loop /mnt/iso/*.iso /mnt/cdrom 
```

##检查挂载是否成功

```
df -h
```

##备份/etc/yum.repos.d文件至备份文件夹

```
省略...
```

##创建repo文件并存放

```
touch local.repo
```

```
mv ./local.repo /etc/yum.repos.d
```

##写入信息至local.repo

```

	[local]
	
	name=local
	
	baseurl=file:///mnt/cdrom
	 
	enabled=1
	
	gpgcheck=0
	
	gpgkey=file:///mnt/cdrom/RPM-GPG-KEY-CentOS-7

```

##测试yum安装

```
	
	yum clean all
	
	yum install ntp

```

##取消挂载

```
umount /mnt/cdrom
```
