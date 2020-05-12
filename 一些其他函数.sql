-- substr()函数
-- substr(string, start, length)

-- eg.
mysql> select * from user5;
+------+-------------+
| id   | name        |
+------+-------------+
| 1    | helloworld  |
| 2    | hhhhhhfunny |
+------+-------------+
2 rows in set (0.00 sec)

mysql> select substr(name,1,3) from user5;
+------------------+
| substr(name,1,3) |
+------------------+
| hel              |
| hhh              |
+------------------+
2 rows in set (0.01 sec)

mysql> SELECT SUBSTR("SQL Tutorial", -5, 5) AS ExtractString;
+---------------+
| ExtractString |
+---------------+
| orial         |
+---------------+
1 row in set (0.01 sec)

-- -5表示从倒数第五位开始，取五个数

-- IF-THEN-ELSE语句

'''
IF condition1 THEN
   {...statements to execute when condition1 is TRUE...}

[ ELSEIF condition2 THEN
   {...statements to execute when condition2 is TRUE...} ]

[ ELSE
   {...statements to execute when both condition1 and condition2 are FALSE...} ]

END IF;
'''
-- IF函数
IF(expr1, expr2,expr3)

-- eg.
select *,if(age=1,"男","女") as ages from user;

-- CASE WHEN 
CASE  <单值表达式>
       WHEN <表达式值> THEN <SQL语句或者返回值>
       WHEN <表达式值> THEN <SQL语句或者返回值>
       ...
       WHEN <表达式值> THEN <SQL语句或者返回值>
       ELSE <SQL语句或者返回值>
 END

-- eg.
select CASE sva WHEN 1 THEN '男' ELSE '女' END as ssva from taname where sva != ''


insert into DailyIncome values ('SPIKE', 'FRI', 100);
insert into DailyIncome values ('SPIKE', 'MON', 300);
insert into DailyIncome values ('FREDS', 'SUN', 400);
insert into DailyIncome values ('SPIKE', 'WED', 500);
insert into DailyIncome values ('SPIKE', 'TUE', 200);
insert into DailyIncome values ('JOHNS', 'WED', 900);
insert into DailyIncome values ('SPIKE', 'FRI', 100);
insert into DailyIncome values ('JOHNS', 'MON', 300);
insert into DailyIncome values ('SPIKE', 'SUN', 400);
insert into DailyIncome values ('JOHNS', 'FRI', 300);
insert into DailyIncome values ('FREDS', 'TUE', 500);
insert into DailyIncome values ('FREDS', 'TUE', 200);
insert into DailyIncome values ('SPIKE', 'MON', 900);
insert into DailyIncome values ('FREDS', 'FRI', 900);
insert into DailyIncome values ('FREDS', 'MON', 500);
insert into DailyIncome values ('JOHNS', 'SUN', 600);
insert into DailyIncome values ('SPIKE', 'FRI', 300);
insert into DailyIncome values ('SPIKE', 'WED', 500);
insert into DailyIncome values ('SPIKE', 'FRI', 300);
insert into DailyIncome values ('JOHNS', 'THU', 800);
insert into DailyIncome values ('JOHNS', 'SAT', 800);
insert into DailyIncome values ('SPIKE', 'TUE', 100);
insert into DailyIncome values ('SPIKE', 'THU', 300);
insert into DailyIncome values ('FREDS', 'WED', 500);
insert into DailyIncome values ('SPIKE', 'SAT', 100);
insert into DailyIncome values ('FREDS', 'SAT', 500);
insert into DailyIncome values ('FREDS', 'THU', 800);
insert into DailyIncome values ('JOHNS', 'TUE', 600);

select * from DailyIncome;

+----------+-----------+--------------+
| VendorId | IncomeDay | IncomeAmount |
+----------+-----------+--------------+
| SPIKE    | FRI       |          100 |
| SPIKE    | MON       |          300 |
| FREDS    | SUN       |          400 |
| SPIKE    | WED       |          500 |
| SPIKE    | TUE       |          200 |
| JOHNS    | WED       |          900 |
| SPIKE    | FRI       |          100 |
| JOHNS    | MON       |          300 |
| SPIKE    | SUN       |          400 |
| JOHNS    | FRI       |          300 |
| FREDS    | TUE       |          500 |
| FREDS    | TUE       |          200 |
| SPIKE    | MON       |          900 |
| FREDS    | FRI       |          900 |
| FREDS    | MON       |          500 |
| JOHNS    | SUN       |          600 |
| SPIKE    | FRI       |          300 |
| SPIKE    | WED       |          500 |
| SPIKE    | FRI       |          300 |
| JOHNS    | THU       |          800 |
| JOHNS    | SAT       |          800 |
| SPIKE    | TUE       |          100 |
| SPIKE    | THU       |          300 |
| FREDS    | WED       |          500 |
| SPIKE    | SAT       |          100 |
| FREDS    | SAT       |          500 |
| FREDS    | THU       |          800 |
| JOHNS    | TUE       |          600 |
+----------+-----------+--------------+
28 rows in set (0.00 sec)

-- 行转换方式一

select VendorId ,
sum(case when  IncomeDay='MoN' then IncomeAmount else 0 end) as MON,
sum(case when  IncomeDay='TUE' then IncomeAmount else 0 end) as TUE,
sum(case when  IncomeDay='WED' then IncomeAmount else 0 end) as WED,
sum(case when  IncomeDay='THU' then IncomeAmount else 0 end) as THU,
sum(case when  IncomeDay='FRI' then IncomeAmount else 0 end) as FRI,
sum(case when  IncomeDay='SAT' then IncomeAmount else 0 end) as SAT,
sum(case when  IncomeDay='SUN' then IncomeAmount else 0 end) as SUN
from DailyIncome group by VendorId

+----------+------+------+------+------+------+------+------+
| VendorId | MON  | TUE  | WED  | THU  | FRI  | SAT  | SUN  |
+----------+------+------+------+------+------+------+------+
| FREDS    |  500 |  700 |  500 |  800 |  900 |  500 |  400 |
| JOHNS    |  300 |  600 |  900 |  800 |  300 |  800 |  600 |
| SPIKE    | 1200 |  300 | 1000 |  300 |  800 |  100 |  400 |
+----------+------+------+------+------+------+------+------+
3 rows in set (0.04 sec)

-- 行转换方式二

select * from DailyIncome ----第一步
pivot 
(
sum (IncomeAmount) ----第三步
for IncomeDay in ([MON],[TUE],[WED],[THU],[FRI],[SAT],[SUN]) ---第二步
) as AvgIncomePerDay