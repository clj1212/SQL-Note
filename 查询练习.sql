学生表
create table student(
    sno varchar(20) primary key,
    sname varchar(20) not null,
    ssex varchar(10) not null,
    sbirthday datetime,
    class varchar(20)
);


教师表
create table teacher(
    tno varchar(20) primary key,
    tname varchar(20) not null,
    tsex varchar(10) not null,
    tbirthday datetime,
    prof varchar(20) not null,
    depart varchar(20) not null
);

课程表
create table course(
cno varchar(20) primary key,
cname varchar(20) not null,
tno varchar(20) not null,
foreign key(tno) references teacher(tno)
);

成绩表
create table score(
    sno varchar(20) not null,
    cno varchar(20) not null,
    degree decimal,
    foreign key(sno) references student(sno),
    foreign key(cno) references course(cno),
    primary key(sno,cno)
);

添加学生信息表
insert into student values('101','曾华','男','1977-09-01','95033');
insert into student values('102','匡明','男','1975-10-02','95031');
insert into student values('103','王丽','女','1976-01-23','95033');
insert into student values('104','李军','男','1976-02-20','95033');
insert into student values('105','王芳','女','1975-02-10','95031');
insert into student values('106','陆君','男','1974-06-03','95031');
insert into student values('107','王尼玛','男','1976-02-20','95033');
insert into student values('108','张全蛋','男','1975-02-10','95031');
insert into student values('109','赵铁柱','男','1974-06-03','95031');

添加教师表
insert into teacher values('804','李诚','男','1958-12-02','副教授','计算机系');
insert into teacher values('856','张旭','男','1969-03-12','讲师','电子工程系');
insert into teacher values('825','王萍','女','1972-05-05','助教','计算机系');
insert into teacher values('831','刘冰','女','1977-08-14','助教','电子工程系');

添加课程表
insert into course values('3-105','计算机导论','825');
insert into course values('3-245','操作系统','804');
insert into course values('6-166','数字电路','856');
insert into course values('9-888','高等数学','831');

添加成绩表
insert into score values('103','3-245','86');
insert into score values('105','3-245','75');
insert into score values('109','3-245','68');
insert into score values('103','3-105','92');
insert into score values('105','3-105','88');
insert into score values('109','3-105','76');
insert into score values('103','6-166','85');
insert into score values('105','6-166','79');
insert into score values('109','6-166','81');

1.查询student表中的所有记录
mysql> select * from student;
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 101 | 曾华      | 男   | 1977-09-01 00:00:00 | 95033 |
| 102 | 匡明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 103 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 104 | 李军      | 男   | 1976-02-20 00:00:00 | 95033 |
| 105 | 王芳      | 女   | 1975-02-10 00:00:00 | 95031 |
| 106 | 陆君      | 男   | 1974-06-03 00:00:00 | 95031 |
| 107 | 王尼玛    | 男   | 1976-02-20 00:00:00 | 95033 |
| 108 | 张全蛋    | 男   | 1975-02-10 00:00:00 | 95031 |
| 109 | 赵铁柱    | 男   | 1974-06-03 00:00:00 | 95031 |
+-----+-----------+------+---------------------+-------+
9 rows in set (0.03 sec)

2.查询student表中的所有记录的sname、ssex和clas列

mysql> select sname, ssex,class from student;
+-----------+------+-------+
| sname     | ssex | class |
+-----------+------+-------+
| 曾华      | 男   | 95033 |
| 匡明      | 男   | 95031 |
| 王丽      | 女   | 95033 |
| 李军      | 男   | 95033 |
| 王芳      | 女   | 95031 |
| 陆君      | 男   | 95031 |
| 王尼玛    | 男   | 95033 |
| 张全蛋    | 男   | 95031 |
| 赵铁柱    | 男   | 95031 |
+-----------+------+-------+
9 rows in set (0.08 sec)

3.查询教师所有的单位即不重复的depart列
-- distinct 排出重复

mysql> select distinct depart from teacher;
+-----------------+
| depart          |
+-----------------+
| 计算机系        |
| 电子工程系      |
+-----------------+
2 rows in set (0.03 sec)

4.查询score表中成绩在60到80之间的所有记录
-- 查询区间

mysql> select * from score where degree between 60 and 80;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 105 | 3-245 |     75 |
| 105 | 6-166 |     79 |
| 109 | 3-105 |     76 |
| 109 | 3-245 |     68 |
+-----+-------+--------+
4 rows in set (0.02 sec)

-- 直接使用运算符比较
mysql> select * from score where degree > 60 and degree <80;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 105 | 3-245 |     75 |
| 105 | 6-166 |     79 |
| 109 | 3-105 |     76 |
| 109 | 3-245 |     68 |
+-----+-------+--------+


5.查询score表中成绩为85，86或88的记录
-- 表示或者关系的查询 in

mysql> select * from score where degree in(85,86,88);
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 103 | 3-245 |     86 |
| 103 | 6-166 |     85 |
| 105 | 3-105 |     88 |
+-----+-------+--------+
3 rows in set (0.01 sec)

6.查询student表中”95031“班或性别为”女“的同学记录
mysql>  select * from student where class='95031' or ssex='女';
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 102 | 匡明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 103 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 105 | 王芳      | 女   | 1975-02-10 00:00:00 | 95031 |
| 106 | 陆君      | 男   | 1974-06-03 00:00:00 | 95031 |
| 108 | 张全蛋    | 男   | 1975-02-10 00:00:00 | 95031 |
| 109 | 赵铁柱    | 男   | 1974-06-03 00:00:00 | 95031 |
+-----+-----------+------+---------------------+-------+
6 rows in set (0.02 sec)

7.以class降序查询student表中的所有记录。
-- 升序、降序
-- desc是降序，asc是升序
mysql> select * from student order by class desc;
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 101 | 曾华      | 男   | 1977-09-01 00:00:00 | 95033 |
| 103 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 104 | 李军      | 男   | 1976-02-20 00:00:00 | 95033 |
| 107 | 王尼玛    | 男   | 1976-02-20 00:00:00 | 95033 |
| 102 | 匡明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 105 | 王芳      | 女   | 1975-02-10 00:00:00 | 95031 |
| 106 | 陆君      | 男   | 1974-06-03 00:00:00 | 95031 |
| 108 | 张全蛋    | 男   | 1975-02-10 00:00:00 | 95031 |
| 109 | 赵铁柱    | 男   | 1974-06-03 00:00:00 | 95031 |
+-----+-----------+------+---------------------+-------+
9 rows in set (0.03 sec)

mysql>  select * from student order by class asc;
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 102 | 匡明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 105 | 王芳      | 女   | 1975-02-10 00:00:00 | 95031 |
| 106 | 陆君      | 男   | 1974-06-03 00:00:00 | 95031 |
| 108 | 张全蛋    | 男   | 1975-02-10 00:00:00 | 95031 |
| 109 | 赵铁柱    | 男   | 1974-06-03 00:00:00 | 95031 |
| 101 | 曾华      | 男   | 1977-09-01 00:00:00 | 95033 |
| 103 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 104 | 李军      | 男   | 1976-02-20 00:00:00 | 95033 |
| 107 | 王尼玛    | 男   | 1976-02-20 00:00:00 | 95033 |
+-----+-----------+------+---------------------+-------+
9 rows in set (0.00 sec)

8.以cno升序，degree降序查询score表的所有记录

mysql> select * from score order by cno asc, degree desc;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 103 | 3-105 |     92 |
| 105 | 3-105 |     88 |
| 109 | 3-105 |     76 |
| 103 | 3-245 |     86 |
| 105 | 3-245 |     75 |
| 109 | 3-245 |     68 |
| 103 | 6-166 |     85 |
| 109 | 6-166 |     81 |
| 105 | 6-166 |     79 |
+-----+-------+--------+
9 rows in set (0.02 sec)

9.查询”95031“班的学生人数
-- 统计 count

mysql> select count(*) from student where class = '95031';
+----------+
| count(*) |
+----------+
|        5 |
+----------+
1 row in set (0.02 sec)

10.查询score表中的最高分的学生学号和课程号。（子查询或者排序）
mysql> select max(degree) from score;
+-------------+
| max(degree) |
+-------------+
|          92 |
+-------------+
1 row in set (0.00 sec)

-- 子查询做法
下述步骤属于子查询
mysql> select sno,cno from score where degree = (select max(degree) from score);
+-----+-------+
| sno | cno   |
+-----+-------+
| 103 | 3-105 |
+-----+-------+
1 row in set (0.05 sec)


-- 排序做法

mysql> select sno,cno,degree from score order by degree desc;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 103 | 3-105 |     92 |
| 105 | 3-105 |     88 |
| 103 | 3-245 |     86 |
| 103 | 6-166 |     85 |
| 109 | 6-166 |     81 |
| 105 | 6-166 |     79 |
| 109 | 3-105 |     76 |
| 105 | 3-245 |     75 |
| 109 | 3-245 |     68 |
+-----+-------+--------+
9 rows in set (0.01 sec)

mysql> select sno,cno,degree from score order by degree desc limit 0,1;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 103 | 3-105 |     92 |
+-----+-------+--------+
1 row in set (0.01 sec)

select * from table limit m,n
其中m是指记录开始的index，从0开始，表示第一条记录
n是指从第m+1条开始，取n条。
select * from tablename limit 2,4
即取出第3条至第6条，4条记录


11.查询每门课的平均成绩
-- avg()
mysql> select avg(degree) from score where cno='3-105';
+-------------+
| avg(degree) |
+-------------+
|     85.3333 |
+-------------+
1 row in set (0.06 sec)

在一个sql语句中把所有门课的平均分算出来
-- group by

mysql> select avg(degree) from score group by cno;
+-------------+
| avg(degree) |
+-------------+
|     85.3333 |
|     76.3333 |
|     81.6667 |
+-------------+
3 rows in set (0.01 sec)

mysql> select cno,avg(degree) from score group by cno;
+-------+-------------+
| cno   | avg(degree) |
+-------+-------------+
| 3-105 |     85.3333 |
| 3-245 |     76.3333 |
| 6-166 |     81.6667 |
+-------+-------------+
3 rows in set (0.02 sec)

12.查询score表中至少有2名学生选修的并以3开头的课程的平均分数
select cno from score group by cno 
having count(cno)>=2 and cno like '3%';

mysql> select cno from score group by cno 
    -> having count(cno)>=2 and cno like '3%';
+-------+
| cno   |
+-------+
| 3-105 |
| 3-245 |
+-------+
2 rows in set (0.01 sec)

可应用限定条件进行分组，以便系统仅对满足条件的组返回结果。
因此，在GROUP BY子句后面包含了一个HAVING子句。
HAVING类似于WHERE（唯一的差别是WHERE过滤行，HAVING过滤组）AVING支持所有WHERE操作符。

13.查询分数大于70，小于90的sno列

-- where degree>70 and degree<90

mysql> select sno,degree  from score where degree>70 and degree<90;
+-----+--------+
| sno | degree |
+-----+--------+
| 103 |     86 |
| 103 |     85 |
| 105 |     88 |
| 105 |     75 |
| 105 |     79 |
| 109 |     76 |
| 109 |     81 |
+-----+--------+
7 rows in set (0.00 sec)

-- where degree between 70 and 90

mysql> select sno,degree  from score where degree between 70 and 90;
+-----+--------+
| sno | degree |
+-----+--------+
| 103 |     86 |
| 103 |     85 |
| 105 |     88 |
| 105 |     75 |
| 105 |     79 |
| 109 |     76 |
| 109 |     81 |
+-----+--------+
7 rows in set (0.01 sec)


14.查询所有学生的sname,cno和degree列

--多表查询

mysql> select sname,cno,degree from student,score
    -> where student.sno =score.sno;
+-----------+-------+--------+
| sname     | cno   | degree |
+-----------+-------+--------+
| 王丽      | 3-105 |     92 |
| 王丽      | 3-245 |     86 |
| 王丽      | 6-166 |     85 |
| 王芳      | 3-105 |     88 |
| 王芳      | 3-245 |     75 |
| 王芳      | 6-166 |     79 |
| 赵铁柱    | 3-105 |     76 |
| 赵铁柱    | 3-245 |     68 |
| 赵铁柱    | 6-166 |     81 |
+-----------+-------+--------+
9 rows in set (0.02 sec)


15.查询所有学生的sno、cname和degree列

mysql> select cno,cname from course;
+-------+-----------------+
| cno   | cname           |
+-------+-----------------+
| 3-105 | 计算机导论      |
| 3-245 | 操作系统        |
| 6-166 | 数字电路        |
| 9-888 | 高等数学        |
+-------+-----------------+
4 rows in set (0.02 sec)

mysql> select cno,sno,degree from score;
+-------+-----+--------+
| cno   | sno | degree |
+-------+-----+--------+
| 3-105 | 103 |     92 |
| 3-245 | 103 |     86 |
| 6-166 | 103 |     85 |
| 3-105 | 105 |     88 |
| 3-245 | 105 |     75 |
| 6-166 | 105 |     79 |
| 3-105 | 109 |     76 |
| 3-245 | 109 |     68 |
| 6-166 | 109 |     81 |
+-------+-----+--------+
9 rows in set (0.01 sec)

mysql> select sno,cname,degree from course,score
    -> where course.cno=score.cno;
+-----+-----------------+--------+
| sno | cname           | degree |
+-----+-----------------+--------+
| 103 | 计算机导论      |     92 |
| 105 | 计算机导论      |     88 |
| 109 | 计算机导论      |     76 |
| 103 | 操作系统        |     86 |
| 105 | 操作系统        |     75 |
| 109 | 操作系统        |     68 |
| 103 | 数字电路        |     85 |
| 105 | 数字电路        |     79 |
| 109 | 数字电路        |     81 |
+-----+-----------------+--------+
9 rows in set (0.03 sec)



16.查询所有学生的sname、cname和degree列
-- 三表关联查询

-- sname -> student
-- cname -> course
-- degree -> score

mysql> select sname,cname,degree from student,course,score
    -> where student.sno=score.sno and course.cno=score.cno;
+-----------+-----------------+--------+
| sname     | cname           | degree |
+-----------+-----------------+--------+
| 王丽      | 计算机导论      |     92 |
| 王丽      | 操作系统        |     86 |
| 王丽      | 数字电路        |     85 |
| 王芳      | 计算机导论      |     88 |
| 王芳      | 操作系统        |     75 |
| 王芳      | 数字电路        |     79 |
| 赵铁柱    | 计算机导论      |     76 |
| 赵铁柱    | 操作系统        |     68 |
| 赵铁柱    | 数字电路        |     81 |
+-----------+-----------------+--------+
9 rows in set (0.03 sec)

-- 若想显示课程号、学号，则在select后面加上student.sno, course.cno。
若没有student.和course.的话，会报错，因为多个表格中都含有这两个变量，需要限定到某一张表格。

17.查询"95031"班学生每门课的平均分
-- 子查询 + 分组

mysql> select * from student where class='95031';
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 102 | 匡明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 105 | 王芳      | 女   | 1975-02-10 00:00:00 | 95031 |
| 106 | 陆君      | 男   | 1974-06-03 00:00:00 | 95031 |
| 108 | 张全蛋    | 男   | 1975-02-10 00:00:00 | 95031 |
| 109 | 赵铁柱    | 男   | 1974-06-03 00:00:00 | 95031 |
+-----+-----------+------+---------------------+-------+
5 rows in set (0.03 sec)

mysql> select * from score;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 103 | 3-105 |     92 |
| 103 | 3-245 |     86 |
| 103 | 6-166 |     85 |
| 105 | 3-105 |     88 |
| 105 | 3-245 |     75 |
| 105 | 6-166 |     79 |
| 109 | 3-105 |     76 |
| 109 | 3-245 |     68 |
| 109 | 6-166 |     81 |
+-----+-------+--------+
9 rows in set (0.01 sec)

mysql> select * from score where sno in (select sno from student where class='95031');
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 105 | 3-105 |     88 |
| 105 | 3-245 |     75 |
| 105 | 6-166 |     79 |
| 109 | 3-105 |     76 |
| 109 | 3-245 |     68 |
| 109 | 6-166 |     81 |
+-----+-------+--------+
6 rows in set (0.02 sec)

select avg(degree),cno from score where sno in (select sno from student where class='95031') group by cno；
mysql> select avg(degree),cno from score where sno in (select sno from student where class='95031') group by cno;
+-------------+-------+
| avg(degree) | cno   |
+-------------+-------+
|     82.0000 | 3-105 |
|     71.5000 | 3-245 |
|     80.0000 | 6-166 |
+-------------+-------+
3 rows in set (0.06 sec)


18.查询选修”3-105“课程的成绩高于“109”号同学“3-105”成绩的所有同学的记录
-- 子查询

select * from score where degree > (select degree from score where sno = '109' and cno = '3-105');
mysql> select * from score where cno = '3-105' and degree > (select degree from score where sno = '109' and cno = '3-105');
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 103 | 3-105 |     92 |
| 105 | 3-105 |     88 |
+-----+-------+--------+
2 rows in set (0.05 sec)

19.查询成绩高于学号为“109”、课程号为“3-105”成绩的所有记录

mysql> select * from score where  degree > (select degree from score where sno = '109' and cno = '3-105');
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 103 | 3-105 |     92 |
| 103 | 3-245 |     86 |
| 103 | 6-166 |     85 |
| 105 | 3-105 |     88 |
| 105 | 6-166 |     79 |
| 109 | 6-166 |     81 |
+-----+-------+--------+
6 rows in set (0.01 sec)

20.查询和学号为108、101的同学同年出生的所有学生的sno、sname和sbirthday列
select * from student where sno in (108,101);
mysql> select * from student where sno in (108,101);
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 101 | 曾华      | 男   | 1977-09-01 00:00:00 | 95033 |
| 108 | 张全蛋    | 男   | 1975-02-10 00:00:00 | 95031 |
+-----+-----------+------+---------------------+-------+
2 rows in set (0.11 sec)

select year(sbirthday) from student where sno in(108,101);

-- year()函数表示取date中的年份

mysql> select year(sbirthday) from student where sno in(108,101);
+-----------------+
| year(sbirthday) |
+-----------------+
|            1977 |
|            1975 |
+-----------------+
2 rows in set (0.04 sec)


select sno,sname,sbirthday from student where year(sbirthday) in (1977,1975);
mysql> select sno,sname,sbirthday from student where year(sbirthday) in (1977,1975);
+-----+-----------+---------------------+
| sno | sname     | sbirthday           |
+-----+-----------+---------------------+
| 101 | 曾华      | 1977-09-01 00:00:00 |
| 102 | 匡明      | 1975-10-02 00:00:00 |
| 105 | 王芳      | 1975-02-10 00:00:00 |
| 108 | 张全蛋    | 1975-02-10 00:00:00 |
+-----+-----------+---------------------+
4 rows in set (0.01 sec)

21.查询“张旭”教室任课的学生成绩。
select * from score where cno = (select cno from course where tno = (select tno from teacher where tname="张旭"));

mysql> select * from score where cno = 
(select cno from course where tno = 
(select tno from teacher where tname="张旭")
);
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 103 | 6-166 |     85 |
| 105 | 6-166 |     79 |
| 109 | 6-166 |     81 |
+-----+-------+--------+
3 rows in set (0.02 sec)

22.查询选修某课程的同学人数多于5人的教师姓名。

insert into score values('101','3-105','90');
insert into score values('102','3-105','91');
insert into score values('104','3-105','89');

select cno from score group by cno having count(*)>5;
-- having是对查询结果的临时表进行筛选操作

select tname from teacher where tno = (select tno from course where cno=(select cno from score group by cno having count(*)>5));

mysql> select tname from teacher where tno = (select tno from course where cno=(select cno from score group by cno having count(*)>5));
+--------+
| tname  |
+--------+
| 王萍   |
+--------+
1 row in set (0.01 sec)

23.查询95033班和95031班全体学生的记录
insert into student values('110','张飞','男','1974-06-03','95038');

select * from student where class in ('95033','95031');
mysql> select * from student where class in ('95033','95031');
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 101 | 曾华      | 男   | 1977-09-01 00:00:00 | 95033 |
| 102 | 匡明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 103 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 104 | 李军      | 男   | 1976-02-20 00:00:00 | 95033 |
| 105 | 王芳      | 女   | 1975-02-10 00:00:00 | 95031 |
| 106 | 陆君      | 男   | 1974-06-03 00:00:00 | 95031 |
| 107 | 王尼玛    | 男   | 1976-02-20 00:00:00 | 95033 |
| 108 | 张全蛋    | 男   | 1975-02-10 00:00:00 | 95031 |
| 109 | 赵铁柱    | 男   | 1974-06-03 00:00:00 | 95031 |
+-----+-----------+------+---------------------+-------+
9 rows in set (0.00 sec)

24.查询存在有85分以上成绩的课程cno
select cno,degree from score where degree>85;

mysql> select cno,degree from score where degree>85;
+-------+--------+
| cno   | degree |
+-------+--------+
| 3-105 |     90 |
| 3-105 |     91 |
| 3-105 |     92 |
| 3-245 |     86 |
| 3-105 |     89 |
| 3-105 |     88 |
+-------+--------+
6 rows in set (0.00 sec)

25.查询出”计算机系“教师所教课程的成绩表

mysql> select * from teacher where depart = '计算机系';
+-----+--------+------+---------------------+-----------+--------------+
| tno | tname  | tsex | tbirthday           | prof      | depart       |
+-----+--------+------+---------------------+-----------+--------------+
| 804 | 李诚   | 男   | 1958-12-02 00:00:00 | 副教授    | 计算机系     |
| 825 | 王萍   | 女   | 1972-05-05 00:00:00 | 助教      | 计算机系     |
+-----+--------+------+---------------------+-----------+--------------+

select * from score where cno in (select cno from course where tno in (select tno from teacher where depart = '计算机系'));

mysql> select * from score where cno in (select cno from course where tno in (select tno from teacher where depart = '计算机系'));
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 103 | 3-245 |     86 |
| 105 | 3-245 |     75 |
| 109 | 3-245 |     68 |
| 101 | 3-105 |     90 |
| 102 | 3-105 |     91 |
| 103 | 3-105 |     92 |
| 104 | 3-105 |     89 |
| 105 | 3-105 |     88 |
| 109 | 3-105 |     76 |
+-----+-------+--------+
9 rows in set (0.01 sec)

26.查询”计算机系“与”电子工程系“不同职称的教师的tname和prof
select * from teacher where depart = '计算机系' and prof not in 
(select prof from teacher where depart = '电子工程系')
union
select * from teacher where depart = '电子工程系' and prof not in 
(select prof from teacher where depart = '计算机系');

-- union 求并集

mysql> select * from teacher where depart = '计算机系' and prof not in 
    -> (select prof from teacher where depart = '电子工程系');
+-----+--------+------+---------------------+-----------+--------------+
| tno | tname  | tsex | tbirthday           | prof      | depart       |
+-----+--------+------+---------------------+-----------+--------------+
| 804 | 李诚   | 男   | 1958-12-02 00:00:00 | 副教授    | 计算机系     |
+-----+--------+------+---------------------+-----------+--------------+
1 row in set (0.03 sec)

mysql> select * from teacher where depart = '电子工程系' and prof not in 
    -> (select prof from teacher where depart = '计算机系');
+-----+--------+------+---------------------+--------+-----------------+
| tno | tname  | tsex | tbirthday           | prof   | depart          |
+-----+--------+------+---------------------+--------+-----------------+
| 856 | 张旭   | 男   | 1969-03-12 00:00:00 | 讲师   | 电子工程系      |
+-----+--------+------+---------------------+--------+-----------------+
1 row in set (0.02 sec)

mysql> select * from teacher where depart = '计算机系' and prof not in 
    -> (select prof from teacher where depart = '电子工程系')
    -> union
    -> select * from teacher where depart = '电子工程系' and prof not in 
    -> (select prof from teacher where depart = '计算机系');
+-----+--------+------+---------------------+-----------+-----------------+
| tno | tname  | tsex | tbirthday           | prof      | depart          |
+-----+--------+------+---------------------+-----------+-----------------+
| 804 | 李诚   | 男   | 1958-12-02 00:00:00 | 副教授    | 计算机系        |
| 856 | 张旭   | 男   | 1969-03-12 00:00:00 | 讲师      | 电子工程系      |
+-----+--------+------+---------------------+-----------+-----------------+
2 rows in set (0.02 sec)

27.查询选修编号为”3-105“课程且成绩至少高于选修编号为”3-245“的同学的cno,sno和degree,
并按degree从高到低次序排序

select * from score where cno = '3-105';

至少高于 = 至少高于3-245课程中的一人成绩

select * from score where cno = '3-105' and degree >  (select min(degree) from score where cno = '3-245')

-- min() 大于最小值
mysql> select * from score where cno = '3-105' and degree >  (select min(degree) from score where cno = '3-245');
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 101 | 3-105 |     90 |
| 102 | 3-105 |     91 |
| 103 | 3-105 |     92 |
| 104 | 3-105 |     89 |
| 105 | 3-105 |     88 |
| 109 | 3-105 |     76 |
+-----+-------+--------+
6 rows in set (0.00 sec)


select * from score where cno = '3-105' and degree >  any (select degree from score where cno = '3-245')

-- any 大于任一成绩值
mysql> select * from score where cno = '3-105' and degree >  any (select degree from score where cno = '3-245');
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 101 | 3-105 |     90 |
| 102 | 3-105 |     91 |
| 103 | 3-105 |     92 |
| 104 | 3-105 |     89 |
| 105 | 3-105 |     88 |
| 109 | 3-105 |     76 |
+-----+-------+--------+
6 rows in set (0.01 sec)


-- 排序
mysql> select * from score where cno = '3-105' and degree >  any (select degree from score where cno = '3-245') order by degree desc;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 103 | 3-105 |     92 |
| 102 | 3-105 |     91 |
| 101 | 3-105 |     90 |
| 104 | 3-105 |     89 |
| 105 | 3-105 |     88 |
| 109 | 3-105 |     76 |
+-----+-------+--------+
6 rows in set (0.02 sec)


28.查询选修编号为”3-105“且成绩高于选修编号为”3-245“课程的同学的cno,sno和degree

mysql> select * from score
    -> where cno='3-105'
    -> and degree > all(select degree from score where cno='3-245');
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 101 | 3-105 |     90 |
| 102 | 3-105 |     91 |
| 103 | 3-105 |     92 |
| 104 | 3-105 |     89 |
| 105 | 3-105 |     88 |
+-----+-------+--------+
5 rows in set (0.03 sec)

29.查询所有教师和同学的name、sex和birthday
mysql> select tname,tsex,tbirthday from teacher
    -> union
    -> select sname,ssex,sbirthday from student;
+-----------+------+---------------------+
| tname     | tsex | tbirthday           |
+-----------+------+---------------------+
| 李诚      | 男   | 1958-12-02 00:00:00 |
| 王萍      | 女   | 1972-05-05 00:00:00 |
| 刘冰      | 女   | 1977-08-14 00:00:00 |
| 张旭      | 男   | 1969-03-12 00:00:00 |
| 曾华      | 男   | 1977-09-01 00:00:00 |
| 匡明      | 男   | 1975-10-02 00:00:00 |
| 王丽      | 女   | 1976-01-23 00:00:00 |
| 李军      | 男   | 1976-02-20 00:00:00 |
| 王芳      | 女   | 1975-02-10 00:00:00 |
| 陆君      | 男   | 1974-06-03 00:00:00 |
| 王尼玛    | 男   | 1976-02-20 00:00:00 |
| 张全蛋    | 男   | 1975-02-10 00:00:00 |
| 赵铁柱    | 男   | 1974-06-03 00:00:00 |
| 张飞      | 男   | 1974-06-03 00:00:00 |
+-----------+------+---------------------+
14 rows in set (0.04 sec)

-- 用as取别名

mysql> select tname as name,tsex as sex,tbirthday as birthday from teacher
    -> union
    -> select sname,ssex,sbirthday from student;
+-----------+-----+---------------------+
| name      | sex | birthday            |
+-----------+-----+---------------------+
| 李诚      | 男  | 1958-12-02 00:00:00 |
| 王萍      | 女  | 1972-05-05 00:00:00 |
| 刘冰      | 女  | 1977-08-14 00:00:00 |
| 张旭      | 男  | 1969-03-12 00:00:00 |
| 曾华      | 男  | 1977-09-01 00:00:00 |
| 匡明      | 男  | 1975-10-02 00:00:00 |
| 王丽      | 女  | 1976-01-23 00:00:00 |
| 李军      | 男  | 1976-02-20 00:00:00 |
| 王芳      | 女  | 1975-02-10 00:00:00 |
| 陆君      | 男  | 1974-06-03 00:00:00 |
| 王尼玛    | 男  | 1976-02-20 00:00:00 |
| 张全蛋    | 男  | 1975-02-10 00:00:00 |
| 赵铁柱    | 男  | 1974-06-03 00:00:00 |
| 张飞      | 男  | 1974-06-03 00:00:00 |
+-----------+-----+---------------------+
14 rows in set (0.02 sec)

30.查询所有”女“教师和”女“同学的name、sex和birthday

select tname as name,tsex as sex,tbirthday as birthday from teacher where tsex = '女'
union
select sname, ssex,sbirthday from student where ssex = '女'

mysql> select tname as name,tsex as sex,tbirthday as birthday from teacher where tsex = '女'
    -> union
    -> select sname, ssex,sbirthday from student where ssex = '女'
    -> ;
+--------+-----+---------------------+
| name   | sex | birthday            |
+--------+-----+---------------------+
| 王萍   | 女  | 1972-05-05 00:00:00 |
| 刘冰   | 女  | 1977-08-14 00:00:00 |
| 王丽   | 女  | 1976-01-23 00:00:00 |
| 王芳   | 女  | 1975-02-10 00:00:00 |
+--------+-----+---------------------+
4 rows in set (0.01 sec)

31.查询成绩比该课程平均成绩低的同学的成绩表

-- 复制表数据做条件查询

select cno, avg(degree) from score group by cno;


mysql> select cno, avg(degree) from score group by cno;
+-------+-------------+
| cno   | avg(degree) |
+-------+-------------+
| 3-105 |     87.6667 |
| 3-245 |     76.3333 |
| 6-166 |     81.6667 |
+-------+-------------+
3 rows in set (0.02 sec)

mysql> select * from score a where degree < (select avg(degree) from score b 
    -> where a.cno=b.cno);
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 105 | 3-245 |     75 |
| 105 | 6-166 |     79 |
| 109 | 3-105 |     76 |
| 109 | 3-245 |     68 |
| 109 | 6-166 |     81 |
+-----+-------+--------+
5 rows in set (0.02 sec)


32.查询所有任课教师的tname和depart

select tname,depart from teacher where tno in (select tno from course);

mysql> select tname,depart from teacher where tno in (select tno from course);
+--------+-----------------+
| tname  | depart          |
+--------+-----------------+
| 李诚   | 计算机系        |
| 王萍   | 计算机系        |
| 刘冰   | 电子工程系      |
| 张旭   | 电子工程系      |
+--------+-----------------+
4 rows in set (0.00 sec)

33.查询至少有2名男生的班号

mysql> select class from student where ssex ='男' group by class;
+-------+
| class |
+-------+
| 95033 |
| 95031 |
| 95038 |
+-------+
3 rows in set (0.01 sec)


select class from student where ssex ='男' group by class having count(*) >=2; 

mysql> select class from student where ssex ='男' group by class having count(*) >=2; 
+-------+
| class |
+-------+
| 95033 |
| 95031 |
+-------+
2 rows in set (0.00 sec)

34.查询student表中不姓”王“的同学记录。

select * from student where sname not like '王%'

mysql> select * from student where sname not like '王%';
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 101 | 曾华      | 男   | 1977-09-01 00:00:00 | 95033 |
| 102 | 匡明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 104 | 李军      | 男   | 1976-02-20 00:00:00 | 95033 |
| 106 | 陆君      | 男   | 1974-06-03 00:00:00 | 95031 |
| 108 | 张全蛋    | 男   | 1975-02-10 00:00:00 | 95031 |
| 109 | 赵铁柱    | 男   | 1974-06-03 00:00:00 | 95031 |
| 110 | 张飞      | 男   | 1974-06-03 00:00:00 | 95038 |
+-----+-----------+------+---------------------+-------+
7 rows in set (0.01 sec)

35.查询student表中每个学生的姓名和年龄
年龄=当前年份-出生年份

-- now() 为当前的日期和时间
-- year(now()) 为当前的年份

select sname,year(now())-year(sbirthday) from student

mysql> select sname,year(now())-year(sbirthday) from student;
+-----------+-----------------------------+
| sname     | year(now())-year(sbirthday) |
+-----------+-----------------------------+
| 曾华      |                          42 |
| 匡明      |                          44 |
| 王丽      |                          43 |
| 李军      |                          43 |
| 王芳      |                          44 |
| 陆君      |                          45 |
| 王尼玛    |                          43 |
| 张全蛋    |                          44 |
| 赵铁柱    |                          45 |
| 张飞      |                          45 |
+-----------+-----------------------------+
10 rows in set (0.01 sec)


mysql> select sname,year(now())-year(sbirthday) as '年龄' from student;
+-----------+--------+
| sname     | 年龄   |
+-----------+--------+
| 曾华      |     42 |
| 匡明      |     44 |
| 王丽      |     43 |
| 李军      |     43 |
| 王芳      |     44 |
| 陆君      |     45 |
| 王尼玛    |     43 |
| 张全蛋    |     44 |
| 赵铁柱    |     45 |
| 张飞      |     45 |
+-----------+--------+
10 rows in set (0.05 sec)

mysql> select sname,year(now())-year(sbirthday) as 年龄 from student;
+-----------+--------+
| sname     | 年龄   |
+-----------+--------+
| 曾华      |     42 |
| 匡明      |     44 |
| 王丽      |     43 |
| 李军      |     43 |
| 王芳      |     44 |
| 陆君      |     45 |
| 王尼玛    |     43 |
| 张全蛋    |     44 |
| 赵铁柱    |     45 |
| 张飞      |     45 |
+-----------+--------+
10 rows in set (0.00 sec)


36.查询student表中最大和最小的sbirthday日期值

mysql> select max(sbirthday) from student
    -> union
    -> select min(sbirthday) from student;
+---------------------+
| max(sbirthday)      |
+---------------------+
| 1977-09-01 00:00:00 |
| 1974-06-03 00:00:00 |
+---------------------+
2 rows in set (0.08 sec)

mysql> select max(sbirthday),min(sbirthday) from student
    -> ;
+---------------------+---------------------+
| max(sbirthday)      | min(sbirthday)      |
+---------------------+---------------------+
| 1977-09-01 00:00:00 | 1974-06-03 00:00:00 |
+---------------------+---------------------+
1 row in set (0.00 sec)

mysql> select max(sbirthday) as 最大 ,min(sbirthday) as 最小 from student;
+---------------------+---------------------+
| 最大                | 最小                |
+---------------------+---------------------+
| 1977-09-01 00:00:00 | 1974-06-03 00:00:00 |
+---------------------+---------------------+
1 row in set (0.01 sec)


37.以班号和年龄从大到小的顺序查询student表中的全部记录

select *, year(now())-year(sbirthday) as 年龄 from student order by class desc,
 year(now())-year(sbirthday) desc

 mysql> select *, year(now())-year(sbirthday) as 年龄 from student order by class desc,
    ->  year(now())-year(sbirthday) desc;
+-----+-----------+------+---------------------+-------+--------+
| sno | sname     | ssex | sbirthday           | class | 年龄   |
+-----+-----------+------+---------------------+-------+--------+
| 110 | 张飞      | 男   | 1974-06-03 00:00:00 | 95038 |     45 |
| 103 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |     43 |
| 104 | 李军      | 男   | 1976-02-20 00:00:00 | 95033 |     43 |
| 107 | 王尼玛    | 男   | 1976-02-20 00:00:00 | 95033 |     43 |
| 101 | 曾华      | 男   | 1977-09-01 00:00:00 | 95033 |     42 |
| 106 | 陆君      | 男   | 1974-06-03 00:00:00 | 95031 |     45 |
| 109 | 赵铁柱    | 男   | 1974-06-03 00:00:00 | 95031 |     45 |
| 102 | 匡明      | 男   | 1975-10-02 00:00:00 | 95031 |     44 |
| 105 | 王芳      | 女   | 1975-02-10 00:00:00 | 95031 |     44 |
| 108 | 张全蛋    | 男   | 1975-02-10 00:00:00 | 95031 |     44 |
+-----+-----------+------+---------------------+-------+--------+
10 rows in set (0.02 sec)

mysql> select * from student order by class desc,sbirthday;
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 110 | 张飞      | 男   | 1974-06-03 00:00:00 | 95038 |
| 103 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 104 | 李军      | 男   | 1976-02-20 00:00:00 | 95033 |
| 107 | 王尼玛    | 男   | 1976-02-20 00:00:00 | 95033 |
| 101 | 曾华      | 男   | 1977-09-01 00:00:00 | 95033 |
| 106 | 陆君      | 男   | 1974-06-03 00:00:00 | 95031 |
| 109 | 赵铁柱    | 男   | 1974-06-03 00:00:00 | 95031 |
| 105 | 王芳      | 女   | 1975-02-10 00:00:00 | 95031 |
| 108 | 张全蛋    | 男   | 1975-02-10 00:00:00 | 95031 |
| 102 | 匡明      | 男   | 1975-10-02 00:00:00 | 95031 |
+-----+-----------+------+---------------------+-------+
10 rows in set (0.01 sec)

38.查询”男“教师及其su o上的课程

select * from course where tno in (select tno from teacher where tsex = '男')

mysql> select * from course where tno in (select tno from teacher where tsex = '男');
+-------+--------------+-----+
| cno   | cname        | tno |
+-------+--------------+-----+
| 3-245 | 操作系统     | 804 |
| 6-166 | 数字电路     | 856 |
+-------+--------------+-----+
2 rows in set (0.03 sec)

39.查询最高分同学的sno、cno和degree列

select sno,cno,degree from score a where degree = (select max(degree) from score b where a.cno=b.cno)
mysql> select sno,cno,degree from score a where degree = (select max(degree) from score b where a.cno=b.cno);
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 103 | 3-105 |     92 |
| 103 | 3-245 |     86 |
| 103 | 6-166 |     85 |
+-----+-------+--------+
3 rows in set (0.01 sec)

select * from score where degree = (select max(degree) from score);
mysql> select * from score where degree = (select max(degree) from score);
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 103 | 3-105 |     92 |
+-----+-------+--------+
1 row in set (0.01 sec)

40.查询和”李军“同性别的所有同学的sname

select sname from student where ssex = (select ssex from student 
where sname = '李军')

mysql> select sname from student where ssex = (select ssex from student 
    -> where sname = '李军');
+-----------+
| sname     |
+-----------+
| 曾华      |
| 匡明      |
| 李军      |
| 陆君      |
| 王尼玛    |
| 张全蛋    |
| 赵铁柱    |
| 张飞      |
+-----------+
8 rows in set (0.01 sec)

41.查询和”李军“同性别并同班的同学的sname

select sname from student where ssex = (select ssex from student 
where sname = '李军') and class = (select class from student 
where sname = '李军');

mysql> select sname from student where ssex = (select ssex from student 
    -> where sname = '李军') and class = (select class from student 
    -> where sname = '李军');
+-----------+
| sname     |
+-----------+
| 曾华      |
| 李军      |
| 王尼玛    |
+-----------+
3 rows in set (0.02 sec)

42.查询所有选修”计算机导论“课程的”男“同学的成绩表

select * from score where cno = (select cno from course 
where cname='计算机导论') and sno in (select sno from student
where ssex = '男' );

mysql> select * from score where cno = (select cno from course 
    -> where cname='计算机导论') and sno in (select sno from student
    -> where ssex = '男' );
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 101 | 3-105 |     90 |
| 102 | 3-105 |     91 |
| 104 | 3-105 |     89 |
| 109 | 3-105 |     76 |
+-----+-------+--------+
4 rows in set (0.02 sec)

43.假设使用如下命令创建grade表
create table grade(
    low int(3),
    upp int(3),
    grade char(1)
);

insert into grade values(90,100,'A');
insert into grade values(80,89,'B');
insert into grade values(70,79,'C');
insert into grade values(60,69,'D');
insert into grade values(0,59,'E');

mysql> select * from grade;
+------+------+-------+
| low  | upp  | grade |
+------+------+-------+
|   90 |  100 | A     |
|   80 |   89 | B     |
|   70 |   79 | C     |
|   60 |   69 | D     |
|    0 |   59 | E     |
+------+------+-------+
5 rows in set (0.01 sec)


-- 现查询所有同学的sno、cno和grade列
select sno,cno,grade from score,grade where degree between low and upp;

mysql> select sno,cno,grade from score,grade where degree between low and upp;
+-----+-------+-------+
| sno | cno   | grade |
+-----+-------+-------+
| 101 | 3-105 | A     |
| 102 | 3-105 | A     |
| 103 | 3-105 | A     |
| 103 | 3-245 | B     |
| 103 | 6-166 | B     |
| 104 | 3-105 | B     |
| 105 | 3-105 | B     |
| 105 | 3-245 | C     |
| 105 | 6-166 | C     |
| 109 | 3-105 | C     |
| 109 | 3-245 | D     |
| 109 | 6-166 | B     |
+-----+-------+-------+
12 rows in set (0.02 sec)
