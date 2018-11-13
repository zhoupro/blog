---
title: valgrind生成调用链
date: 2018-11-12 17:54:57
tags:
  - valgrind
categories:
  - 工具 
---
## valgrind查看调用关系
在学习开源代码时，我们希望有个工具能够给我们全局的视角而不过早的陷入细节的泥淖中。读书可以跳读，读代码也是可以跳读的。valgrind可以生成整个调用关系链。该关系链指导我们，迅速定位到我们关心的细节。

## 安装

ubuntu系统
```bash
apt-get install valgrind 
apt-get install kcachegrind
```
mac系统
```bash
brew install qcachegrind --with-graphviz
```


## 使用

* 使用valgrind生成调用关系

```bash
valgrind --tool=callgrind --trace-children=yes  --callgrind-out-file=/data/opt/callgrind.out.1111  ./nginx
```
* 使用qcachegrind查看调用关系

![qcachegrind](https://raw.githubusercontent.com/zhoupro/images/master/20181112/qcachegrind.png "qcachegrind")

## 问题
* Error: can not open cache simulation output file
保证写的目录有写的权限，可以创建一个目录，赋值为777，在该目录下启动命令`valgrind --tool=callgrind --trace-children=yes /data/server/nginx/sbin/nginx`, 使用kill终止程序`kill SIGINT pid`



