CREATE DATABASE Exercises4
USE Exercises4

    
CREATE TABLE Employees(
EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
FirstName VARCHAR(50),
Lastname VARCHAR(50),
Age INT CONSTRAINT chk CHECK (Age >= 18),
Salary DECIMAL(10,2)
)

ALTER TABLE Employees
ADD Department VARCHAR(50)

ALTER TABLE Employees
ALTER COLUMN Salary DECIMAL(10,2)

ALTER TABLE Employees
DROP CONSTRAINT chk

ALTER TABLE Employees
DROP COLUMN Age

USE Exercises

DROP DATABASE Exercises4

CREATE TABLE Employees(
EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
FirstName VARCHAR(50),
Lastname VARCHAR(50),
Salary INT,
Department VARCHAR(20)
)

SELECT * FROM Employees

INSERT INTO Employees(
FirstName,
Lastname,
Salary,
Department
)VALUES(
'Antonio',
'Moreno',
2000,
'IT'
)
INSERT INTO Employees(
FirstName,
Lastname,
Salary,
Department
)VALUES(
'Thomas',
'Hardy',
2500,
'Finance'
)
INSERT INTO Employees(
FirstName,
Lastname,
Salary,
Department
)VALUES(
'Christina',
'Berglund',
2200,
'HR'
)

SELECT FirstName, LastName, department, Salary * 1.10 AS [Increased 10%]
FROM Employees


DELETE FROM Employees
WHERE Salary < 2100;

SELECT AVG(Salary) AS AVgSalary, STRING_AGG(FirstName, ',') AS Name
FROM Employees

SELECT MAX(Salary), STRING_AGG( Department, ',')
FROM Employees

SELECT 
    MAX(Salary) AS MaxSalary, 
    STRING_AGG(Department, ', ') AS Departments
FROM Employees;

SELECT Salary, Department
FROM Employees
GROUP BY Department, Salary
HAVING AVG(Salary) > 2200

SELECT Department, FirstName FROM Employees
WHERE Department = 'HR'
