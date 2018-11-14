# nginx构建系统分析

## 开发者工具箱

* 编辑器：vim, emacs
* 编译器：gcc
* 调试器：gdb
* 调优: valgrind, perf
* 单元测试：tcl, phpunit
* 构建工具：make, cmake
* 胶水语言：shell
* ...

## nginx构建
> 使用shell语言生成make的构建文件makefile，以及ngx_auto_config.h,ngx_auto_headers.h,ngx_modules.c

### configure主流程
- auto/options
根据configure的参数，初始化和configure参数相关的变量值

- auto/init
定义自动生成的文件名称

- auto/source
定义模块名称, 头文件查找目录, 头文件，源文件

- auto/cc/conf
选择编译器。假设选择gcc。会构造gcc的编译选项, 赋值CFLAGS, 针对gcc版本、操作系统、cpu等添加参数。

- auto/headers
向ngx_auto_headers.h写入通用的头文件

- auto/os/conf
检查操作系统特性。以linux,x86为例。
检查epoll,sendfile, sched_setaffinity, crypt_r, crypt_r等功能

- auto/unix
检查poll,kqueue, crypt, fcntl, posix_fadvise, directio, statfs, dlopen, sched_yield, setsockopt, getsockopt,accept4等特性。定义指针，size_t,time_t长度,一些typedef，机器大小端。

- auto/modules
根据用户编译参数,定义一些常量; 
```c

```
生成ngx_modules.c
```c
extern ngx_module_t  ngx_http_range_body_filter_module;
extern ngx_module_t  ngx_http_not_modified_filter_module;

ngx_module_t *ngx_modules[] = {
    &ngx_core_module,
    &ngx_errlog_module,
    &ngx_conf_module,
```
- auto/lib/conf
pcre, openssl, md5,libgd,zlib等库
- auto/make
创建makefile脚本
- auto/lib/make
依赖库makefile
- auto/install
makefile的install部分
- auto/summary
汇总一些检查信息
