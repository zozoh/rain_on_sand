Git 常用命令速记
======

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
