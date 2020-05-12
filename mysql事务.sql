-- mysql事务

mysql中，事务其实是一个最小的不可分割的工作单位，事务能够保证一个业务的完整性。

比如我们银行转账：

a -> -100
update user set money = money-100 where name='a';

b -> +100
update user set money = money+100 where name='b';

-- 实际的程序中，如果只有一条语句执行成功了，而另外一条没有执行成功？
-- 出现数据前后不一致

多条sql语句，可能会有同时成功的要求，要么同时失败

mysql中如何控制事务
1.mysql默认是开启事务的(自动提交)

mysql> select @@autocommit;
+--------------+
| @@autocommit |
+--------------+
|            1 |
+--------------+
1 row in set (0.08 sec)

默认事务开启的作用是什么？
当我们去执行一个sql语句的时候，效果会立即体现出来，且不能回滚。

mysql> create database bank;
Query OK, 1 row affected (0.39 sec)

mysql> use bank;
Database changed
mysql> create table user(
    -> id int primary key,
    -> name varchar(20),
    -> money int
    -> );
Query OK, 0 rows affected (0.50 sec)

mysql> insert into user values(1,'a',1000);
Query OK, 1 row affected (0.10 sec)

mysql> rollback;
Query OK, 0 rows affected (0.01 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
+----+------+-------+

设置mysql自动提交为false

mysql> set autocommit=0;
Query OK, 0 rows affected (0.03 sec)

mysql> select @@autocommit;
+--------------+
| @@autocommit |
+--------------+
|            0 |
+--------------+
1 row in set (0.00 sec)

--上面的操作，关闭了mysql的自动提交（commit）

mysql> insert into user values(2,'b',1000)
    -> ;
Query OK, 1 row affected (0.01 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
|  2 | b    |  1000 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.02 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
+----+------+-------+
1 row in set (0.01 sec)


-- 再一次插入数据
mysql> insert into user values(2,'b',1000);
Query OK, 1 row affected (0.02 sec)

-- 手动提交数据
mysql> commit;
Query OK, 0 rows affected (0.02 sec)

-- 再撤销，是不可以撤销的（持久性）
mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
|  2 | b    |  1000 |
+----+------+-------+
2 rows in set (0.00 sec)

-- 自动提交 @@autocommit=1
-- 手动提交 commit; 
-- 事务回滚 rollback;

-- 自动提交和手动提交 一旦提交，就不能撤销


mysql> select @@autocommit;
+--------------+
| @@autocommit |
+--------------+
|            0 |
+--------------+
1 row in set (0.06 sec)

开启自动提交——则不能rollback
mysql> set autocommit=1;
Query OK, 0 rows affected (0.04 sec)

mysql> update user set money = money-100 where name='a';
Query OK, 1 row affected (0.17 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money = money+100 where name='b';
Query OK, 1 row affected (0.06 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
2 rows in set (0.01 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
2 rows in set (0.00 sec)


关闭自动提交——可rollback，但commit（手动提交）后，不可rollback
mysql> set autocommit=0;
Query OK, 0 rows affected (0.02 sec)

mysql> update user set money = money-100 where name='a';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money = money+100 where name='b';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
+----+------+-------+
2 rows in set (0.01 sec)

mysql> rollback;
Query OK, 0 rows affected (0.10 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> commit;
Query OK, 0 rows affected (0.01 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)


mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> update user set money = money-100 where name='a';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money = money+100 where name='b';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> commit;
Query OK, 0 rows affected (0.02 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
+----+------+-------+
2 rows in set (0.00 sec)

-- 事务提供了一个返回的机会


mysql> set autocommit = 1;
Query OK, 0 rows affected (0.01 sec)

begin; 
或者
start transaction;
都可以帮我们手动开启一个事务

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> update user set money = money-100 where name='a';
Query OK, 1 row affected (0.08 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money = money+100 where name='b';
Query OK, 1 row affected (0.05 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   700 |
|  2 | b    |  1300 |
+----+------+-------+
2 rows in set (0.00 sec)

-- 事务回滚
mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

-- 没有被撤销
mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   700 |
|  2 | b    |  1300 |
+----+------+-------+
2 rows in set (0.00 sec)


手动开启事务（1）

mysql> begin;
Query OK, 0 rows affected (0.00 sec)

mysql> update user set money = money-100 where name='a';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money = money+100 where name='b';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   600 |
|  2 | b    |  1400 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.02 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   700 |
|  2 | b    |  1300 |
+----+------+-------+
2 rows in set (0.01 sec)


手动开启事务（2）
事务开启之后，一旦commit提交，就不可以回滚
（也就是当前的这个事务在提交的时候就结束了）

mysql> start transaction;
Query OK, 0 rows affected (0.01 sec)

mysql> update user set money = money-100 where name='a';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money = money+100 where name='b';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   600 |
|  2 | b    |  1400 |
+----+------+-------+
2 rows in set (0.01 sec)

mysql> rollback;
Query OK, 0 rows affected (0.04 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   700 |
|  2 | b    |  1300 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> update user set money = money-100 where name='a';
Query OK, 1 row affected (0.04 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money = money+100 where name='b';
Query OK, 1 row affected (0.09 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   600 |
|  2 | b    |  1400 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> commit;
Query OK, 0 rows affected (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   600 |
|  2 | b    |  1400 |
+----+------+-------+
2 rows in set (0.00 sec)


事物的四大特征：ACID
A 原子性：事务是最小的单位，不可以再分割
C 一致性；事务要求，同一事务中的sql语句，必须保证同时成功或者同时失败
I 隔离性：事务1和事务2之间具有隔离性
D 持久性：事务一旦结束（commit,rollback)，就不可以返回

事务开启：
1.修改默认提交 set autocommit=0;
2.begin;
3.start transaction;

事务手动提交：
commit;

事务手动回滚
rollback;


-- 事务的隔离性

1.read uncommitted;  读未提交的
2.read committed;    读已提交的
3.repeatable read;   可以重复读
4.serializable;      串行化

1-read uncommitted
如果有事务a和事务b
a事务对数据进行操作，在操作的过程中，事务没有被提交

bank数据库 user表
insert into user values(3,'小明',1000);
insert into user values(4,'淘宝店',1000);

-- 查看数据库的隔离级别

mysql 8.0:
-- 系统级别的
select @@global.transaction_isolation;
-- 会话级别的
select @@transaction_isolation;


mysql默认隔离级别 REPEATABLE-READ             

mysql> select @@global.transaction_isolation;
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| REPEATABLE-READ                |
+--------------------------------+
1 row in set (0.02 sec)

mysql 5.x;
select @@global.tx_isolation;
select @@tx_isolation;

-- 如何修改隔离级别？

set global transaction isolation level read uncommitted;

mysql> set global transaction isolation level read uncommitted;
Query OK, 0 rows affected (0.00 sec)

mysql> select @@global.transaction_isolation;
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| READ-UNCOMMITTED               |
+--------------------------------+
1 row in set (0.00 sec)

--转账；小明在淘宝店买鞋子：800块钱
小明 -》成都 ATM 
淘宝店 -》广州 ATM 

start transaction;
update user set money = money-800 where name='小明';
update user set money = money+800 where name='淘宝店';

mysql> start transaction;
Query OK, 0 rows affected (0.07 sec)

mysql> update user set money = money-800 where name='小明';
Query OK, 1 row affected (0.08 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money = money+800 where name='淘宝店';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   600 |
|  2 | b         |  1400 |
|  3 | 小明      |   200 |
|  4 | 淘宝店    |  1800 |
+----+-----------+-------+
4 rows in set (0.02 sec)

-- 给淘宝店打电话，说你去查一下，是不是到账了

-- 淘宝店在广州查账
mysql> select * from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   600 |
|  2 | b         |  1400 |
|  3 | 小明      |   200 |
|  4 | 淘宝店    |  1800 |
+----+-----------+-------+
4 rows in set (0.02 sec)

--发货

--小明
mysql> rollback;
Query OK, 0 rows affected (0.07 sec)

mysql> select * from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   600 |
|  2 | b         |  1400 |
|  3 | 小明      |  1000 |
|  4 | 淘宝店    |  1000 |
+----+-----------+-------+
4 rows in set (0.00 sec)

-- 淘宝店发现钱不够，查账

mysql> select * from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   600 |
|  2 | b         |  1400 |
|  3 | 小明      |  1000 |
|  4 | 淘宝店    |  1000 |
+----+-----------+-------+
4 rows in set (0.00 sec)

-- 如果两个不同的地方，都在进行操作，如果事务a开启之后，他的数据可以被其他事务读取到。
-- 这样就会出现（脏读）
-- 脏读：一个事务读到了另外一个事务没有提交的数据，就叫做脏读。
-- 实际开发是不允许脏读出现的。


2、read committed;    读已经提交的

set global transaction isolation level read committed;


mysql> set global transaction isolation level read committed;
Query OK, 0 rows affected (0.01 sec)

mysql> select @@global.transaction_isolation;
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| READ-COMMITTED                 |
+--------------------------------+
1 row in set (0.02 sec)


bank 数据库 user 表

小张：银行的会计

start transaction;
select * from user;

mysql> start transaction;
Query OK, 0 rows affected (0.00 sec)

mysql> select * from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   600 |
|  2 | b         |  1400 |
|  3 | 小明      |  1000 |
|  4 | 淘宝店    |  1000 |
+----+-----------+-------+
4 rows in set (0.01 sec)

小王：
start transaction;
insert into user values(5,'c',100);
commit;

mysql> use bank;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> start transaction;
Query OK, 0 rows affected (0.00 sec)

mysql> insert into user values(5,'c',100);
Query OK, 1 row affected (0.01 sec)

mysql> commit;
Query OK, 0 rows affected (0.06 sec)

mysql> select * from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   600 |
|  2 | b         |  1400 |
|  3 | 小明      |  1000 |
|  4 | 淘宝店    |  1000 |
|  5 | c         |   100 |
+----+-----------+-------+
5 rows in set (0.01 sec)


-- 小张回来


mysql> select avg(money) from user;
+------------+
| avg(money) |
+------------+
|   820.0000 |
+------------+
1 row in set (0.00 sec)


-- money 平均值不是1000，变少了
-- 虽然我只能读到另外一个事务提交的数据，但还是会出现问题，就是
-- 读取同一个表的数据，发现前后不一致
-- 这种现象叫不可重复读现象；read committed

3、repeatable read;  可以重复读

mysql> set global transaction isolation level repeatable read;
Query OK, 0 rows affected (0.02 sec)

mysql> select @@global.transaction_isolation;
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| REPEATABLE-READ                |
+--------------------------------+
1 row in set (0.01 sec)

mysql> select * from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   600 |
|  2 | b         |  1400 |
|  3 | 小明      |  1000 |
|  4 | 淘宝店    |  1000 |
|  5 | c         |   100 |
+----+-----------+-------+
5 rows in set (0.00 sec)

-- 张全蛋-成都
start transaction;
insert into user

-- 王尼玛-北京
start transaction;

mysql> insert into user values(6,'d',1000);
Query OK, 1 row affected (0.03 sec)

mysql> commit;
Query OK, 0 rows affected (0.07 sec)

mysql> select * from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   600 |
|  2 | b         |  1400 |
|  3 | 小明      |  1000 |
|  4 | 淘宝店    |  1000 |
|  5 | c         |   100 |
|  6 | d         |  1000 |
+----+-----------+-------+
6 rows in set (0.00 sec)

-- 张全蛋-成都

mysql> select * from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   600 |
|  2 | b         |  1400 |
|  3 | 小明      |  1000 |
|  4 | 淘宝店    |  1000 |
|  5 | c         |   100 |
+----+-----------+-------+
5 rows in set (0.00 sec)

mysql>  insert into user values(6,'d',1000);
ERROR 1062 (23000): Duplicate entry '6' for key 'PRIMARY'

-- 这种现象就叫做幻读
-- 事务a和事务b同时操作一张表，事务a提交的数据，也不能被事务b读到，就可以造成幻读


4、serializable;    串行化

mysql> set global transaction isolation level serializable;
Query OK, 0 rows affected (0.01 sec)

mysql> select @@global.transaction_isolation;
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| SERIALIZABLE                   |
+--------------------------------+
1 row in set (0.01 sec)


-- 张全蛋-成都
start transaction;

-- 王尼玛-北京
start transaction;

-- 张全蛋-成都
insert into user values(8,'赵铁柱',1000);

mysql> start transaction;
Query OK, 0 rows affected (0.01 sec)

mysql> insert into user values(8,'赵铁柱',1000);
Query OK, 1 row affected (0.01 sec)

mysql> commit;
Query OK, 0 rows affected (0.04 sec)

mysql> select * from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   600 |
|  2 | b         |  1400 |
|  3 | 小明      |  1000 |
|  4 | 淘宝店    |  1000 |
|  5 | c         |   100 |
|  6 | d         |  1000 |
|  7 | e         |   100 |
|  8 | 赵铁柱    |  1000 |
+----+-----------+-------+
8 rows in set (0.00 sec)

-- 王尼玛

mysql> select * from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   600 |
|  2 | b         |  1400 |
|  3 | 小明      |  1000 |
|  4 | 淘宝店    |  1000 |
|  5 | c         |   100 |
|  6 | d         |  1000 |
|  7 | e         |   100 |
|  8 | 赵铁柱    |  1000 |
+----+-----------+-------+
8 rows in set (0.00 sec)


--张全蛋-成都

start transation;
insert into user values(11,'g',1000);

-- sql语句被卡住了
mysql> insert into user values(11,'g',1000);

-- 当user表被另外一个事务操作的时候，其他事务里面的写操作，是不可以进行的
-- 进入排队状态（串行化），直到王尼玛那边事务结束之后，张全蛋这个的写入操作才会执行
-- 在没有等待超时的情况下

-- 王尼玛-北京
mysql> commit;

-- 张全蛋-成都
成功写入

--串行化问题是，性能特差

-- 隔离级别越高，性能越差
-- mysql默认隔离级别 REPEATABLE-READ