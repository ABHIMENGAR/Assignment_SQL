create table company1 ( EID int, Ename varchar(20), Department varchar(20), Salary money )

insert into company1 values
(101,'ABHI','DEVOPS',70000),
(102,'RAJ','CLOUD',50000),
(103,'HARSH','IT',65000),
(104,'NAND','QA',85000)
(103,'HARSH','IT',65000),
(104,'NAND','QA',85000),
(105,'YOGESH','CLOUD',90000),
(106,'NAND','QA',85000)



SELECT * FROM COMPANY1


-- 1. Write a query to display each Department and the total number of employees working in that department from the Employee table.
 
 SELECT DEPARTMENT,
 COUNT (*) AS TOTAL_EMPLOYEES
 FROM COMPANY1
 GROUP BY DEPARTMENT

 -- 2.Write a query to find the Department, the highest salary (MAX), and the average salary (AVG) for each department.

 SELECT DEPARTMENT,
 MAX(SALARY) AS HIGHEST_SALARY,
 AVG(SALARY) AS LOWEST_SALARY
 FROM COMPANY1
 GROUP BY DEPARTMENT

 -- 3. Write a query to count how many employees are in each Department.

 SELECT DEPARTMENT,
 COUNT (*) AS TOTAL_EMPLOYEES
 FROM COMPANY1
 GROUP BY Department

-- 4. Write a query to find the minimum salary in each Department

SELECT DEPARTMENT,
MIN(SALARY) AS MIN_SAL
FROM COMPANY1
GROUP BY DEPARTMENT

-- 5. Write a query to show departments that have more than 2 employees

SELECT DEPARTMENT,
COUNT (*) AS TOTAL_EMPLOYEE
FROM COMPANY1
GROUP BY DEPARTMENT
HAVING COUNT (*) > 2;

-- 6. Write a query to show departments where the total salary payout is greater than 100,000
 
SELECT DEPARTMENT,
SUM (SALARY) AS TOTAL_PAYOUT
FROM COMPANY1
GROUP BY DEPARTMENT
HAVING SUM(SALARY) > 100000;

-- 7. Write a query to find departments where the average salary is above 60,000

SELECT DEPARTMENT,
AVG (SALARY) AS AVG_SAL
FROM COMPANY1
GROUP BY DEPARTMENT
HAVING AVG(SALARY) > 60000;

-- 8. Write a query to show departments that have exactly 1 employee

SELECT DEPARTMENT,
COUNT (*) AS TOTAL_EMPLOYEE
FROM COMPANY1
GROUP BY DEPARTMENT
HAVING COUNT (*) = 1;

--- 9. Write a query to list all employees sorted by Salary from highest to lowest

SELECT *
FROM COMPANY1
ORDER BY SALARY DESC 

-- 10.Write a query to list all employees sorted by Ename in alphabetical order

SELECT *
FROM COMPANY1
ORDER BY ENAME ASC

-- 11.Write a query to list all employees sorted by Department alphabetically, and then by Ename alphabetically

SELECT *
FROM COMPANY1
ORDER BY DEPARTMENT ASC, ENAME ASC



