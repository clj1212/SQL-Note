数据库的三大设计范式

第一范式
1NF

数据表中的所有字段都是不可分割的原子值
mysql> create table student2(
    -> id int primary key,
    -> name varchar(20),
    -> address varchar(30)
    -> );
Query OK, 0 rows affected (0.10 sec)

mysql> insert into student2 values(1,'张三','中国四川省成都市武侯区武侯大道100号');
Query OK, 1 row affected (0.07 sec)

mysql> insert into student2 values(2,'李四','中国四川省成都市武侯区京城大道200号');
Query OK, 1 row affected (0.08 sec)

mysql> insert into student2 values(3,'王五','中国四川省成都市高新区天府大道90号');
Query OK, 1 row affected (0.02 sec)


字段值还可以继续拆分，就不满足第一范式

1,'张三','中国','四川省','成都市','武侯区武侯大道100号'
2,'李四','中国','四川省','成都市','武侯区京城大道200号'
3,'王五','中国','四川省','成都市','高新区天府大道90号'

mysql> create table student3(
    -> id int primary key,
    -> name varchar(20),
    -> country varchar(30),
    -> province varchar(30),
    -> city varchar(30),
    -> details varchar(30)
    -> );
Query OK, 0 rows affected (0.10 sec)

mysql> insert into student3 values(1,'张三','中国','四川省','成都市','武侯区武侯大道100号');
Query OK, 1 row affected (0.12 sec)

mysql> insert into student3 values(2,'李四','中国','四川省','成都市','武侯区京城大道200号');
Query OK, 1 row affected (0.06 sec)

mysql>  insert into student3 values(3,'王五','中国','四川省','成都市','高新区天府大道90号');
Query OK, 1 row affected (0.07 sec)

mysql> select * from student3;
+----+--------+---------+-----------+-----------+-----------------------------+
| id | name   | country | province  | city      | details                     |
+----+--------+---------+-----------+-----------+-----------------------------+
|  1 | 张三   | 中国    | 四川省    | 成都市    | 武侯区武侯大道100号         |
|  2 | 李四   | 中国    | 四川省    | 成都市    | 武侯区京城大道200号         |
|  3 | 王五   | 中国    | 四川省    | 成都市    | 高新区天府大道90号          |
+----+--------+---------+-----------+-----------+-----------------------------+
3 rows in set (0.00 sec)

范式，设计的越详细，对于某些实际操作可能更好，但是不一定都是好处。

第二范式
必须是满足第一范式的前提下，第二范式要求，除主键外的每一列都必须完全依赖主键
(完全函数依赖的定义：设X,Y是关系R的两个属性集合，X’是X的真子集，存在X→Y，但对每一个X’都有X’!→Y，则称Y完全函数依赖于X。)
如果要出现不完全依赖，只可能发生在联合主键的情况下。
-- 订单表
mysql> create table myorder(
    -> product_id int,
    -> customer_id int,
    -> product_name varchar(20),
    ->  customer_name varchar(20),
    -> primary key(product_id,customer_id)
    -> );
Query OK, 0 rows affected (0.22 sec)

mysql> desc myorder;
+---------------+-------------+------+-----+---------+-------+
| Field         | Type        | Null | Key | Default | Extra |
+---------------+-------------+------+-----+---------+-------+
| product_id    | int(11)     | NO   | PRI | NULL    |       |
| customer_id   | int(11)     | NO   | PRI | NULL    |       |
| product_name  | varchar(20) | YES  |     | NULL    |       |
| customer_name | varchar(20) | YES  |     | NULL    |       |
+---------------+-------------+------+-----+---------+-------+
4 rows in set (0.21 sec)

除主键以外的其他列，只依赖于主键的部分字段
拆表

mysql> create table myorder1(
    -> order_id int primary key,
    -> product_id int,
    -> customer_id int
    -> );
Query OK, 0 rows affected (0.15 sec)


mysql> create table pruduct(
    -> id int primary key,
    -> name varchar(20)
    -> );
Query OK, 0 rows affected (0.11 sec)

mysql> create table customer(
    -> id int primary key,
    -> name varchar(20)
    -> );
Query OK, 0 rows affected (0.24 sec)

分成三张表之后，就满足了第二范式。

第三范式
3NF
必须先满足第二范式，除开主键列的其他列之间不能有传递依赖关系。
mysql> create table myorder2(
    -> order_id int primary key,
    -> product_id int,
    -> customer_id int
    -> );
Query OK, 0 rows affected (0.21 sec)

mysql> create table customer2(
    -> id int primary key,
    -> name varchar(20),
    -> phone varchar(15)
    -> );
Query OK, 0 rows affected (0.12 sec)


