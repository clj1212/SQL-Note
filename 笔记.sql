mysql -u root -p

#创建数据库

mysql> create database test;
Query OK, 1 row affected (0.09 sec)

#查询数据库

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| new_schema         |
| performance_schema |
| sys                |
| test               |
+--------------------+
6 rows in set (0.01 sec)

#选择某一个数据库

mysql> use test;
Database changed
mysql> show tables;
Empty set (0.01 sec)

#创建表格

mysql> create table pet(
    -> name varchar(20),
    -> owner varchar(20),
    -> species varchar(20),
    -> sec char(1),
    -> birth date,
    -> death date);
Query OK, 0 rows affected (0.16 sec)

#查询表格

mysql> show tables;
+----------------+
| Tables_in_test |
+----------------+
| pet            |
+----------------+
1 row in set (0.07 sec)

mysql> show pet;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'pet' at line 1
mysql> select * from pet; 
Empty set (0.02 sec)

#显示表格的变量信息

mysql> describe pet;
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| name    | varchar(20) | YES  |     | NULL    |       |
| owner   | varchar(20) | YES  |     | NULL    |       |
| species | varchar(20) | YES  |     | NULL    |       |
| sec     | char(1)     | YES  |     | NULL    |       |
| birth   | date        | YES  |     | NULL    |       |
| death   | date        | YES  |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+
6 rows in set (0.04 sec)

#向表格中输入数据

mysql> insert into pet
    -> values('Sally','John','dog','f','2015-05-05',NULL);
Query OK, 1 row affected (0.09 sec)

#查询表格

mysql> select * from pet;
+-------+-------+---------+------+------------+-------+
| name  | owner | species | sec  | birth      | death |
+-------+-------+---------+------+------------+-------+
| Sally | John  | dog     | f    | 2015-05-05 | NULL  |
+-------+-------+---------+------+------------+-------+
1 row in set (0.00 sec)

#删除表格
mysql> drop table pet

#自增约束。变量id自动生成。

mysql> create table user3(
    -> id int primary key auto_increment,
    -> name varchar(20));
Query OK, 0 rows affected (0.15 sec)

mysql> insert into user3(name) values('zhangsan')
    -> ;
Query OK, 1 row affected (0.03 sec)

mysql> select * from user3;
+----+----------+
| id | name     |
+----+----------+
|  1 | zhangsan |
+----+----------+
1 row in set (0.00 sec)



mysql> insert into pet values('Angela','V','cat','m','2017-02-16',NULL)
    -> ;
Query OK, 1 row affected (0.08 sec)

mysql> select * from pet;
+--------+-------+---------+------+------------+-------+
| name   | owner | species | sec  | birth      | death |
+--------+-------+---------+------+------------+-------+
| Sally  | John  | dog     | f    | 2015-05-05 | NULL  |
| Angela | V     | cat     | m    | 2017-02-16 | NULL  |
+--------+-------+---------+------+------------+-------+
2 rows in set (0.01 sec)

#删除某行数据

mysql> delete from pet where name="Sally";
Query OK, 1 row affected (0.07 sec)

mysql> select * from pet;
+--------+-------+---------+------+------------+-------+
| name   | owner | species | sec  | birth      | death |
+--------+-------+---------+------+------------+-------+
| Angela | V     | cat     | m    | 2017-02-16 | NULL  |
+--------+-------+---------+------+------------+-------+
1 row in set (0.00 sec)


#修改某一个数据

mysql> update set name='Angelababy' where owner='V';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'set name='Angelababy' where owner='V'' at line 1
mysql> update pet set name='Angelababy' where owner='V';
Query OK, 1 row affected (0.12 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from pet;
+------------+-------+---------+------+------------+-------+
| name       | owner | species | sec  | birth      | death |
+------------+-------+---------+------+------------+-------+
| Angelababy | V     | cat     | m    | 2017-02-16 | NULL  |
+------------+-------+---------+------+------------+-------+
1 row in set (0.00 sec)



查看列：desc 表名;
修改表名：alter table t_book rename to bbb;
添加列：alter table 表名 add column 列名 varchar(30);
删除列：alter table 表名 drop column 列名;


mysql的约束
-- 主键约束 --primary_key
#它能够唯一确定一张表中的一条记录，也就是我们通过给某个字段添加约束，就可以使得字段不重复且不为空。

mysql> create table user
    -> (
    -> id int primary key,
    -> name varchar(20)
    -> );
Query OK, 0 rows affected (0.10 sec)

mysql> insert into user values(1,'Sally');
Query OK, 1 row affected (0.01 sec)

mysql> select * from user;
+----+-------+
| id | name  |
+----+-------+
|  1 | Sally |
+----+-------+
1 row in set (0.00 sec)

mysql> insert into user values(1,'John');
ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'
mysql> insert into user values(2,'John');
Query OK, 1 row affected (0.06 sec)

-- 主键约束 -- 联合主键
#只要联合的主键值加起来不重复就可以

mysql> create table user2(
    -> id int,
    -> name varchar(20)
    -> ,
    -> password varchar(20),
    -> primary key(id,name));
Query OK, 0 rows affected (0.07 sec)

mysql> insert into user2 values(1,'张三','123');
Query OK, 1 row affected (0.11 sec)

mysql> insert into user2 values(2,'张三','123');
Query OK, 1 row affected (0.06 sec)

mysql> insert into user2 values(1,'李四','123');
Query OK, 1 row affected (0.09 sec)

mysql> select * from user2
    -> ;
+----+--------+----------+
| id | name   | password |
+----+--------+----------+
|  1 | 张三   | 123      |
|  1 | 李四   | 123      |
|  2 | 张三   | 123      |
+----+--------+----------+
3 rows in set (0.00 sec)


-- 自增约束 -- auto_increment
见上



如果建表时忘记添加主键？-- 建表后的添加与删除
#添加主键

mysql> create table user4(
    -> id int,
    -> name varchar(20)
    -> );
Query OK, 0 rows affected (0.14 sec)

mysql> describe user4;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  |     | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.03 sec)

mysql> alter table user4 add primary key(id);
Query OK, 0 rows affected (0.15 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc user4;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | NO   | PRI | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

#删除主键
mysql> alter table user4 drop primary key;
Query OK, 0 rows affected (0.09 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc user4
    -> ;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | NO   |     | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.01 sec)

#使用modify修改字段，添加约束
mysql> alter table user4 modify id int primary key;
Query OK, 0 rows affected (0.14 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc user4;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | NO   | PRI | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.08 sec)


-- 唯一约束
#约束修饰的字段的值不可以重复

mysql> create table user5(
    -> id int,
    -> name varchar(20)
    -> );
Query OK, 0 rows affected (0.22 sec)

mysql> alter table user5 add unique (name);
Query OK, 0 rows affected (0.11 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc user5
    -> ;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  |     | NULL    |       |
| name  | varchar(20) | YES  | UNI | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.06 sec)


mysql> insert into user5 values(1,'zhangsan');
Query OK, 1 row affected (0.12 sec)

mysql>  insert into user5 values(2,'zhangsan');
ERROR 1062 (23000): Duplicate entry 'zhangsan' for key 'name'

mysql> insert into user5 values(1,'lisi');
Query OK, 1 row affected (0.04 sec)

mysql> select * from user5
    -> ;
+------+----------+
| id   | name     |
+------+----------+
|    1 | zhangsan |
|    1 | lisi     |
+------+----------+
2 rows in set (0.01 sec)

mysql> create table user7(
    -> id int,
    -> name varchar(20)
    -> ,
    -> unique(name));
Query OK, 0 rows affected (0.20 sec)

mysql> create table user6(
    -> id int,
    -> name varchar(20) unique
    -> );
Query OK, 0 rows affected (0.04 sec)

#unique(id,name)表示两个键在一起不重复就行
mysql> create table user8(
    -> id int,
    -> name varchar(20),
    -> unique(id,name));
Query OK, 0 rows affected (0.11 sec)

mysql> desc user8;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  | MUL | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.04 sec)



#删除唯一约束

mysql> alter table user7 drop index name;
Query OK, 0 rows affected (0.11 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc user7;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  |     | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.01 sec)



#用modify添加唯一约束

mysql> alter table user7 modify name varchar(20) unique;
Query OK, 0 rows affected (0.15 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc user7;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  |     | NULL    |       |
| name  | varchar(20) | YES  | UNI | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.02 sec)



-- 非空约束
修饰的字段不能为空 NULL

mysql> create table user10(
    -> id int, name varchar(20) not null);
Query OK, 0 rows affected (0.06 sec)

mysql> desc user10;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  |     | NULL    |       |
| name  | varchar(20) | NO   |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.01 sec)

mysql> insert into user10 (id) values(1);
ERROR 1364 (HY000): Field 'name' doesn't have a default value'
mysql> insert into user10 values(1,'zhangsan');
Query OK, 1 row affected (0.07 sec)

mysql> insert into user10 (name) values('lisi');
Query OK, 1 row affected (0.02 sec)

mysql> select * from user10;
+------+----------+
| id   | name     |
+------+----------+
|    1 | zhangsan |
| NULL | lisi     |
+------+----------+
2 rows in set (0.01 sec)

-- 默认约束
未传值则使用默认值，传了值就不会使用默认值

mysql> create table user11(
    -> id int,
    -> name varchar(20),
    -> age int default 10);
ERROR 2006 (HY000): MySQL server has gone away
No connection. Trying to reconnect...
Connection id:    12
Current database: test

Query OK, 0 rows affected (0.54 sec)

mysql> desc user11;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  |     | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
| age   | int(11)     | YES  |     | 10      |       |
+-------+-------------+------+-----+---------+-------+
3 rows in set (0.02 sec)

mysql> insert into user11(id,name) values(1,'zhangsan');
Query OK, 1 row affected (0.08 sec)

mysql> select * from user11;
+------+----------+------+
| id   | name     | age  |
+------+----------+------+
|    1 | zhangsan |   10 |
+------+----------+------+
1 row in set (0.01 sec)

mysql> insert into user11 values(1,'zhangsan',19);
Query OK, 1 row affected (0.08 sec)

-- 外键约束
涉及到两个表：父表，子表（主表、副表）

班级表——主表
mysql> create table classes(
    -> id int primary key,
    -> name varchar(20));
Query OK, 0 rows affected (0.16 sec)

学生表——副表
mysql> create table students(
    -> id int primary key,
    -> name varchar(20),
    -> class_id int,
    -> foreign key(class_id) references classes(id));
Query OK, 0 rows affected (0.16 sec)

mysql> desc students;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| id       | int(11)     | NO   | PRI | NULL    |       |
| name     | varchar(20) | YES  |     | NULL    |       |
| class_id | int(11)     | YES  | MUL | NULL    |       |
+----------+-------------+------+-----+---------+-------+
3 rows in set (0.02 sec)

mysql> insert into (name) values (1,'一班');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '(name) values (1,'一班')' at line 1
mysql> insert into classes (name) values (1,'一班');
ERROR 1136 (21S01): Column count doesn't match value count at row 1'
mysql> desc classes;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | NO   | PRI | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.01 sec)

mysql> insert into classes values (1,'一班');
Query OK, 1 row affected (0.03 sec)

mysql> insert into classes values (2,'二班');
Query OK, 1 row affected (0.06 sec)

mysql> insert into classes values (3,'三班');
Query OK, 1 row affected (0.06 sec)

mysql> insert into classes values (4,'四班');
Query OK, 1 row affected (0.07 sec)

mysql> select * from classes;
+----+--------+
| id | name   |
+----+--------+
|  1 | 一班   |
|  2 | 二班   |
|  3 | 三班   |
|  4 | 四班   |
+----+--------+
4 rows in set (0.00 sec)

mysql> insert into students values(1001,'张三',1);
Query OK, 1 row affected (0.11 sec)

mysql> insert into students values(1002,'张三',2);
Query OK, 1 row affected (0.09 sec)

mysql> insert into students values(1003,'张三',3);
Query OK, 1 row affected (0.04 sec)

mysql> insert into students values(1004,'张三',4);
Query OK, 1 row affected (0.09 sec)

mysql> select * from students;
+------+--------+----------+
| id   | name   | class_id |
+------+--------+----------+
| 1001 | 张三   |        1 |
| 1002 | 张三   |        2 |
| 1003 | 张三   |        3 |
| 1004 | 张三   |        4 |
+------+--------+----------+
4 rows in set (0.01 sec)

#主表classes中没有的数据，在副表students中是不能使用的
mysql> insert into students values(1005,'李四',5);
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`test`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`))

#主表中的记录被副表引用，是不可以删除的。
mysql> delete from classes where id=4;
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`test`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`))
