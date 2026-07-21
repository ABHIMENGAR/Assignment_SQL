create table company 
( EmployeeID INT PRIMARY KEY, Name varchar (20), Department varchar (20), Salary money, Bonus int, Experience varchar (20), City varchar(20) )

select * from company

Insert into company values
( 101, 'Abhi', 'Cloud', 50000, 2000, 1 , 'Vadodara')

Insert into company values
( 102, 'Raj', 'DevOps', 48000, 5000, 2 , 'Surat')

delete from company where EmployeeID = 102

update company
set Experience = 2 
where  EmployeeID = 102;

Insert into company values
( 103, 'Mohit', 'IT', 85000, 7500, 9 , 'Rajkot'),
( 104, 'Yogesh', 'IT', 95600, 3000, 12 , 'Morbi')
( 105, 'Mann', 'AI', 72000, 4000, 6 , 'Nadiad'),
( 106, 'Akash', 'ML', 69600, 3500, 7 , 'Anand')

-- 1. Write a query to display all employees whose salary is greater than 50,000.

Select * from company where Salary>50000

-- 2) Retrieve employees who work in the IT department and have more than 5 years of experience.

Select * from company where Department = 'IT' And Experience>5

-- 3) Write a query to display employees whose salary is between 45,000 and 60,000.
 
 Select * from company where Salary between 45000 and 60000

-- 4) Display employees whose city is either Mumbai or Delhi.

Select * from company where City = 'Delhi' or City = 'Mumbai'

update company
set City = 'Delhi'
where  EmployeeID = 106; 

-- 5) Write a query to display employee name along with their annual income

Select Name,Salary from company

-- 6) Find employees whose name starts with the letter 'A'.

Select * from company where name like 'A%'

-- 7) Find the highest salary among all employees.

select max(Salary) as highestsalary from company

-- 8) Find the total bonus paid to employees in the IT department.

select Sum (Salary) as total_bonus 
from company 
where Department = 'IT'

-- 9) Display the minimum and maximum experience of employees.

select 
min(experience) as 'minimum experience',
max(experience) as 'maximum experience'
from company 

-- 10) Count the number of employees in each department.
select 
Department, count(*) as Employee_Count
from company 
group by Department; 

-- 11) Count the number of employees in each department.

select Sum (Salary) as total_bonus 
from company 
where Department = 'IT'

-- 12) Write an SQL statement to add a new column named Email of type VARCHAR(100) to the Employees table.

alter table  company 
add Email varchar (100);

-- 13) Write an SQL statement to modify the Salary column so that it becomes DECIMAL(10,2).

alter table company
alter column Salary DECIMAL(10,2);

-- 14) Write an SQL statement to drop the Bonus column from the Employees table.

alter table company 
drop column bonus


