SQL的四种连接查询

内连接

inner join 或者join

外连接
1.左连接 left join 或者 left outer join
2.右连接 right join 或者 right outer join
3.完全外链接 full join 或者 full outer join

-- 创建两个表
-- person表

create table person(
    id int,
    name varchar(20),
    cardId int
);

-- card表

create table card(
    id int,
    name varchar(20)
)；

insert into card values(1,'饭卡');
insert into card values(2,'建行卡');
insert into card values(3,'农行卡');
insert into card values(4,'工商卡');
insert into card values(5,'邮政卡');

insert into person values(1,'张三',1);
insert into person values(2,'李四',3);
insert into person values(3,'王五',6);

mysql> select * from card;
+------+-----------+
| id   | name      |
+------+-----------+
|    1 | 饭卡      |
|    2 | 建行卡    |
|    3 | 农行卡    |
|    4 | 工商卡    |
|    5 | 邮政卡    |
+------+-----------+
5 rows in set (0.01 sec)

mysql> select * from person;
+------+--------+--------+
| id   | name   | cardId |
+------+--------+--------+
|    1 | 张三   |      1 |
|    2 | 李四   |      3 |
|    3 | 王五   |      6 |
+------+--------+--------+
3 rows in set (0.00 sec)

并没有创建外键 （王五的cardId 在card表中没有体现）

-- 1. inner join 查询
select * from person inner join card on person.cardId = card.id;

mysql> select * from person inner join card on person.cardId = card.id;
+------+--------+--------+------+-----------+
| id   | name   | cardId | id   | name      |
+------+--------+--------+------+-----------+
|    1 | 张三   |      1 |    1 | 饭卡      |
|    2 | 李四   |      3 |    3 | 农行卡    |
+------+--------+--------+------+-----------+
2 rows in set (0.02 sec)


-- 内联查询，其实就是两张表中的数据，通过某个字段相等，查询出相关记录数据
select * from person join card on person.cardId = card.id;

mysql> select * from person join card on person.cardId = card.id;
+------+--------+--------+------+-----------+
| id   | name   | cardId | id   | name      |
+------+--------+--------+------+-----------+
|    1 | 张三   |      1 |    1 | 饭卡      |
|    2 | 李四   |      3 |    3 | 农行卡    |
+------+--------+--------+------+-----------+
2 rows in set (0.00 sec)

-- 2. left join(左外连接)

select * from person left join card on person.cardId = card.id;

mysql> select * from person left join card on person.cardId = card.id;
+------+--------+--------+------+-----------+
| id   | name   | cardId | id   | name      |
+------+--------+--------+------+-----------+
|    1 | 张三   |      1 |    1 | 饭卡      |
|    2 | 李四   |      3 |    3 | 农行卡    |
|    3 | 王五   |      6 | NULL | NULL      |
+------+--------+--------+------+-----------+
3 rows in set (0.13 sec)

-- 左外连接，会把左边表里面的所有数据取出来，而右边表中的数据，如果有相等的，就显示出来
-- 若果没有，就会补NULL

mysql> select * from person left outer join card on person.cardId = card.id;
+------+--------+--------+------+-----------+
| id   | name   | cardId | id   | name      |
+------+--------+--------+------+-----------+
|    1 | 张三   |      1 |    1 | 饭卡      |
|    2 | 李四   |      3 |    3 | 农行卡    |
|    3 | 王五   |      6 | NULL | NULL      |
+------+--------+--------+------+-----------+
3 rows in set (0.00 sec)

3.right join(右连接)

select * from person right join card on person.cardId = card.id;

mysql> select * from person right join card on person.cardId = card.id;;
+------+--------+--------+------+-----------+
| id   | name   | cardId | id   | name      |
+------+--------+--------+------+-----------+
|    1 | 张三   |      1 |    1 | 饭卡      |
|    2 | 李四   |      3 |    3 | 农行卡    |
| NULL | NULL   |   NULL |    2 | 建行卡    |
| NULL | NULL   |   NULL |    4 | 工商卡    |
| NULL | NULL   |   NULL |    5 | 邮政卡    |
+------+--------+--------+------+-----------+
5 rows in set (0.02 sec)

-- 右外连接，会把右边表里面的所有数据取出来，而左边表中的数据，如果有相等的，就显示出来
-- 若果没有，就会补NULL

mysql> select * from person right outer join card on person.cardId = card.id;
+------+--------+--------+------+-----------+
| id   | name   | cardId | id   | name      |
+------+--------+--------+------+-----------+
|    1 | 张三   |      1 |    1 | 饭卡      |
|    2 | 李四   |      3 |    3 | 农行卡    |
| NULL | NULL   |   NULL |    2 | 建行卡    |
| NULL | NULL   |   NULL |    4 | 工商卡    |
| NULL | NULL   |   NULL |    5 | 邮政卡    |
+------+--------+--------+------+-----------+
5 rows in set (0.01 sec)

4. full join(全外连接)

select * from person full join card on person.cardId=card.id;
mysql> select * from person full join card on person.cardId=card.id;
ERROR 1054 (42S22): Unknown column 'person.cardId' in 'on clause'

-- mysql 不支持 full join
-- 等同于

select * from person left join card on person.cardId = card.id
union
select * from person right join card on person.cardId = card.id;

mysql> select * from person left join card on person.cardId = card.id
    -> union
    -> select * from person right join card on person.cardId = card.id;
+------+--------+--------+------+-----------+
| id   | name   | cardId | id   | name      |
+------+--------+--------+------+-----------+
|    1 | 张三   |      1 |    1 | 饭卡      |
|    2 | 李四   |      3 |    3 | 农行卡    |
|    3 | 王五   |      6 | NULL | NULL      |
| NULL | NULL   |   NULL |    2 | 建行卡    |
| NULL | NULL   |   NULL |    4 | 工商卡    |
| NULL | NULL   |   NULL |    5 | 邮政卡    |
+------+--------+--------+------+-----------+
6 rows in set (0.12 sec)
