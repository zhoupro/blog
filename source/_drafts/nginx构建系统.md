# nginx 构建系统分析

## 问题
* 如何检测c编译器能正常工作
* configure脚本是否为自动生成
* 生成makefile文件的方法



## redis的makefile
```bash
OPTIMIZATION?=-O2
ifeq ($(uname_S),SunOS)
  CFLAGS?= -std=c99 -pedantic $(OPTIMIZATION) -Wall -W -D__EXTENSIONS__ -D_XPG6
  CCLINK?= -ldl -lnsl -lsocket -lm -lpthread
else
  CFLAGS?= -std=c99 -pedantic $(OPTIMIZATION) -Wall -W $(ARCH) $(PROF)
  CCLINK?= -lm -pthread
endif
CCOPT= $(CFLAGS) $(CCLINK) $(ARCH) $(PROF)
DEBUG?= -g -rdynamic -ggdb 

OBJ = adlist.o ae.o anet.o dict.o redis.o sds.o zmalloc.o lzf_c.o lzf_d.o pqsort.o zipmap.o sha1.o ziplist.o release.o networking.o util.o object.o db.o replication.o rdb.o t_string.o t_list.o t_set.o t_zset.o t_hash.o config.o aof.o vm.o pubsub.o multi.o debug.o sort.o

PRGNAME = redis-server

all: redis-server

# Deps (use make dep to generate this)
adlist.o: adlist.c adlist.h zmalloc.h
ae.o: ae.c ae.h zmalloc.h config.h ae_kqueue.c
ae_epoll.o: ae_epoll.c

redis-server: $(OBJ)
	$(CC) -o $(PRGNAME) $(CCOPT) $(DEBUG) $(OBJ)
	@echo ""
	@echo "Hint: To run 'make test' is a good idea ;)"
	@echo ""

noopt:
	make OPTIMIZATION=""

```
## gcc的示例
大多数软件包遵守如下约定俗成的规范：
* 1,首先从源代码生成目标文件(预处理,编译,汇编)，"-c"选项表示不执行链接步骤。
>$(CC) $(CPPFLAGS) $(CFLAGS) example.c   -c   -o example.o
* 2,然后将目标文件连接为最终的结果(连接)，"-o"选项用于指定输出文件的名字。
>$(CC) $(LDFLAGS) example.o   -o example
* 有一些软件包一次完成四个步骤：
>$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) example.c   -o example

CFLAGS 与 CXXFLAGS
CFLAGS 表示用于 C 编译器的选项，CXXFLAGS 表示用于 C++ 编译器的选项。这两个变量实际上涵盖了编译和汇编两个步骤。大多数程序和库在编译时默认的优化级别是”2″(使用”-O2″选项)并且带有调试符号来编 译，也就是 CFLAGS=”-O2 -g”, CXXFLAGS=$CFLAGS 。事实上，”-O2″已经启用绝大多数安全的优化选项了。另一方面，由于大部分选项可以同时用于这两个变量，所以仅在最后讲述只能用于其中一个变量的选 项。[提醒]下面所列选项皆为非默认选项，你只要按需添加即可。

LDFLAGS
ld用于指定链接时参数
```bash
CC=gcc
CFLAGS=-Wall
LDFLAGS=-lm

.PHONY: all clean

all: client

clean:
    $(RM) *~ *.o client

    OBJECTS=client.o
    client: $(OBJECTS)
        $(CC) $(CFLAGS) $(OBJECTS) -o client $(LDFLAGS)
```
CFLAGS="-I/usr/local/include" LDFLAGS="-L/usr/local/lib"




## redis的makefile总结
### gcc的常用参数含义
* 指定编译目标名称 -o
* 指定标准 -std=c99
* 优化级别 -O 
* gcc报错  -pedantic   -Wall -W  
* 编译  -c
* 链接指定库 -lm -pthread
* 调试 -g  -ggdb
* CFLAGS:c编译器参数  CXXFLAGS:c++编辑器参数 
* CPPFLAGS:c/c++预处理器参数

## 如何生成makefile文件
* 手写(redis)
* 通过autoconf、automake生成
* 自己开发工具生成(nginx)

