#!/bin/bash
#
#blog helper
#os
os=`uname -s`
if [ ".$os"=".Linux" ];
then
  #centos
  which yum && ! which nodejs && \
  sudo yum install -y epel-release && \
  sudo yum install -y nodejs
fi

#Install soft 
! npm list -g --depth=0 | grep hexo &&\
    npm i -g hexo 
#mkdir 
blog_dir="../blog-soft"
source_dir=`pwd`
[ ! -d $blog_dir ] && mkdir $blog_dir && cd $blog_dir && hexo init && cd $source_dir 

#make hexo use current source dir
[ -f "$source_dir/etc/_config.yml" ] && \
    cp "$source_dir/etc/_config.yml"  "$blog_dir/_config.yml" 
rm -rf $blog_dir/source && ln -s $source_dir/source $blog_dir/source && \
    cd $blog_dir && npm install hexo-deployer-git --save 

#change theme
[ ! -d themes/cafe ] && \
    git clone https://github.com/giscafer/hexo-theme-cafe.git themes/cafe

cp "$source_dir/etc/theme_config.yml" "$blog_dir/themes/cafe/_config.yml"
