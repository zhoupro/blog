---
title: 使用hexo搭建博客
date: 2018-11-13 17:21:37
tags:
- hexo
categories:
- 工具
---
使用github page来托管我们的博客内容。文章的书写格式为markdown。使用hexo完成markdown到html的转换, 使用hexo deploy发布到github page上。

## 相关名词
- markdown

John Gruber在2004年发明了markdown, markdown易写易读,使用工具可以方便的转换为html等格式。

- github page

github page提供静态页面服务, 程序员不仅可以分享代码, 还可以写技术文章。

- hexo

nodejs开发的工具，用来把markdown转换为html静态网站

## hexo安装步骤
- 安装nodejs `brew install nodejs`
- 安装hexo `npm i -g hexo`
- 初始化根目录 `mkdir blog && cd blog && hexo init`
- 安装git部署插件 `npm install hexo-deployer-git --save`
- 切换主题(可选)
```bash 
git clone https://github.com/wzpan/hexo-theme-freemind.git themes/freemind && \
npm install hexo-tag-bootstrap --save && \
npm install hexo-generator-search --save && \
npm install hexo-recommended-posts --save
```
修改_config.yml, 切换主题 `sed -i 's/^theme:.*/theme: freemind/g' _config.yml`

## hexo 使用步骤
创建文章（正式文章或者草稿，使用markdown工具进行书写，书写完成后转换为html格式后进行发布。在书写工程中也可以在执行`hexo gen && hexo server`后访问localhost:4000预览效果。

## 命令参考
- 创建草稿 `hexo new draft 标题`
- 发布草稿成为正式文章 `hexo publish 标题`
- 创建正式文章 `hexo new 标题`
- 使用文本工具进行写作, 如使用`vim编辑 vim 标题`
- 转换markdown到静态文件 `hexo gen`
- 预览网站效果 `hexo server`
- 发布到github page `hexo deploy`
- 清空生成文件 `hexo clean`

## hexo部署方案
我希望markdown源文件和hexo生成的静态文件完全隔离。可以方便随时切换主题甚至工具，我只关心源markdown文件。所以设置两个仓库，一个保存hexo生成的html, 一个包含源markdown文件及配置文件。使用ln建立链接。算是linux下的kiss原则吧。我使用 [blog](https://github.com/zhoupro/blog)和[zhoupro.github.io](https://github.com/zhoupro/zhoupro.github.io) 来搭建博客。

## 简化流程
[blog](https://github.com/zhoupro/blog)中的init.sh脚本把以上步骤自动化, 执行 `. ./init.sh`后直接写作即可。

## 图片处理
参考上传图片到github，创建自己的github仓库，然后配置下脚本 `curl https://gist.githubusercontent.com/zhoupro/e09657196114420d63218ebe77079d05/raw/c6d3bd4d8d3dc342813ae37de4e3aed652f9ac30/sh -o genUrl.sh && bash genUrl.sh yourpic`。你也可以上传到第三方服务，使用它们生成的链接。

