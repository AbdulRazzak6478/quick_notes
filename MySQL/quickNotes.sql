
-- DATA TYPES
INT            -- 
VARCHAR        -- for variables --> (0 to 255)
CHAR           -- Fixed size --> (251) each time fixed size
DATETIME       -- ( year:month:date hour.minute.seconds ) Ex : ( '14-02-20 09.00.00')
TINYTEXT       -- (0 to 255)
TEXT           -- (0 to 65535)
BLOB           -- (0 to 65535) --> for audio,video
MEDIUMTEXT
TINYINT        -- ( -128 to 127)
UNSIGNED TINYINT -- (0 to 255)

-- Types Of Commands
DDL -- Database Definition language
DRL -- Data retrieval Language (data query language)
DML -- Data Modification Language
DCL -- Data Control Language (GRANT,REVOKE)
TCL -- Transaction Control Language


-- For creating database and deleting DB
SHOW DATABASES;

CREATE DATABASE <_database_name>;
CREATE DATABASE IF NOT EXISTS <_database_name>;

DROP DATABASE <_database_name>;
DROP DATABASE IF EXISTS <_database_name>;

SHOW DATABASE;

USE <_database_name>; -- To get into this DB to use it.

-- For Creating Tables
CREATE TABLE <_table_name>;
SHOW TABLES;

CREATE TABLE <_table_name> (
	<_id> INT PRIMARY KEY,
    <_NAME> CHAR(30),
    LAST_NAME CHAR(30),
    SALARY INT(20),
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(30)
);
 -- Ex : For creation
CREATE TABLE worker (
	WORKER_ID INT PRIMARY KEY,
    FIRST_NAME CHAR(30),
    LAST_NAME CHAR(30),
    SALARY INT(20),
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(30)
);

INSERT INTO worker 
	(WORKER_ID,FIRST_NAME,LAST_NAME,SALARY,JOINING_DATE,DEPARTMENT) VALUES
    (001,'Mohammed','Qureshi',8000 '14-02-20 09.00.00', 'CSE'),
    (002,'Abdul','Razzak',100000, '19-02-20 10.00.00', 'Software Engineer');

SELECT * FROM <_table_name>; -- for getting whole data
SELECT <property_1>, <property_2> FROM <_table_name >; --For accessing specific property
-- EX: SELECT FIRST_NAME,SALARY FROM worker;

-- Select Operations
SELECT 5*6;
SELECT now(); -- To Get Current Date and Time
SELECT ucase('mohammed abdul razzak qureshi'); --To convert String to Uppercase
SELECT lcase('MOHAMMED abdul RAZZAK qureshi'); --To convert String to Lowercase
SELECT * FROM worker;
SELECT * FROM worker WHERE SALARY <200000; -- For putting some condition
SELECT * FROM worker WHERE DEPARTMENT ='Software Developer'; -- From secific property
SELECT * FROM worker WHERE DEPARTMENT ='Software Engineer';
SELECT * FROM worker WHERE SALARY BETWEEN 50000 AND 200000;  -- both inclusive
SELECT * FROM worker WHERE FIRST_NAME ='mohammed' OR FIRST_NAME ='Mohammed';
SELECT * FROM worker WHERE FIRST_NAME IN ('mohammed', 'Mohammed','shaik');
SELECT * FROM worker WHERE FIRST_NAME NOT IN ('mohammed','Mohammed');
-- Pattern Searching (wildcard)
-- '%' For any number of characters from 0 to n ,similar to astrisk(*) in regex
-- '_' For only one character
select * from worker where FIRST_NAME LIKE '_h%'; -- pattern Searching (wildcard)
select* from worker order by SALARY ; -- salary wise arrangement
select* from worker order by LAST_NAME ; -- name wise
select* from worker order by LAST_NAME desc; -- desending order
select* from worker order by LAST_NAME asc; -- asending order
select DEPARTMENT from worker;
select distinct DEPARTMENT from worker; -- unique or distinct 
select DEPARTMENT from worker group by DEPARTMENT;
select DEPARTMENT, COUNT(DEPARTMENT) from worker group by DEPARTMENT; 
select SALARY, count(SALARY) from worker group by SALARY;
select department ,AVG(salary) from worker group by department;
select department ,min(salary) from worker group by department;
select department ,max(salary) from worker group by department;
select department ,sum(salary) from worker group by department;
select department ,count(salary) from worker group by department having count(department) >1;

WHERE
-- no count
-- no grouping
-- filter table based
-- before
-- no necessary

HAVING
-- count
-- grouping
-- Filter group based
-- after group by 
-- group by neccessary


create table accounter(
	id int primary key,
	name char(100) UNIQUE,
	balance int,
	CONSTRAINT acc_balance_check CHECK(balance>1000),
    age int not null default 18
);
insert into accounter(id,name,balance) values(1,'razzak',15000);
insert into accounter(id,name,balance) values(2,'shoeb',50000);
insert into accounter(id,name,balance) values(3,'tabrez',3000);
select * from accounter;
DROP table accounter;

-- ALTER OPERATIONS 
-- ADD new Column in table
ALTER TABLE accounter ADD marks FLOAT NOT NULL DEFAULT 0;
ALTER TABLE accounter ADD goal FLOAT NOT NULL ;
desc accounter;
select * from accounter;
-- MODIFY the column properties
ALTER TABLE accounter MODIFY marks DOUBLE NOT NULL DEFAULT 0;
-- CHANGE COLUMN -- 
-- mention data type also
ALTER TABLE accounter CHANGE COLUMN marks cs_marks FLOAT NOT NULL DEFAULT 45;
-- RENAME TABLE - TABLE NAME CHANGE --  
alter table accounter RENAME TO account_details;
desc account_details;
select * from account_details; 
-- DROP COLUMN -- 
alter table account_details DROP column cs_marks; 
alter table account_details DROP column goal; 
 
-- DML ---
-- insert --
insert into <_table_name> (id,e_name) values(3,'ABC'); -- for specific property to fill
insert into <_table_name> values(,,,....);
insert into <_table_name>(properties...) values(,,,....);
-- update --
UPDATE my_profile SET current_lrng='teaching',name='junaid'  WHERE id=2; -- location is important
alter table my_profile add education varchar(50) not null default '';
UPDATE my_profile SET education='graduated' where id between 0 and 5;

UPDATE account_details SET age='20',name='ghouse'  WHERE id=1;
select*from account_details;
-- Delete --
delete from <_table_name> where id=3;
select*from <_table_name>;
insert into <_table_name>(id,name) values(3,'adil');
update <_table_name> SET current_lrng='enterprener', goal='franchise',name='abbas',education='graduated' where id=3;
-- DELETE --
delete from <_table_name> where id=3;
select*from <_table_name>;
insert into <_table_name>(id,name) values(3,'adil');
update <_table_name> SET current_lrng='enterprener', goal='franchise',name='abbas',education='graduated' where id=3;
 

DROP TABLE <_table_name >;
DESC <_table_name> -- description of the table and its properties

DELETE * From <table_name>


-- Referential Constraints
-- Delete Constraints
   -> ON DELETE CASCADE
    -- in this when parent row deleted then its correspondence reference child entries also deleted
   ->ON DELETE SET NULL -> foreign key - null value
   --- in this when parent row is deleted then its correspondence reference child entries set to be NULL 
-- Ex : 
create table customer(
	id int primary key,
    name varchar(20),
    salary int
    );
    insert into customer values (1,'raju',30000);
    insert into customer values (2,'shaam',40000);
    insert into customer values (3,'babu',20000),(4,'totla','4000000'),(5,'kachra_set','5000');
    select * from customer;
    drop table customer;
    
    create table order_details(
		order_id int primary key,
        order_date DATE,
        cust_id int,
        foreign key(cust_id) references customer(id) ON DELETE CASCADE
        );
        insert into order_details(order_id,order_date,cust_id) values(1,'2023-08-27',1);
        insert into order_details(order_id,order_date,cust_id) values(2,'2023-08-28',2),(3,'2023-08-26',4);
 create table order_on_delete_set_null(
		order2_id int primary key,
        order2_date DATE,
        cust_id int,
        foreign key(cust_id) references customer(id)ON DELETE SET NULL
        );
select * from customer;
select * from order_details;
show tables;
insert into order_on_delete_set_null(order2_id,order2_date,cust_id) values(1,'2023-08-28',2);
insert into order_on_delete_set_null(order2_id,order2_date,cust_id) values(2,'2023-08-8',1);
select * from order_on_delete_set_null;
DELETE  FROM order_on_delete_set_null where cust_id=1; -- whole row delete
DELETE FROM customer where id=2; -- set property null when it is refernce connection to others table
show tables;


--- REPLACE ---                             update
1.Data already present then REPLACE  |  update
2. data not present then insert       | do nothing
note : If row is not present then replace will add a new row , while UPDATE will do nothing
 -- REPLACE -- 
REPLACE INTO customer(id,name) values(2,'tabrez'); -- not present but added
REPLACE INTO customer(id,name,salary) values(2,'shaik',1000); -- present but updated
REPLACE INTO customer(id,name,salary) values(10,'abbas',500);
REPLACE INTO customer SET id=11,name='abdul',salary=100000;
REPLACE INTO customer SET id=11,name='razzak',salary=100000;
REPLACE INTO customer SET id=11,salary=200;