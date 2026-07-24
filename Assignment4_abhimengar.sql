-- 1. Create a database named CompanyDB.

CREATE DATABASE CompanyDB;

-- 2. Use the CompanyDB database and create the Employee table with all the columns mentioned above.

USE Database CompanyDB

CREATE TABLE Employee
(
    EmpID INT,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Department VARCHAR(30),
    Designation VARCHAR(30),
    Salary DECIMAL(10,2),
    City VARCHAR(30),
    Gender CHAR(1),
    JoiningDate DATE,
    Age INT
);

-- 3. Add a new column Email to the Employee table.

ALTER TABLE Employee
ADD Email VARCHAR(50);

-- 4. Modify the Email column to increase its size.

ALTER TABLE Employee
ALTER COLUMN Email VARCHAR(100);

-- 5. Rename the column City to Location.

 sp_rename 'Employee.City', 'Location', 'COLUMN';

-- 6. Rename the table Employee to EmployeeDetails and then rename it back to Employee.

 sp_rename 'Employee', 'EmployeeDetails';
 sp_rename 'EmployeeDetails', 'Employee';

-- 7. Drop the Email column from the Employee table.

ALTER TABLE Employee
DROP COLUMN Email;

-- 8. Write a query to check the structure (columns and data types) of the Employee table.

sp_help Employee;

-- 9. Make EmpID column the Primary Key of the Employee table.

ALTER TABLE Employee
ALTER COLUMN EmpID INT NOT NULL;

ALTER TABLE Employee
ADD CONSTRAINT PK_Employee PRIMARY KEY (EmpID);

-- 10. Add a NOT NULL constraint on the FirstName column.

ALTER TABLE Employee
ALTER COLUMN FirstName VARCHAR(30) NOT NULL;

-- 11.Add a UNIQUE constraint on the column to ensure no two employees have the same email (create a new column Email and apply the constraint).

ALTER TABLE Employee
ADD Email VARCHAR(100);

ALTER TABLE Employee
ADD CONSTRAINT UQ_Email UNIQUE(Email);

-- 12. Add a DEFAULT constraint on the Department column so that if no value is provided, it should be set as 'General'.

ALTER TABLE Employee
ADD CONSTRAINT DF_Department
DEFAULT 'General' FOR Department;

-- 13. Add a CHECK constraint on the Salary column so that salary cannot be less than 10,000.

ALTER TABLE Employee
ADD CONSTRAINT CHK_Salary
CHECK (Salary>=10000);

-- 14.Add a CHECK constraint on the Age column so that age must be between 18 and 60.

ALTER TABLE Employee
ADD CONSTRAINT CHK_Age
CHECK(Age BETWEEN 18 AND 60);

-- 15. Remove the CHECK constraint applied on the Salary column.

ALTER TABLE Employee
DROP CONSTRAINT CHK_Salary;

-- 16. Add a FOREIGN KEY unrelated simple self-constraint task: add a Manager_EmpID column and apply a CHECK constraint so it cannot be equal to EmpID itself.Manager_EmpID

ALTER TABLE Employee
ADD Manager_EmpID INT;

ALTER TABLE Employee
ADD CONSTRAINT CHK_Manager
CHECK(Manager_EmpID<>EmpID);

-- 17 Insert 15 records into the Employee table with different departments, cities, and salaries.
INSERT INTO Employee
VALUES
(1,'Amit','Sharma','IT','Manager',60000,'Delhi','M','2021-01-15',35,'amit@gmail.com',2),
(2,'Neha','Patel','HR','Executive',25000,'Mumbai','F','2022-03-10',28,'neha@gmail.com',1),
(3,'Rahul','Verma','Finance','Analyst',32000,'Pune','M','2020-06-20',30,'rahul@gmail.com',1),
(4,'Anita','Singh','Sales','Executive',22000,'Delhi','F','2023-02-11',26,'anita@gmail.com',1),
(5,'Karan','Joshi','IT','Executive',28000,'Mumbai','M','2022-05-01',29,'karan@gmail.com',1),
(6,'Priya','Kapoor','HR','Manager',50000,'Ahmedabad','F','2019-09-12',40,'priya@gmail.com',NULL),
(7,'Rohan','Shah','Finance','Executive',18000,'Pune','M','2023-01-18',25,'rohan@gmail.com',3),
(8,'Sneha','Desai','Sales','Analyst',27000,'Mumbai','F','2021-07-09',31,'sneha@gmail.com',4),
(9,'Arjun','Mehta','IT','Analyst',45000,'Delhi','M','2020-11-23',33,'arjun@gmail.com',1),
(10,'Meera','Nair','Finance','Executive',14000,'Chennai','F','2023-04-12',24,'meera@gmail.com',3),
(11,'Ajay','Patil','Sales','Manager',55000,'Pune','M','2018-08-08',42,'ajay@gmail.com',NULL),
(12,'Pooja','Yadav','HR','Analyst',24000,'Mumbai','F','2021-12-19',27,'pooja@gmail.com',6),
(13,'Vikas','Rao','IT','Executive',35000,'Hyderabad','M','2019-05-05',36,'vikas@gmail.com',1),
(14,'Asha','Kumari','Finance','Manager',65000,'Delhi','F','2017-10-15',45,'asha@gmail.com',NULL),
(15,'Nitin','Gupta','Sales','Executive',16000,'Mumbai','M','2022-08-20',23,'nitin@gmail.com',11);

--18 Insert a new employee record without specifying the Department (to check the DEFAULT constraint).
INSERT INTO Employee
(EmpID,FirstName,LastName,Designation,Salary,Location,Gender,JoiningDate,Age,Email,Manager_EmpID)
VALUES
(16,'Riya','Sharma','Executive',26000,'Delhi','F','2024-01-10',24,'riya@gmail.com',2);

-- 19.Update the salary of all employees working in the IT department by increasing it by 10%.
UPDATE Employee
SET Salary=Salary*1.10
WHERE Department='IT';

--20 Update the Designation of an employee whose EmpID is 5 to 'Senior Executive'.
UPDATE Employee
SET Designation='Senior Executive'
WHERE EmpID=5;

--21 Delete the record of an employee whose EmpID is 10.
DELETE FROM Employee
WHERE EmpID=10;

--22 Delete all employees whose Salary is less than 15,000.
DELETE FROM Employee
WHERE Salary<15000;

--23 Update the City of all employees from 'Mumbai' to 'Pune'.
UPDATE Employee
SET Location='Pune'
WHERE Location='Mumbai';

--24 Insert a record and intentionally leave FirstName blank to check if the NOT NULL constraint blocks it.
INSERT INTO Employee
(EmpID,LastName,Department,Designation,Salary,Location,Gender,JoiningDate,Age,Email)
VALUES
(17,'Test','IT','Executive',25000,'Delhi','M','2024-02-01',25,'test@gmail.com');

--25 Write a query to display all the records from the Employee table.
SELECT * FROM Employee;

--26 Write a query to display FirstName, LastName, and Salary of all employees.
SELECT FirstName,LastName,Salary FROM Employee;

--27 Write a query to display the details of employees working in the 'HR' department.
SELECT * FROM Employee
WHERE Department='HR';

--28 Write a query to display all distinct Department names from the table.
SELECT DISTINCT Department FROM Employee;

--29 Write a query to display the total number of employees in the table.
SELECT COUNT(*) AS TotalEmployees
FROM Employee;

--30 Write a query to display FirstName and Salary and rename the Salary column as
MonthlySalary using an alias.
SELECT FirstName,
Salary AS MonthlySalary
FROM Employee;

--31 Write a query to display all employee details whose Gender is 'F'.
SELECT * FROM Employee
WHERE Gender='F';

--32 Write a query to display the top 5 highest paid employees.
SELECT TOP 5 *
FROM Employee
ORDER BY Salary DESC;

--33 Display all employees whose Salary is greater than 30,000 (comparison operator).
SELECT * FROM Employee
WHERE Salary>30000;

--34 Display all employees whose Department is 'IT' AND Salary is greater than 25,000 (logical operator).
SELECT *
FROM Employee
WHERE Department='IT'
AND Salary>25000;

--35 Display all employees whose Department is 'HR' OR 'Finance'.
SELECT *
FROM Employee
WHERE Department IN('HR','Finance');

--36 Display all employees whose Salary is BETWEEN 20,000 and 40,000.
SELECT *
FROM Employee
WHERE Salary BETWEEN 20000 AND 40000;

--37 Display all employees whose City IN ('Delhi', 'Mumbai', 'Pune').
SELECT *
FROM Employee
WHERE Location IN('Delhi','Mumbai','Pune');

--38 Display all employees whose FirstName LIKE starts with 'A'.
SELECT *
FROM Employee
WHERE FirstName LIKE 'A%';

--39 Display all employees whose FirstName LIKE ends with 'a'.
SELECT *
FROM Employee
WHERE FirstName LIKE '%a';

--40 Display all employees whose Department is NOT 'Sales' (NOT operator).
SELECT *
FROM Employee
WHERE Department<>'Sales';

--41 Display the total number of employees in each department.
SELECT Department,
COUNT(*) EmployeeCount
FROM Employee
GROUP BY Department;

--42 Display the average salary of employees department-wise.
SELECT Department,
AVG(Salary) AverageSalary
FROM Employee
GROUP BY Department;

--43 Display the maximum salary in each department.
SELECT Department,
MAX(Salary) MaximumSalary
FROM Employee
GROUP BY Department;

--44 Display the minimum salary city-wise.
SELECT Location,
MIN(Salary) MinimumSalary
FROM Employee
GROUP BY Location;

--45 Display the total salary paid, grouped by Designation.
SELECT Designation,
SUM(Salary) TotalSalary
FROM Employee
GROUP BY Designation;
  
--46 Display departments having more than 3 employees.
SELECT Department,
COUNT(*) EmployeeCount
FROM Employee
GROUP BY Department
HAVING COUNT(*)>3;

--47 Display departments whose average salary is greater than 30,000.
SELECT Department,
AVG(Salary) AverageSalary
FROM Employee
GROUP BY Department
HAVING AVG(Salary)>30000;

--48 Display cities having a total employee count greater than 2.
SELECT Location,
COUNT(*) EmployeeCount
FROM Employee
GROUP BY Location
HAVING COUNT(*)>2;

--49 Display all employee records sorted by Salary in descending order.
SELECT *
FROM Employee
ORDER BY Salary DESC;

--50 Display all employee records sorted by Department (ascending) and then by Salary(descending).
SELECT *
FROM Employee
ORDER BY Department ASC, Salary DESC;