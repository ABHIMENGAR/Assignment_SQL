-- Q1. Create a database for the college records.
CREATE DATABASE CollegeDB;
USE CollegeDB;

-- Q2. Create the Department table.
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,                   
    DepartmentName VARCHAR(50) NOT NULL
);

-- Q3. Create the Student table with all required columns.
CREATE TABLE Student (
    RollNo INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Course VARCHAR(50),
    Marks INT,
    City VARCHAR(50),
    Gender CHAR(1),
    Age INT,
    AdmissionDate DATE,
    Fee DECIMAL(10, 2),
    DepartmentID INT
);

-- Q4. Add a new column to the Student table to store the student's email address.
ALTER TABLE Student ADD Email VARCHAR(100);

-- Q5. Modify the data type/size of the email column you just added.
ALTER TABLE Student ALTER COLUMN Email VARCHAR(150);

-- Q6. Rename the newly added email column to something more suitable.
 sp_rename 'Student.Email', 'StudentEmail', 'COLUMN';

-- Q7. Drop the email column from the Student table.
ALTER TABLE Student DROP COLUMN StudentEmail;

-- Q8. Rename the Student table to StudentRecords and then rename it back to Student.
 sp_rename 'Student', 'StudentRecords';
 sp_rename 'StudentRecords', 'Student';

-- Q9. Write a query to view the complete structure of the Student table.
sp_help 'Student';

-- Q10. Write a query to view the complete structure of the Department table.
 sp_help 'Department';

-- Q11. Truncate all the data from the Department table and recreate it.

TRUNCATE TABLE Department;

-- Q12. Drop the Department table and create it again with the same structure.

DROP TABLE Student; 
DROP TABLE Department;

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

CREATE TABLE Student (
    RollNo INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Course VARCHAR(50),
    Marks INT,
    City VARCHAR(50),
    Gender CHAR(1),
    Age INT,
    AdmissionDate DATE,
    Fee DECIMAL(10, 2),
    DepartmentID INT
);


-- Q13. Set the primary key on the Department table.
ALTER TABLE Department ADD CONSTRAINT PK_Department PRIMARY KEY (DepartmentID);

-- Q14. Set the primary key on the Student table.
 ALTER TABLE Student ADD CONSTRAINT PK_Student PRIMARY KEY (RollNo);

-- Q15. Add a foreign key on the Student table that references the Department table.
ALTER TABLE Student ADD CONSTRAINT FK_Student_Department 
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);

-- Q16. Try inserting a student record with a department value that does not exist in the Department table and observe the result.
 INSERT INTO Student (RollNo, StudentName, DepartmentID) VALUES (999, 'Invalid Dept Test', 99); 

-- Q17. Apply a NOT NULL constraint on the student's name column.
ALTER TABLE Student ALTER COLUMN StudentName VARCHAR(100) NOT NULL;

-- Q18. Apply a NOT NULL constraint on the course column.
ALTER TABLE Student ALTER COLUMN Course VARCHAR(50) NOT NULL;

-- Q19. Apply a UNIQUE constraint on a column that stores each student's roll number.
ALTER TABLE Student ADD CONSTRAINT UQ_RollNo UNIQUE (RollNo);

-- Q20. Apply a UNIQUE constraint on the email column (add the column again if dropped).
ALTER TABLE Student ADD Email VARCHAR(100);
ALTER TABLE Student ADD CONSTRAINT UQ_Student_Email UNIQUE (Email);

-- Q21. Apply a DEFAULT constraint on the city column with a default value of your choice.
ALTER TABLE Student ADD CONSTRAINT DF_Student_City DEFAULT 'Delhi' FOR City;

-- Q22. Apply a DEFAULT constraint on the fee column with a default value.
ALTER TABLE Student ADD CONSTRAINT DF_Student_Fee DEFAULT 15000.00 FOR Fee;

-- Q23. Apply a CHECK constraint on the marks column so that marks cannot be negative or greater than 100.
ALTER TABLE Student ADD CONSTRAINT CK_Student_Marks CHECK (Marks BETWEEN 0 AND 100);

-- Q24. Apply a CHECK constraint on the age column so that age must be greater than or equal to 15.
ALTER TABLE Student ADD CONSTRAINT CK_Student_Age CHECK (Age >= 15);

-- Q25. Apply a CHECK constraint on the gender column so that only 'M' or 'F' can be entered.
ALTER TABLE Student ADD CONSTRAINT CK_Student_Gender CHECK (Gender IN ('M', 'F'));

-- Q26. Remove the CHECK constraint applied on the age column.
ALTER TABLE Student DROP CONSTRAINT CK_Student_Age;

-- Q27. Remove the UNIQUE constraint applied on the roll number column.
ALTER TABLE Student DROP CONSTRAINT UQ_RollNo;

-- Q28. Remove the DEFAULT constraint applied on the fee column.
ALTER TABLE Student DROP CONSTRAINT DF_Student_Fee;

-- Q29. Remove the foreign key constraint from the Student table.
ALTER TABLE Student DROP CONSTRAINT FK_Student_Department;

-- Q30. Add the foreign key constraint back to the Student table.
ALTER TABLE Student ADD CONSTRAINT FK_Student_Department 
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);

-- Q31. Remove the primary key from the Department table and then reapply it.
ALTER TABLE Student DROP CONSTRAINT FK_Student_Department;
ALTER TABLE Department DROP CONSTRAINT PK__Departme__B2079BCD 
ALTER TABLE Department ADD CONSTRAINT PK_Department PRIMARY KEY (DepartmentID);
ALTER TABLE Student ADD CONSTRAINT FK_Student_Department FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);

-- Q32. Try deleting a department from the Department table that is still referenced by a student and observe the result.
DELETE FROM Department WHERE DepartmentID = 1; 

-- Q33. Insert 5 records into the Department table.
INSERT INTO Department (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Commerce'),
(3, 'Arts'),
(4, 'Management'),
(5, 'Science');

-- Q34. Insert 20 records into the Student table with varied courses, cities, marks, and fees.
INSERT INTO Student (RollNo, StudentName, Course, Marks, City, Gender, Age, AdmissionDate, Fee, DepartmentID, Email) VALUES
(101, 'Aarav Sharma', 'Computer Science', 85, 'Delhi', 'M', 20, '2023-07-15', 25000.00, 1, 'aarav@mail.com'),
(102, 'Ananya Verma', 'Commerce', 92, 'Jaipur', 'F', 19, '2023-08-01', 18000.00, 2, 'ananya@mail.com'),
(103, 'Siddharth Patel', 'Computer Science', 65, 'Ahmedabad', 'M', 21, '2022-07-10', 25000.00, 1, 'sid@mail.com'),
(104, 'Sanya Gupta', 'Arts', 78, 'Delhi', 'F', 18, '2023-09-12', 12000.00, 3, 'sanya@mail.com'),
(105, 'Rohan Mehta', 'Management', 45, 'Mumbai', 'M', 22, '2021-06-20', 35000.00, 4, 'rohan@mail.com'),
(106, 'Priya Singh', 'Computer Science', 95, 'Jaipur', 'F', 20, '2023-07-18', 25000.00, 1, 'priya@mail.com'),
(107, 'Karan Joshi', 'Commerce', 30, 'Delhi', 'M', 18, '2023-08-15', 18000.00, 2, 'karan@mail.com'),
(108, 'Neha Kapoor', 'Science', 88, 'Ahmedabad', 'F', 19, '2023-07-11', 22000.00, 5, 'neha@mail.com'),
(109, 'Simran Kaur', 'Arts', 55, 'Chandigarh', 'F', 20, '2022-08-22', 12000.00, 3, 'simran@mail.com'),
(110, 'Aman Rai', 'Computer Science', 72, 'Delhi', 'M', 21, '2022-07-01', 25000.00, 1, 'aman@mail.com'),
(111, 'Sneha Jain', 'Commerce', 60, 'Jaipur', 'F', 19, '2023-08-10', 18000.00, 2, 'sneha@mail.com'),
(112, 'Varun Nair', 'Management', 40, 'Ahmedabad', 'M', 23, '2021-07-14', 35000.00, 4, 'varun@mail.com'),
(113, 'Pooja Shah', 'Science', 91, 'Mumbai', 'F', 20, '2023-07-25', 22000.00, 5, 'pooja@mail.com'),
(114, 'Sahil Khan', 'Arts', 32, 'Delhi', 'M', 18, '2023-09-01', 12000.00, 3, 'sahil@mail.com'),
(115, 'Ishaan Kumar', 'Computer Science', 81, 'Jaipur', 'M', 20, '2023-07-05', 25000.00, 1, 'ishaan@mail.com'),
(116, 'Riya Sen', 'Commerce', 76, 'Ahmedabad', 'F', 19, '2023-08-05', 18000.00, 2, 'riya@mail.com'),
(117, 'Kabir Malhotra', 'Management', 68, 'Delhi', 'M', 22, '2022-06-18', 35000.00, 4, 'kabir@mail.com'),
(118, 'Tanvi Das', 'Science', 96, 'Kolkata', 'F', 20, '2023-07-30', 22000.00, 5, 'tanvi@mail.com'),
(119, 'Shivam Mishra', 'Arts', 50, 'Lucknow', 'M', 21, '2022-09-10', 12000.00, 3, 'shivam@mail.com'),
(120, 'Divya Agarwal', 'Computer Science', 89, 'Delhi', 'F', 19, '2023-07-20', 25000.00, 1, 'divya@mail.com');

-- Q35. Insert a record into the Student table without providing a value for the city column, to check the DEFAULT constraint.
INSERT INTO Student (RollNo, StudentName, Course, Marks, Gender, Age, AdmissionDate, Fee, DepartmentID, Email)
VALUES (121, 'Default City Test', 'Commerce', 70, 'M', 20, '2023-08-01', 18000.00, 2, 'citytest@mail.com');

-- Q36. Insert a record into the Student table without providing a value for the fee column, to check the DEFAULT constraint.

ALTER TABLE Student ADD CONSTRAINT DF_Student_Fee DEFAULT 15000.00 FOR Fee;
INSERT INTO Student (RollNo, StudentName, Course, Marks, City, Gender, Age, AdmissionDate, DepartmentID, Email)
VALUES (122, 'Default Fee Test', 'Arts', 65, 'Delhi', 'F', 19, '2023-08-01', 3, 'feetest@mail.com');

-- Q37. Update the marks of a student whose roll number is a specific value, increasing it by 5.
UPDATE Student SET Marks = Marks + 5 WHERE RollNo = 103;

-- Q38. Update the fee amount of all students belonging to a particular course.
UPDATE Student SET Fee = 26000.00 WHERE Course = 'Computer Science';

-- Q39. Update the city of a student from one city to another.
UPDATE Student SET City = 'Pune' WHERE RollNo = 105;

-- Q40. Update the department of a student to a different valid department.
UPDATE Student SET DepartmentID = 4 WHERE RollNo = 119;

-- Q41. Delete the record of a student with a specific roll number.
DELETE FROM Student WHERE RollNo = 121;

-- Q42. Delete all students whose marks are less than 35.
DELETE FROM Student WHERE Marks < 35;

-- Q43. Delete all students belonging to a particular city.
DELETE FROM Student WHERE City = 'Lucknow';

-- Q44. Insert a record leaving the student name blank and check whether the NOT NULL constraint blocks it.
INSERT INTO Student (RollNo, StudentName, Course) VALUES (123, NULL, 'Arts');

-- Q45. Insert a record with a duplicate roll number and check whether the UNIQUE constraint blocks it.
INSERT INTO Student (RollNo, StudentName, Course) VALUES (101, 'Duplicate Test', 'Arts'); 

-- Q46. Insert a record with age less than the allowed minimum and check whether the CHECK constraint blocks it.

ALTER TABLE Student ADD CONSTRAINT CK_Student_Age CHECK (Age >= 15);
INSERT INTO Student (RollNo, StudentName, Course, Age) VALUES (124, 'Underage Test', 'Arts', 12); 

-- Q47. Update the marks of a student to a value greater than 100 and check whether the CHECK constraint blocks it.
UPDATE Student SET Marks = 105 WHERE RollNo = 101;

-- Q48. Display all students whose marks are greater than 75.
SELECT * FROM Student WHERE Marks > 75;

-- Q49. Display all students whose fee is less than or equal to 20,000.
SELECT * FROM Student WHERE Fee <= 20000;

-- Q50. Display all students whose age is not equal to 18.
SELECT * FROM Student WHERE Age <> 18;

-- Q51. Display all students belonging to the 'Computer Science' course AND having marks greater than 60.
SELECT * FROM Student WHERE Course = 'Computer Science' AND Marks > 60;

-- Q52. Display all students belonging to the 'Computer Science' course OR the 'Commerce' course.
SELECT * FROM Student WHERE Course = 'Computer Science' OR Course = 'Commerce';

-- Q53. Display all students whose marks are BETWEEN 50 and 90.
SELECT * FROM Student WHERE Marks BETWEEN 50 AND 90;

-- Q54. Display all students whose fee is BETWEEN 10,000 and 30,000.
SELECT * FROM Student WHERE Fee BETWEEN 10000 AND 30000;

-- Q55. Display all students whose city is IN ('Delhi', 'Jaipur', 'Ahmedabad').
SELECT * FROM Student WHERE City IN ('Delhi', 'Jaipur', 'Ahmedabad');

-- Q56. Display all students whose course is NOT IN ('Arts', 'Commerce').
SELECT * FROM Student WHERE Course NOT IN ('Arts', 'Commerce');

-- Q57. Display all students whose name starts with the letter 'S' using the LIKE operator.
SELECT * FROM Student WHERE StudentName LIKE 'S%';

-- Q58. Display all students whose name ends with the letter 'n' using the LIKE operator.
SELECT * FROM Student WHERE StudentName LIKE '%n';

-- Q59. Display all students whose name contains the substring 'an' anywhere in it.
SELECT * FROM Student WHERE StudentName LIKE '%an%';

-- Q60. Display all students whose gender is 'F' and marks are greater than 80.
SELECT * FROM Student WHERE Gender = 'F' AND Marks > 80;

-- Q61. Display all students whose department value IS NULL (if any).
SELECT * FROM Student WHERE DepartmentID IS NULL;

-- Q62. Display all students whose department value IS NOT NULL.
SELECT * FROM Student WHERE DepartmentID IS NOT NULL;

-- Q63. Find the total number of students using COUNT.
SELECT COUNT(*) AS TotalStudents FROM Student;

-- Q64. Find the total number of students who belong to the 'Computer Science' course.
SELECT COUNT(*) AS CS_Student_Count FROM Student WHERE Course = 'Computer Science';

-- Q65. Find the total fee collected from all students using SUM.
SELECT SUM(Fee) AS TotalFeeCollected FROM Student;

-- Q66. Find the total fee collected from students of a specific course.
SELECT SUM(Fee) AS TotalCSFee FROM Student WHERE Course = 'Computer Science';

-- Q67. Find the average marks of all students using AVG.
SELECT AVG(Marks) AS AverageMarks FROM Student;

-- Q68. Find the average fee paid by students belonging to a specific city.
SELECT AVG(Fee) AS AvgFeeDelhi FROM Student WHERE City = 'Delhi';

-- Q69. Find the highest marks scored by any student using MAX.
SELECT MAX(Marks) AS HighestMarks FROM Student;

-- Q70. Find the lowest marks scored by any student using MIN.
SELECT MIN(Marks) AS LowestMarks FROM Student;

-- Q71. Find the highest fee paid by any student.
SELECT MAX(Fee) AS HighestFee FROM Student;

-- Q72. Find the lowest fee paid by any student.
SELECT MIN(Fee) AS LowestFee FROM Student;

-- Q73. Find the average age of all students.
SELECT AVG(Age) AS AverageAge FROM Student;

-- Q74. Find the total number of distinct courses offered, using COUNT with DISTINCT.
SELECT COUNT(DISTINCT Course) AS UniqueCourses FROM Student;

-- Q75. Find the total number of distinct cities the students belong to.
SELECT COUNT(DISTINCT City) AS UniqueCities FROM Student;

-- Q76. Find the maximum age among all students.
SELECT MAX(Age) AS MaxAge FROM Student;

-- Q77. Find the minimum age among all students.
SELECT MIN(Age) AS MinAge FROM Student;

-- Q78. Find the sum of marks of all students combined.
SELECT SUM(Marks) AS TotalMarks FROM Student;

-- Q79. Find the average marks of only the female students.
SELECT AVG(Marks) AS FemaleAvgMarks FROM Student WHERE Gender = 'F';

-- Q80. Find the count of students who scored more than 90 marks.
SELECT COUNT(*) AS StudentsAbove90 FROM Student WHERE Marks > 90;

-- Q81. Display the total number of students in each course, using GROUP BY.
SELECT Course, COUNT(*) AS StudentCount FROM Student GROUP BY Course;

-- Q82. Display the average marks of students, grouped by course.
SELECT Course, AVG(Marks) AS AvgMarks FROM Student GROUP BY Course;

-- Q83. Display the total fee collected, grouped by department.
SELECT DepartmentID, SUM(Fee) AS TotalFee FROM Student GROUP BY DepartmentID;

-- Q84. Display the maximum marks scored, grouped by city.
SELECT City, MAX(Marks) AS MaxMarks FROM Student GROUP BY City;

-- Q85. Display the minimum age, grouped by gender.
SELECT Gender, MIN(Age) AS MinAge FROM Student GROUP BY Gender;

-- Q86. Display the count of students, grouped by city.
SELECT City, COUNT(*) AS StudentCount FROM Student GROUP BY City;

-- Q87. Display the average fee, grouped by course and city together.
SELECT Course, City, AVG(Fee) AS AvgFee FROM Student GROUP BY Course, City;

-- Q88. Display the sum of marks, grouped by department.
SELECT DepartmentID, SUM(Marks) AS TotalMarks FROM Student GROUP BY DepartmentID;

-- Q89. Display courses having more than 5 students enrolled, using HAVING.
SELECT Course, COUNT(*) AS StudentCount FROM Student GROUP BY Course HAVING COUNT(*) > 5;

-- Q90. Display cities having an average fee greater than 15,000, using HAVING.
SELECT City, AVG(Fee) AS AvgFee FROM Student GROUP BY City HAVING AVG(Fee) > 15000;

-- Q91. Display departments having a total student count greater than 3, using HAVING.
SELECT DepartmentID, COUNT(*) AS StudentCount FROM Student GROUP BY DepartmentID HAVING COUNT(*) > 3;

-- Q92. Display courses having an average marks greater than 70, using HAVING.
SELECT Course, AVG(Marks) AS AvgMarks FROM Student GROUP BY Course HAVING AVG(Marks) > 70;

-- Q93. Display genders having a maximum marks value greater than 95, using HAVING.
SELECT Gender, MAX(Marks) AS MaxMarks FROM Student GROUP BY Gender HAVING MAX(Marks) > 95;

-- Q94. Display all student records sorted by marks in descending order, using ORDER BY.
SELECT * FROM Student ORDER BY Marks DESC;

-- Q95. Display all student records sorted by fee in ascending order.
SELECT * FROM Student ORDER BY Fee ASC;

-- Q96. Display all student records sorted by course (ascending) and then marks (descending).
SELECT * FROM Student ORDER BY Course ASC, Marks DESC;

-- Q97. Display all student records sorted by admission date, showing the most recently admitted students first.
SELECT * FROM Student ORDER BY AdmissionDate DESC;

-- Q98. Display the top 10 students with the highest marks, using ORDER BY along with a row-limiting clause.
SELECT TOP 10 * FROM Student ORDER BY Marks DESC;

-- Q99. Display all distinct courses sorted alphabetically.
SELECT DISTINCT Course FROM Student ORDER BY Course ASC;

-- Q100. Display department-wise student count sorted from highest to lowest count, combining GROUP BY and ORDER BY.

SELECT DepartmentID, COUNT(*) AS StudentCount 
FROM Student 
GROUP BY DepartmentID 
ORDER BY StudentCount DESC;
