---
layout: post
title: 从零开始搭建github pages博客
categories: Blog
description: 博客，用来记录学过的东西，也可做备忘录。
keywords: 测试, 博客
---
记录从零开始搭建github pages博客

## 了解github pages

GitHub Pages 是一项静态站点托管服务，它直接从 GitHub 上的仓库获取 HTML、CSS 和 JavaScript 文件，（可选）通过构建过程运行文件，然后发布网站。

在此我将使用GitHub pages的服务搭建博客。

github pages介绍及文档：https://pages.github.com/

## 了解Jekyll

Jekyll是一个简单的静态网站生成器，用于生成个人，项目或组织的网站。 它由GitHub联合创始人汤姆·普雷斯顿·沃纳用Ruby编写，并根据MIT许可证发布。

以下是其目录结构：

```
.
├──_config.yml
├── _drafts
|   ├── begin-with-the-crazy-ideas.textile
|   └── on-simplicity-in-technology.markdown
├── _includes
|   ├── footer.html
|   └── header.html
├── _layouts
|   ├── default.html
|   └── post.html
├── _posts
|   ├── 2007-10-29-why-every-programmer-should-play-nethack.textile
|   └── 2009-04-26-barcamp-boston-4-roundup.textile
├── _site
├── .jekyll-metadata
└── index.html

```

在此我的博客将放在_posts文件夹内，命名规则为：2023-01-01-yourpostname.md。

其使用Markdown格式。

## 了解Markdown格式

Markdown是一种轻量级标记语言，创始人为约翰·格鲁伯。它允许人们使用易读易写的纯文本格式编写文档，然后转换成有效的XHTML（或者HTML）文档。

在此我将使用markdown格式，写每一篇文章

## 创建博客仓库

所以在GitHub新建仓库，

![new-repository](\images\posts\2023-6-25-buildablog\img1.PNG)

GitHub pages仓库名命名规则是：yourusername.github.io，

举例我的用户名为：jerry1233，所以我仓库名为jerry1233.github.io

## fork源码

你可以fork一个模板或者直接下载源码，我是用这个模板：

mzlogin.github.io，

github链接：https://github.com/mzlogin/mzlogin.github.io

在里面fork即可

如果你是fork的模板，branch（分支）选master，自己创建的branch就是main

## 发布站点

创建好后在settings里找到pages，

![settings](\images\posts\2023-6-25-buildablog\img2.PNG)

![pages](\images\posts\2023-6-25-buildablog\img3.PNG)

在你的仓库->settings->pages->找到github pages，如果你的网站已经发布了，会显示：Your site is live at https://yourusername.github.io/

此时访问https://yourusername.github.io即可进入你的博客

## 扩展：使用git管理站点源码

你在git网站https://git-scm.com/download/win下载了64位exe后安装，本地找一个文件夹作为你的git仓库，然后执行：

```
git clone https://github.com/jerry1233/jerry1233.github.io.git
```

如果github访问不畅按我另一篇文章配置socks5代理

clone到本地后，进入目录

```
cd jerry1233.github.io
```

然后将所有文件添加到本地仓库

```
git add .
```

然后提交

```
git commit -m "firest commit"
```

添加远程连接

```
git remote add origin git@github.com:jerry1233/jerry1233.github.io.git
```

推送代码到远端github

```
git push -u origin master
```

这里注意分支的名字，如果你没有fork而是上传源码，分支就是main

备注：期间需要验证身份，测试用账号密码是无法验证的，用key验证了

