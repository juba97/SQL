CREATE DATABASE Exercises5
USE Exercises5

     
CREATE TABLE Customer(
CusID INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(20)
)
    
CREATE TABLE Departments(
DepID INT IDENTITY(1,1) PRIMARY KEY,
CusID INT CONSTRAINT FK_Cust FOREIGN KEY (CusID) REFERENCES Customer(CusID),
Department_name VARCHAR(20),
Salary INT
)

SELECT * FROM Customer
INSERT INTO Customer(name)
VALUES
('Maria Anders'),
('Ana Trujillo'),
('Antonio Moreno'),
('Thomas Hardy'),
('Christina Berglund')
SELECT * FROM Departments
INSERT INTO Departments(CusID, Department_name, Salary)
VALUES
(1, 'IT', 2500),
(2, 'Finance', 1200),
(3, 'Database', 3000),
(4, 'HR', 1800),
(5, 'IT', 2000)

SELECT * FROM Departments

--ANY ერთ-ერთზე მეტი რომ იყოს საკმარისია
SELECT c.name, d.department_name, d.salary 
FROM Customer c
JOIN Departments d ON d.CusID = c.CusID
WHERE Salary > ANY (
SELECT Salary FROM Departments
WHERE Department_name = 'IT'
)

--ALL ყველა მნიშვნელობაზე მეტი უნდა იყოს
SELECT c.name, d.Department_name, d.Salary
FROM Departments d
JOIN Customer c ON d.CusID = c.CusID
WHERE Salary > ALL (
SELECT Salary FROM Departments
WHERE Department_name = 'IT'
)
