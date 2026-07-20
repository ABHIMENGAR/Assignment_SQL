-- Literal SELECT Statement Practice Problems
-- 1) Execute a literal select statement that returns your name.

select 'Abhi' as name 

-- 2) Write the literal select statement that evaluates the product of 7 and 4.

select 7*4 

-- 3) Write the literal select statement that takes the difference of 7 and 4 then multiplies that difference by 8.

select (7-4)*8

-- 4) Write a literal select statement that returns the phrase “Brewster’s SQL Training Class”. (Hint: note the single apostrophe in the string).

select 'Brewster’s SQL Training Class' as phrase

-- 5) Execute a literal SELECT statement that returns the phrase “Day 1 of Training” in one column and the result of 5*3 in another column.

select 'Day 1 of Training' as name, 5*3 as result 

--Insert/Update/Delete
--1. Insert a new employee record with all details provided directly.

use july2026

create table employee
( EMPID INT, EMPNAME Varchar(26), EMPSALARY Money, EMPDEP varchar(26) )

select * from employee

Insert into employee values 
(101,'Abhi',25000,'DEVOPS'),
(102,'Raj',28000,'CLOUD'), 
(103,'Vraj',23000,'QA') 

--2. Add multiple new team members to the HR department at once.


Insert into employee values 
(104,'Yogesh',21000,'HR'),
(105,'Mohit',22800,'HR'), 
(106,'Aniket',23500,'HR') 

-- 3. Register an employee who hasn't been assigned a salary yet.

 Insert into employee values 
 (107,'Pratik',NULL,'HR'),
 (108,'Dev',NULL,'HR')

--  4. Update the salary to 85,000 for everyone working in the 'Cloud' department.

update employee set EMPSALARY = 85000 where EMPDEP = 'CLOUD'

-- 5. Change both the department and salary for a specific employee by name.

update employee set EMPSALARY = 50000, EMPDEP = 'FULLSTACK' 
where EMPNAME = 'Mohit'

-- 6. Give a flat 10% appraisal boost to employee working in AI department.

Insert into employee values 
(109,'Kush',29300,'ML'),
(110,'Manav',22500,'AI')

update employee 
set EMPSALARY = EMPSALARY * 1.1
where EMPDEP = 'AI' 

-- 7. Assign an initial entry-level salary of 30,000 to anyone whose salary column is completely blank (NULL).

update employee
set EMPSALARY = 30000
where EMPSALARY is NULL 

-- 8.Remove a specific employee from the system using their unique ID.

delete employee
where EMPID = 108

-- 9. Remove all records belonging to a department that has been completely shut down.

delete employee
where EMPDEP = 'QA'  

-- 10.Drop records of any employee earning less than 20,000 in the Finance division.

Insert into employee values 
(111,'Nil',17000,'FINANCE'),
(112,'kashyap',29000,'FINANCE')

delete from employee
where EMPDEP = 'FINANCE'
and EMPSALARY < 20000


select * from employee 
order by EMPID

