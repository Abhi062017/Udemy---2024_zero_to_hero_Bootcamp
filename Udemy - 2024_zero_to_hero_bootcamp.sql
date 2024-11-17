/* 4th Nov 2024 @7:49pm
Udemy Course : 2024-complete-sql-bootcamp-from-zero-to-hero-in-sql
*/

show tables;
use sql_portfolio_projects;

-- Q.1 :  Based on the employees table below, insert an employee record whose employee_number is 1005, employee_name is Sally Johnson, salary is $58,000, and dept_id is 500.
CREATE TABLE if not exists udemy_employees
(
employee_number int NOT NULL,
last_name char(50) NOT NULL,
first_name char(50) NOT NULL,
salary int,
dept_id int,
CONSTRAINT employees_pk PRIMARY KEY (employee_number)  -- Adding PK to employee_number
);
-- Solution : 
Insert into udemy_employees values
(1005,'Johnson','Sally',58000,500);

-- Q.2 : Based on the suppliers table below, insert a supplier record whose supplier_id is 1000 and supplier_name is Apple:
CREATE TABLE if not exists udemy_suppliers
(
supplier_id int NOT NULL,
supplier_name char(50) NOT NULL,
city char(50),
state char(50),
CONSTRAINT suppliers_pk PRIMARY KEY (supplier_id)
);
-- Solution : 
Insert into udemy_suppliers(supplier_id, supplier_name) values
(1000,'Apple');

-- Q.3 : Based on the products table below, update the product_name to 'Grapefruit' for all records whose product_name is "Apple".

CREATE TABLE udemy_products
(
product_id int NOT NULL,
product_name char(50) NOT NULL,
category_id int,
CONSTRAINT products_pk PRIMARY KEY (product_id)
);

INSERT udemy_products VALUES
(1,'Pear',50),
(2,'Banana',50),
(3,'Orange',50),
(4,'Apple',50);

-- Solution : 
update udemy_products
set product_name='Grapefruit'
where product_name='Apple';

-- Q.4 : Based on the suppliers table below, update the city to 'Boise' and the state to "Idaho" for all records whose supplier_name is "Microsoft".

CREATE TABLE udemy_suppliers_2
(
supplier_id int NOT NULL,
supplier_name char(50) NOT NULL,
city char(50),
state char(50),
CONSTRAINT suppliers_pk PRIMARY KEY (supplier_id)
);

INSERT udemy_suppliers_2 VALUES
(100, 'Microsoft', 'Redmond', 'Washington'),
(200, 'Google', 'Mountain View', 'California'),
(300, 'Oracle', 'Redwood City', 'California');

-- Solution : 
update udemy_suppliers_2
set city='Boise', state='Idaho'
where supplier_name='Microsoft';

-- Q.5 : Based on the employees table, delete all employee records whose salary is greater than $60,000:
CREATE TABLE udemy_employees_2
(
employee_number int NOT NULL,
last_name char(50) NOT NULL,
first_name char(50) NOT NULL,
salary int,
dept_id int,
CONSTRAINT employees_pk PRIMARY KEY (employee_number)
);

INSERT udemy_employees_2 VALUES
(1001, 'Smith', 'John', 62000, 500),
(1002, 'Anderson', 'Jane', 57500, 500),
(1003, 'Everest', 'Brad', 71000, 501);

-- Solution : 
SET SQL_SAFE_UPDATES = 0;  -- This is needed to disable safe update mode
delete from udemy_employees_2
where salary > 60000;

-- Q.6 : Based on the suppliers table below, delete the supplier's record whose state is 'California' and supplier_name is not Google
CREATE TABLE udemy_suppliers_3
(
supplier_id int NOT NULL,
supplier_name char(50) NOT NULL,
city char(50),
state char(50),
CONSTRAINT suppliers_pk PRIMARY KEY (supplier_id)
);

Insert udemy_suppliers_3 values
(100, 'Microsoft', 'Redmond', 'Washington'),
(200, 'Google', 'Mountain View', 'California'),
(300, 'Oracle', 'Redwood City', 'California'),
(400, 'Kimberly-Clark', 'Irving', 'Texas');

-- Solution : 
delete from udemy_suppliers_3 
where state = 'California' and supplier_name != 'Google';  -- Note : The Where clause always uses the logical operators 'AND','OR' etc.

/*
-- Q.7 : Consider a database of social groups that allows people to become members of groups: 
-- a person can be a member of several groups and each group maintains a list of pictures that are accessible to all members.
-- In addition to the groups, the database also maintains a list of friends.

-- Query : A “cool person” is one that has at least 6 friends. Write a SQL query that returns all the cool persons in the database. You need to turn in a SQL query that computes a list of names.

The schema is:

MEMBER(personName, groupName)
PICTURE(groupName, picture) -- Picture is PK
FRIEND(personName1, personName2)

PICTURE stores for each picture the name of the group that owns that picture.
The FRIEND table is symmetric, i.e. if X is friend with Y then Y is friend with X.
Every person is a member of at least one group.

*/

-- Solution : To implement this scenario, we’ll create three tables: MEMBER, PICTURE, and FRIEND, and populate them with data. Then, we'll write a query to find all "cool persons" (those with at least 6 friends).

CREATE TABLE if not exists udemy_MEMBER_q7
(
    personName VARCHAR(50) NOT NULL,
    groupName VARCHAR(50) NOT NULL,
    primary key(personName,groupName),  -- Another way to add the PK constraint. Note, since there are multiple columns, hence this becomes a composite key
    key(groupName)  -- this is added to esnure the picture table below allows adding foregin key to this column. It's called "adding an index" on the column to allow it to be referenced as FK in another table
);

CREATE TABLE if not exists udemy_PICTURE_q7
(
    groupName VARCHAR(50) NOT NULL,
    picture VARCHAR(50) NOT NULL,
    PRIMARY KEY (picture),
    FOREIGN KEY (groupName) REFERENCES udemy_MEMBER_q7(groupName)
);

CREATE TABLE if not exists udemy_FRIEND_q7
(
    personName1 VARCHAR(50) NOT NULL,
    personName2 VARCHAR(50) NOT NULL,
    PRIMARY KEY (personName1, personName2),
    CHECK (personName1 < personName2)  -- Ensures symmetry is stored only once
);

INSERT udemy_MEMBER_q7 VALUES
('Alice', 'Group1'),
('Alice', 'Group2'),
('Bob', 'Group1'),
('Carol', 'Group1'),
('David', 'Group2'),
('Eve', 'Group3'),
('Frank', 'Group1'),
('Grace', 'Group2'),
('Heidi', 'Group3'),
('Ivan', 'Group3');

INSERT udemy_PICTURE_q7 VALUES
('Group1', 'Pic1'),
('Group1', 'Pic2'),
('Group2', 'Pic3'),
('Group2', 'Pic4'),
('Group3', 'Pic5');

INSERT udemy_FRIEND_q7 VALUES
('Alice', 'Bob'),
('Alice', 'Carol'),
('Alice', 'David'),
('Alice', 'Eve'),
('Alice', 'Frank'),
('Alice', 'Grace'),
('Alice', 'Heidi'),
('Alice', 'Ivan'),
('Bob', 'Carol'),
('Carol', 'David'),
('David', 'Eve'),
('David', 'Frank'),
('David', 'Grace'),
('David', 'Heidi'),
('David', 'Ivan'),
('Frank', 'Grace'),
('Frank', 'Heidi'),
('Frank', 'Ivan'),
('Frank', 'Jack'),
('Frank', 'Kelly'),
('Eve', 'Frank'),
('Eve', 'Gigi'),
('Eve', 'Hayden'),
('Eve', 'Iris'),
('Eve', 'John'),
('Grace', 'Hitler'),
('Grace', 'India'),
('Grace', 'Jonathan'),
('Grace', 'Kristen'),
('Grace', 'Lampard');

select * from udemy_member_q7;
select * from udemy_picture_q7;
select * from udemy_FRIEND_q7;

-- Solution query : A “cool person” is one that has at least 6 friends. Write a SQL query that returns all the cool persons in the database. You need to turn in a SQL query that computes a list of names.

select f as cool_friend, count(*) as total_friends
from
(
select personName1 as f from udemy_friend_q7
UNION ALL
select personName2 from udemy_friend_q7
) as allfriends
group by cool_friend
having total_friends>=6;

/*
Q.8 : Consider the following schema:

Suppliers(sid integer, sname string, address string)
Parts(pid integer, pname string, color string)
Catalog(sid integer, pid integer, price real)

Describe in one short English sentence what the following SQL query computes:

SELECT P.pid, AVG(P.price)
FROM Parts P, Catalog C
WHERE P.pid = C.pid
GROUP BY P.pid
HAVING COUNT(*) > 1

-- Solution : It returns the parts_id and avg(price) of those parts, which are multiple and which match with the parts_id from catalog table.
*/

CREATE TABLE if not exists udemy_Suppliers_q8
(
    sid INTEGER PRIMARY KEY,
    sname VARCHAR(50),
    address VARCHAR(100)
);

CREATE TABLE if not exists udemy_Parts_q8
(
    pid INTEGER PRIMARY KEY,
    pname VARCHAR(50),
    color VARCHAR(20)
);

CREATE TABLE if not exists udemy_Catalog_q8
(
    sid INTEGER,
    pid INTEGER,
    price REAL,
    PRIMARY KEY (sid, pid),  -- composite key
    FOREIGN KEY (sid) REFERENCES udemy_Suppliers_q8(sid),
    FOREIGN KEY (pid) REFERENCES udemy_Parts_q8(pid)
);

INSERT udemy_Suppliers_q8 VALUES
(1, 'SupplierA', '123 Maple St'),
(2, 'SupplierB', '456 Oak St'),
(3, 'SupplierC', '789 Pine St');

INSERT udemy_Parts_q8 VALUES
(100, 'PartX', 'Red'),
(101, 'PartY', 'Blue'),
(102, 'PartZ', 'Green'),
(103, 'PartW', 'Yellow');


INSERT udemy_Catalog_q8 VALUES
(1, 100, 15.50),
(1, 101, 20.00),
(2, 100, 16.00),
(2, 102, 25.00),
(3, 101, 21.00),
(3, 103, 10.00),
(1, 102, 24.50),
(2, 103, 12.00),
(2, 101, 12.00);

select * from udemy_Suppliers_q8;
select * from udemy_Parts_q8;
select * from udemy_Catalog_q8;

-- Return the parts_id and average(price) where parts are multiple and the parts' pid matches catalogue's pid
select p.pid, count(*), avg(c.price)
from udemy_parts_q8 p
join udemy_Catalog_q8 c on p.pid=c.pid
group by p.pid
having count(*)>2;

/*
Q.9 : Consider the following table whose name is T:
A  B  C
1 10 100
2 10 10
3 40 100
4 30 200
5 25 90

Give the results of the following SQL queries:

(i)
select sum(C)
from T
group by B
having count(*) >= 2;

(ii)
select A
from T as R
where not exists ( select * from T where T.B >= R.B and T.C >= R.C);

*/

CREATE TABLE udemy_ExampleTable_q9
(
    A INT,
    B INT,
    C INT
);

INSERT udemy_ExampleTable_q9 VALUES
(1, 10, 100),
(2, 10, 10),
(3, 40, 100),
(4, 30, 200),
(5, 25, 90);

select * from udemy_ExampleTable_q9;

-- (i)
select sum(C)
from udemy_ExampleTable_q9
group by B
having count(*) >= 2;

-- (ii)
select A
from udemy_ExampleTable_q9 as R
where not exists (select * from udemy_ExampleTable_q9 where udemy_ExampleTable_q9.B >= R.B and udemy_ExampleTable_q9.C >= R.C);

/*
Q.10 : Consider the following relational schema about a social network centered around college students and alumni. People can be friends, post messages, and like each other’s messages.

Users(uid, name, school, year)
Friends(uid1, uid2)
Posts(pid, uid, text, datetime)
Likes(uid, pid, datetime)

If two users with ids 123 and 456 are friends, then (123, 456) and (456, 123) will both appear in the Friends relation. Please use U, F, P, and L for the relation names in your queries.
Write a SQL Query to find user ids of users that have no friends.

*/

CREATE TABLE if not exists udemy_U
(
    uid INTEGER PRIMARY KEY,
    user_name VARCHAR(50),
    school VARCHAR(50),
    user_year INTEGER
);

CREATE TABLE if not exists udemy_F
(
    uid1 INTEGER,
    uid2 INTEGER,
    FOREIGN KEY (uid1) REFERENCES udemy_U(uid),
    FOREIGN KEY (uid2) REFERENCES udemy_U(uid),
    PRIMARY KEY (uid1, uid2)
);

CREATE TABLE if not exists udemy_P
(
    pid INTEGER PRIMARY KEY,
    uid INTEGER,
    post_text VARCHAR(255),
    post_datetime TIMESTAMP,
    FOREIGN KEY (uid) REFERENCES udemy_U(uid)
);

CREATE TABLE if not exists udemy_L
(
    uid INTEGER,
    pid INTEGER,
    likes_datetime TIMESTAMP,
    FOREIGN KEY (uid) REFERENCES udemy_U(uid),
    FOREIGN KEY (pid) REFERENCES udemy_P(pid),
    PRIMARY KEY (uid, pid)
);

INSERT udemy_U VALUES
(123, 'Alice', 'College A', 2024),
(234, 'Bob', 'College A', 2023),
(345, 'Charlie', 'College B', 2022),
(456, 'David', 'College C', 2025),
(567, 'Eve', 'College D', 2023);

INSERT udemy_F VALUES
(123, 234),  -- Alice and Bob are friends
(234, 123),  -- Bob and Alice are friends (duplicate to show mutual friendship)
(345, 456),  -- Charlie and David are friends
(456, 345);  -- David and Charlie are friends (duplicate to show mutual friendship)

INSERT udemy_P VALUES
(1, 123, 'Hello, world!', '2024-11-05 10:00:00'),
(2, 234, 'Learning SQL!', '2024-11-05 11:00:00'),
(3, 345, 'Loving college life!', '2024-11-05 12:00:00'),
(4, 456, 'Excited for graduation!', '2024-11-05 13:00:00'),
(5, 567, 'Can’t wait for the weekend!', '2024-11-05 14:00:00');

INSERT udemy_L VALUES
(123, 2, '2024-11-05 10:30:00'),  -- Alice likes Bob's post
(234, 1, '2024-11-05 11:30:00'),  -- Bob likes Alice's post
(456, 3, '2024-11-05 13:30:00'),  -- David likes Charlie's post
(567, 4, '2024-11-05 14:30:00');  -- Eve likes David's post

-- Solution : 
-- If two users with ids 123 and 456 are friends, then (123, 456) and (456, 123) will both appear in the Friends relation. Please use U, F, P, and L for the relation names in your queries.
-- Write a SQL Query to find user ids of users that have no friends.

select * from udemy_U;
select * from udemy_F;
select * from udemy_P;
select * from udemy_L;

select uid
from udemy_U;  -- 5 users

select uid1
from udemy_F
union
select uid1
from udemy_F;  -- 4 users who are each others' friends

select uid
from udemy_U
where uid not in (select uid1 from udemy_F UNION select uid2 from udemy_F);  -- gives the user(s) who have no friends

select user_name
from udemy_U
where uid not in (select uid1 from udemy_F UNION select uid2 from udemy_F);  -- gives the names of the user(s) who have no friends

-- *********** *********** *********** *********** Day#2 : *********** *********** *********** *********** ************
-- *********** *********** *********** ******8th Nov 2024 @3:30am ********* *********** *********** *********** *********** 
-- *********** *********** *********** *********** *********** *********** *********** *********** *********************** 

-- Assignment#1 : 

CREATE TABLE udemy_12_employee_table
(
    emp_No INT PRIMARY KEY,
    emp_Name VARCHAR(255),
    Department VARCHAR(255),
    Dateofjoining DATE,
    Salary INT,
    Sex CHAR(1)
);

INSERT udemy_12_employee_table VALUES
(1, 'Raja', 'Computer', '1998-05-21', 80000, 'M'),
(2, 'Sangita', 'History', '1997-05-21', 90000, 'F'),
(3, 'Ritu', 'Sociology', '1998-08-29', 80000, 'F'),
(4, 'Kumar', 'Linguistics', '1996-06-13', 100000, 'M'),
(5, 'Venkatraman', 'History', '1999-10-31', 80000, 'M'),
(6, 'Sidhu', 'Computer', '1986-05-21', 140000, 'M'),
(7, 'Aishwarya', 'Sociology', '1998-11-01', 120000, 'F');

select * from udemy_12_employee_table;

-- (a) To select all the information of teacher in computer department.
select *
from udemy_12_employee_table
where department = 'Computer';
-- (b) To list the name of the female teacher in History department.
select emp_name
from udemy_12_employee_table
where sex='F' and department='History';
-- (c) To list all names of teachers with date of admission in ascending order.
select emp_name, dateofjoining
from udemy_12_employee_table
order by dateofjoining;
-- (d) To display Teacher's name, Department, and Salary of female teachers.
select emp_name, department, salary
from udemy_12_employee_table
where sex='F';
-- (e) To count the number of teachers whose salary is less than 10,000.
select count(*)
from udemy_12_employee_table
where salary<10000;
-- (f) To insert a new record in the Teachers table with the following data: 8, “Mersa”, “Computer”, {1/1/2000}, 12000, “M”.
insert udemy_12_employee_table values
(8, 'Mersa', 'Computer', '2000-01-01', 12000, 'M');


-- Assignment#2 : 
drop table udemy_12_Flights;
drop table udemy_12_Aircraft;
drop table udemy_12_Certified;
drop table udemy_12_Employees;


CREATE TABLE udemy_12_Flights
(
    flno INT PRIMARY KEY,
    from_city VARCHAR(50),
    to_city VARCHAR(50),
    distance INT,
    departs TIME,
    arrives TIME,
    price INT
);

CREATE TABLE udemy_12_Aircraft
(
    aid INT PRIMARY KEY,
    aname VARCHAR(50),
    cruisingrange INT
);

CREATE TABLE udemy_12_Employees
(
    eid INT PRIMARY KEY,
    ename VARCHAR(50),
    salary INT
);

CREATE TABLE udemy_12_Certified
(
    eid INT,
    aid INT,
    PRIMARY KEY (eid, aid),
    FOREIGN KEY (eid) REFERENCES udemy_12_Employees(eid),
    FOREIGN KEY (aid) REFERENCES udemy_12_Aircraft(aid)
);

INSERT udemy_12_Flights VALUES
(101, 'New York', 'Los Angeles', 2475, '10:00:00', '15:00:00', 300),
(102, 'Chicago', 'Miami', 1330, '12:00:00', '15:30:00', 250),
(103, 'Dallas', 'Seattle', 1850, '9:00:00', '13:30:00', 320);

INSERT udemy_12_Aircraft VALUES
(1, 'Boeing 777', 7000),
(2, 'Airbus A380', 8500),
(3, 'Boeing 737', 5500);

INSERT udemy_12_Employees VALUES
(10, 'John Doe', 80000),
(20, 'Jane Smith', 75000),
(30, 'Mike Johnson', 90000);

INSERT udemy_12_Certified VALUES
(10, 1),
(10, 2),
(20, 3),
(30, 1),
(30, 3);

select * from udemy_12_Flights;
select *  from udemy_12_Aircraft;
select * from udemy_12_Certified;
select * from udemy_12_Employees;


-- a. Find the names of aircraft such that all pilots certified to operate them earn more than $80,000.
select a.aname
from udemy_12_Aircraft a
join udemy_12_Certified c on a.aid=c.aid
join udemy_12_Employees e on c.eid=e.eid
where e.salary>80000;

-- b. For each pilot who is certified for more than 1 aircraft, find the eid and the maximum cruisingrange of the aircraft for which she or he is certified.
select e.eid, max(a.cruisingrange)
from udemy_12_Employees e
join udemy_12_Certified c on e.eid=c.eid
join udemy_12_Aircraft a on c.aid=a.aid
group by e.eid
having count(c.aid)>1;

-- c. Find the names of pilots whose salary is less than the price of the cheapest route from Los Angeles to New York.
select e.ename, e.salary, min(f.price)
from udemy_12_Employees e
join udemy_12_Flights f
where to_city='Los Angeles' and from_city= 'New York'
group by e.ename, e.salary
having e.salary < min(f.price);

-- d. For all aircraft with cruisingrange over 1000 miles, find the name of the aircraft and the average salary of all pilots certified for this aircraft.
select a.aname, a.cruisingrange, avg(e.salary)
from udemy_12_Aircraft a
join udemy_12_Certified c on a.aid=c.aid
join udemy_12_Employees e on c.eid=e.eid
where a.cruisingrange>1000
group by a.aname, a.cruisingrange;

-- e. Find the names of pilots certified for Boeing aircrafts.
select e.ename, a.aname
from udemy_12_Employees e
join udemy_12_Certified c on e.eid=c.eid
join udemy_12_Aircraft a on c.aid=a.aid
where a.aname like '%Boeing%';

