---
title: nginx构建系统
date: 2018-11-06 15:51:14
tags:
  - nginx
  - configure

categories:
  ['源码解析', 'nginx', 'configure']
---

# nginx 构建系统分析

## 问题
* 如何检测c编译器能正常工作
* configure脚本是否为自动生成
```bash
./configure && make && make install
```

## 脚本分析 

### auto/feature
检查是否具有该特性

