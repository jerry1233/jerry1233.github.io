---
layout: post
title: git push上传到GitHub时报错“Permission to repository denied”的解决方案
categories: git
description: 解决问题一次记录
keywords: git, 报错
---

记录一次git push出错的问题解决思路

## 问题描述

之前用git上传blog时,在本地配置好了GitHub token，但token有效期过了，一直报错“Permission to repository denied”

## 解决办法

百度搜了好久都无解，最后谷歌，在stackoverflow找到解决方法，

stackoverflow 链接 https://stackoverflow-com.translate.goog/questions/71953666/remote-permission-to-repository-denied-url-returned-error-403

这里补充一下。

在GitHub -> settings -> Developer Settings -> Personal access tokens -> tokens classic ->generate new token (classic)

里面添加一个token，记得把以下选项勾选：

✅repo

✅workflow

✅user

✅write:discussion

✅admin:enterprise

✅admin:gpg_key

给git重新设置一下token

```
git remote set-url origin https://<token>@github.com/<username>/<repo>
```

然后git push就可以了（如果有报错可以加上 -f 强制 push）

```
git push -u origin main -f
```