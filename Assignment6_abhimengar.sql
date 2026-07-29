create database joins
use joins

create table employee
(emp_id int,
emp_name varchar(20),
department_id int,
designation varchar(20),
salary money,
join_date date,
manager_id int)

create table departments
(department_id int,
department_name varchar(20),
location varchar(20) ,
budget money)

insert into employee values
(101,'abhi',123,'network eng.',78000,'2010-08-05',111),
(102,'raj',124,'data analyst',90000,'2023-08-07',222),
(103,'rajesh',125,'data eng.',60000,'2020-09-10',333),
(104,'mahesh',126,'network eng.',56000,'2011-09-08',444),
(105,'mohit',127,'web devloper.',33000,'2010-05-15',555),
(106,'kashyap',128,'cloud eng.',9000,'2024-10-05',666),
(107,'nirmal',129,'data analyst',20000,'2022-07-05',777)

insert into departments values
(123,'network','vadodara',125000),
(124,'data','ahmedabad',100000),
(125,'data','bharuch',78000),
(126,'network','ahmedabad',70000),
(127,'develpoment','ankleshwar',55000),
(128,'cloud','vadodara',12000),
(129,'data','valsad',25000),
(130,'network','vapi',95000),
(131,'cloud','mumbai',125000)







-- 1
SELECT emp_name, department_name
FROM Employee 
INNER JOIN Departments 
ON employee.department_id = departments.department_id

-- 2
SELECT emp_name, department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id

-- 3
SELECT department_name, emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 4
SELECT emp_name, designation, department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id

-- 5
SELECT department_name, location, emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 6
SELECT e.emp_name, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id

-- 7
SELECT emp_name, salary, department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id

-- 8
SELECT department_name, budget, emp_name, salary
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 9
SELECT *, department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id

-- 10
SELECT emp_name, designation, location
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id

-- 11
SELECT department_name, COUNT(emp_id) AS employee_count
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id
GROUP BY d.department_name

-- 12
SELECT emp_name, join_date, department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id

-- 13
SELECT department_name, emp_name, salary
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 14
SELECT emp_name, department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id

-- 15
SELECT emp_name, department_name, budget
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id
WHERE d.budget > 89000

-- 16
SELECT department_name, location, emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 17
SELECT emp_name, designation, department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id

-- 18
SELECT emp_name, location
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id

-- 19
SELECT department_name, emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 20
SELECT emp_name, salary, department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id

-- 21
SELECT emp_name, manager_id, department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id

-- 22
SELECT department_name, budget, emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 23
SELECT emp_name, department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id

-- 24
SELECT department_name, location, emp_name
FROM Departments d
INNER JOIN Employee e
ON d.department_id = e.department_id

-- 25
SELECT department_name, emp_name, designation
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 26
SELECT emp_name, department_name, join_date
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id

-- 27
SELECT emp_name, department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id

-- 28
SELECT department_name, budget, emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 29
SELECT emp_name, salary
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id
WHERE d.budget > 78000

-- 30
SELECT *, department_name, location
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id

-- 31
SELECT department_name, emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 32
SELECT emp_name, designation, department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id

-- 33
SELECT department_name, budget, emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 34
SELECT emp_name, department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id

-- 35
SELECT emp_name, salary, department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id

-- 36
SELECT *, emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 37
SELECT emp_name, department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id

-- 38
SELECT emp_name, department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id

-- 39
SELECT d.department_name, d.location, e.emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 40
SELECT e.emp_name, e.designation, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id

-- 41
SELECT e.emp_name, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id

-- 42
SELECT d.department_name, e.emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 43
SELECT e.emp_name, e.salary, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id

-- 44
SELECT e.*, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id

-- 45
SELECT d.department_name, e.emp_name, d.location, d.budget
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 46
SELECT e.emp_name, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id

-- 47
SELECT e.emp_name, e.designation, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id

-- 48
SELECT d.department_name, d.budget, e.emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id

-- 49
SELECT e.emp_name, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id

-- 50(a) Keep all employees
SELECT e.emp_name, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id

-- 50(b) Keep all departments
SELECT e.emp_name, d.department_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id




