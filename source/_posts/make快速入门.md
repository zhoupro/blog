---
title: make快速入门
date: 2018-11-14 15:36:04
tags: 
  - make
categories:
  - 工具
---
## make做什么
大型项目为了方便维护和书写，拆分为大量的源文件和头文件。makefile告诉make如何编译、链接。当重新编译时只需重新编译改变的文件即可，当一个头文件修改后，依赖该头文件的源文件需要重新编译

## make帮助手册的一个实例

```makefile
edit : main.o kbd.o command.o display.o \
            insert.o search.o files.o utils.o
             cc -o edit main.o kbd.o command.o display.o \
                        insert.o search.o files.o utils.o
     main.o : main.c defs.h
             cc -c main.c
     kbd.o : kbd.c defs.h command.h
             cc -c kbd.c
     command.o : command.c defs.h command.h
             cc -c command.c
     display.o : display.c defs.h buffer.h
             cc -c display.c
     insert.o : insert.c defs.h buffer.h
             cc -c insert.c
     search.o : search.c defs.h buffer.h
             cc -c search.c
     files.o : files.c defs.h buffer.h command.h
             cc -c files.c
     utils.o : utils.c defs.h
             cc -c utils.c
     clean :
             rm edit main.o kbd.o command.o display.o \
                insert.o search.o files.o utils.o
```


## 对应的森林
makefile可以理解成数据结构中的森林。

![make tree](https://raw.githubusercontent.com/zhoupro/images/master/20181114/make执行流程.jpg "makefile对应的树")
makefile由一系列规则组成，规则的格式如下：
```bash
target ... : prerequisites ... 
    recipe
```
prerequisites是本规则的依赖。recipe一些列命令，用于产生target。   简化为函数形式为
```
func(pre1, pre2, ...)
    recipe1
    recipe2
    ...
    recipen
    return target

```
也可以没有依赖和返回
```
func()
    recipe1
    recipe2
    ...
    recipen
```

### 执行make的流程
> 类似二叉树的后续遍历
* 先访问edit, 发现有依赖，继续访问main.o,有依赖，继续访问main.c，没有依赖。再访问defs.h没有依赖。访问main.o。比较
main.o和main.c、defs.h的修改时间。如果main.c或者defs.h的修改时间大于main.o。则执行main.o中的脚本 cc -c main.c。否则继续使用main.o
* 继续访问utils.o。发现有依赖，继续访问utils.c，无依赖。访问defs.h无依赖。如果utils.c和defs.h的修改时间有大于utils.o则执行utils.o的脚本cc -c utils.c。否则继续使用utils.o
* 访问edit节点，如果main.o ... utils.o的修改时间大于edit的时间。则执行cc -o edit main.o ... utils.o。否则继续使用edit。

### 执行make clean的流程
make无依赖，直接执行recipe就可。


