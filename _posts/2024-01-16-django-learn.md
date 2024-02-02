---
layout: post
title: django学习记录（持续更新中）
categories: Django
description: django基础教程
keywords: django, python
---

django学习记录以备查阅

## 创建第一个项目

使用 django-admin 来创建 django_project 项目：

```
django-admin startproject django_project
```
## 项目结构

目录说明：

.
|-- django_project  项目的容器。

|   |-- __init__.py  一个空文件，告诉 Python 该目录是一个 Python 包。

|   |-- asgi.py  一个 ASGI 兼容的 Web 服务器的入口，以便运行你的项目。

|   |-- settings.py  该 Django 项目的设置/配置。

|   |-- urls.py  该 Django 项目的 URL 声明; 一份由 Django 驱动的网站"目录"。（项目级路由文件）

|   |-- wsgi.py  一个 WSGI 兼容的 Web 服务器的入口，以便运行你的项目。

|   |-- views.py 视图处理（项目级视图文件）

`-- manage.py  一个实用的命令行工具，可让你以各种方式与该 Django 项目进行交互。

## 运行项目

进入 django_project 目录输入以下命令，启动服务器：

```
python manage.py runserver 0.0.0.0:8000
```

遇到报错：You have 18 unapplied migration(s). Your project may not work properly until

解决：

```
python manage.py migrate
```

## 运行项目

进入 HelloWorld 目录输入以下命令，启动服务器：

```
python manage.py runserver 0.0.0.0:8000
```

## Django应用与Django项目

Django项目包含Django应用

创建Django应用

```
python manage.py startapp django_app
```

Django应用目录结构：

views.py 视图处理

models.py 定义应用模型

admin.py 定义admin模块管理对象

apps.py 声明应用

tests.py 编写应用测试用例

urls.py (默认不存在，自行创建)管理应用路由

##添加Django应用到settings.py

（不做这步骤不影响views功能）

编辑settings.py

```
INSTALLED_APPS = [
    #my app
    'sgk_app.apps.XXXAppConfig',
]
```

XXXAppConfig在应用目录，apps.py里查看

##Django视图

视图就是views.py中的python函数

视图接受Web请求HttpRequest。进行逻辑处理，返回Web响应HttpResponse给请求者

视图必须返回一个HttpResponse对象作为响应（HTML内容，404，重定向，json等）

在Django应用中，views.py编写：

```python

	from django.shortcuts import render
	from django.http import HttpResponse
	def hello(request):
    	return HttpResponse("视图：hello")
```

此时需配置路由才能访问


##Django路由

在应用目录创建urls.py路由文件(应用级路由)。

```python

	from django.urls import path
	import sgk_app.views
	urlpatterns = [
	    path('hello/', sgk_app.views.hello),
	]
```

然后在项目级路由文件，这里include('sgk_app.urls')，一定要''引号，路由导向应用级app->urls.py路由文件（这样访问http://127.0.0.1:8000/sgk_app/hello/ 访问了hello视图函数）：

```python

	from django.contrib import admin
	from django.urls import path,include
	urlpatterns = [
	    path('admin/', admin.site.urls),
	    path('sgk_app/', include('sgk_app.urls'))
	]
```

或者直接在项目路由配置，先导入import sgk_app.views 再 path('hello/', sgk_app.views.hello),：

这样直接 http://127.0.0.1:8000/hello/ 访问了hello视图函数

```python

	from django.contrib import admin
	from django.urls import path,include
	import sgk_app.views
	urlpatterns = [
	    path('admin/', admin.site.urls),
	    path('hello/', sgk_app.views.hello),
	]
```

如果需要在 http://127.0.0.1:8000 访问hello视图函数

在项目级路由文件配置，导入import sgk_app.views：

路径用''即可 path('', sgk_app.views.hello),

```python

	from django.contrib import admin
	from django.urls import path,include
	import sgk_app.views
	urlpatterns = [
	    path('admin/', admin.site.urls),
	    path('', sgk_app.views.hello),
	]
```

## 模型层介绍

模型层是在视图层和数据库的中间层

好处：使用模型层操作不同数据库，专注于业务逻辑的开发，提供各种工具

settings.py配置：

```python

	DATABASES = {
	    'default': {
	        'ENGINE': 'django.db.backends.sqlite3',
	        'NAME': BASE_DIR / 'db.sqlite3',
	    }
	}

```

其中ENGINE作用是：数据库驱动，NAME作用是：指定数据库文件

## 数据库模型（字段）设计

编辑models.py

```python

	from django.db import models
	class qq8e(models.Model):
	    id = models.AutoField(primary_key=True)
	    qq = models.TextField()
	    phone = models.TextField()

```

创建迁移文件

```
python manage.py makemigrations
```

（如果settings.py没有指定app，'sgk_app.apps.SgkAppConfig'，会出现No migrations to apply）

也可后加app名指定

```
python manage.py makemigrations sgk_app
```

##Django Shell

Django Shell是一个交互式编程界面，用来调试和测试

进入Django Shell:

```
python manage.py shell
```

## Django Admin模块

Django Admin模块是Django web的管理后台

创建超级用户

```
python manage.py createsuperuser
```

输入用户名，密码，其它回车跳过

http://127.0.0.1:8000/admin 即Django Admin页面