---
title: 安装一个 VPS 需要的步骤
tags  :
- IT技术
- VPS
- 云服务
---

# 去掉 CentOS 的 rm 防护

    vi ~/.bashrc
    注释掉下面三项
    # alias rm='rm -i'
    # alias cp='cp -i'
    # alias mv='mv -i'

# 为自己配置公钥

    scp ~/.ssh/id_rsa.pub root@182.92.3.49:.ssh/pub.zozoh.key
    ssh root@yourvps
    cd ~
    chmod 700 .ssh
    cd .ssh
    chmod +x authorized_keys 

# 在CentOS上安装Git

    yum install git
    git config --global user.name "gitvps"
    git config --global user.email gitvps@nutzam.com

# 安装必要的依赖库

    yum update gcc g++
    yum install libtool
    yum install gcc-c++

# 在CentOS上安装 nginx

    scp nginx.install.tar root@yourvps:/opt
    ssh root@yourvps
    cd /opt
    tar xvf nginx.install.tar


## 依次编译安装

    tar xvzf zlib-1.2.8.tar.gz; 
    cd zlib-1.2.8;
    ./configure
    make; make install; 
    cd ..
    
    tar xvzf pcre-8.21.tar.gz; 
    cd pcre-8.21
    ./configure
    make; make install; 
    cd ..

    tar xvzf openssl-1.0.1g.tar.gz; cd openssl-1.0.1g
    ./config zlib
    make; make install

    tar xvzf nginx-1.7.0.tar.gz
    cd nginx-1.7.0
    ./configure --with-pcre=../pcre-8.21 --with-zlib=../zlib-1.2.8 --with-openssl=../openssl-1.0.1g


# 安装 Java 以及相关运行环境

## JDK
    scp jdk-7u55-linux-i586.tar.gz root@182.92.3.49:/opt
    tar xvzf jdk-7u55-linux-i586.tar.gz 
    ln -s jdk1.7.0_55/ jdk

## Ant
    wget http://mirrors.cnnic.cn/apache//ant/binaries/apache-ant-1.9.3-bin.tar.gz
    tar xvzf apache-ant-1.9.3-bin.tar.gz
    ln -s apache-ant-1.9.3 ant

# 设置系统环境变量

    vi /etc/bashrc
    增加下面的变量
    # Add path
    export PATH=$PATH:/opt/jdk/bin:/opt/ant/bin:/usr/local/nginx/sbin
    export JAVA_HOME=/opt/jdk

# 创建操作用户 www

    adduser www
    paddwd www
    98Azf3D-X!   <-- 随便乱输几个然后忘记它
    mkdir -p /home/www/.ssh
    cp ~/.ssh/* /home/www/.ssh/
    chown www /home/www/.ssh
    chgrp www /home/www/.ssh
    chgrp www /home/www/.ssh/* 
    chown www /home/www/.ssh/*

下面切换到 `www` 用户
    
    mkdir bin
    mkdir -p workspace/git/nutzam
    mkdir -p workspace/git/github
    mkdir web
    mkdir web/_dft
    mkdir web/demo

## 获取必要的软件

    cd ~/workspace/git/github
    git clone https://github.com/nutzam/nutz.git
    git clone https://github.com/nutzam/nutz-vfs.git
    git clone https://github.com/nutzam/nutz-web.git
    git clone https://github.com/zozoh/zdoc.git
    git clone https://github.com/nutzam/nutzam.git
    cd ~/workspace/git/nutzam
    git clone git@git.nutzam.com:business/guanahani.git

## 设置内部 bin 的脚本

    scp www.bin.tar.gz www@youvps:~

















