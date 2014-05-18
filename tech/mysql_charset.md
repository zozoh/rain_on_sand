---
title:Mysql 乱码问题
tags  :
- IT技术
- mysql
---

通过下列命令查看一下字符集

```DB
mysql> show variables like 'character%';
+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8                       |
| character_set_connection | utf8                       |
| character_set_database   | latin1                     |
| character_set_filesystem | binary                     |
| character_set_results    | utf8                       |
| character_set_server     | latin1                     |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+
```

修改一下 Mysql 配置文件

```
vi /etc/my.cnf
#------------------------------------------
[client]
default-character-set=utf8

[mysql]
default-character-set=utf8

[mysqld]
character_set_server=utf8
```

接着重启 mysql

```
service mysqld stop
service mysqld start
```
