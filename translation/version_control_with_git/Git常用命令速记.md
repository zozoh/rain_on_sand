---
title: Git 常用命令速记
tags:
- git
---

## 对象操作

    ---------------------------------: 查看对象纯粹内容
    $ git cat-file -p 3b18e512dba79e4c8300dd08aeb37f8e728b8dad 
    hello world
    ---------------------------------: 得到对象全 ID
    $ git rev-parse 3b18e512d 
    3b18e512dba79e4c8300dd08aeb37f8e728b8dad 
    ---------------------------------: 列对象索引
    $ git ls-files -s
    100644 3b18e512dba79e4c8300dd08aeb37f8e728b8dad 0 hello.txt
    ---------------------------------: 保存索引
    $ git write-tree
    68aba62e560c0ebc3396e8ae9335232cd93a3f60
    ---------------------------------: 显示一个对象更多的细节
    git show --pretty=fuller 49241326933
    tree 49241326933

    hello.txt
    subdir/
    ---------------------------------: 打标签，并显示标签对象名
    git tag -m"Tag version 1.0" V1.0 e15cfa
    git rev-parse V1.0
    ea6a697cc294394f407ed28c259a0c4e5b66fd0d




