CREATE DATABASE Exercises6
USE Exercises6
    

CREATE TABLE Employees(
id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(20),
salary INT
)

SELECT * FROM Employees
INSERT INTO Employees(name, salary)
VALUES
('Maria Anders', 5500),
('Ana Trujillo', 12000),
('Antonio Moreno', 4200),
('Thomas Hardy', 3800),
('Christina Berglund', 7000)

SELECT name, salary
FROM Employees
WHERE salary > 5000

ALTER TABLE Employees
DROP COLUMN Department

ALTER TABLE Employees
ADD Department VARCHAR(20)

--გავზარდოთ ხელფასი 10% -ით
UPDATE Employees
SET salary = salary * 1.10
WHERE id = 1


DELETE Employees
WHERE salary < 4500

CREATE TABLE Departments(
id INT IDENTITY(1,1) PRIMARY KEY,
departmen_id INT,
department_name VARCHAR(20)
CONSTRAINT FK_Emp FOREIGN KEY (departmen_id) REFERENCES Employees(id) 
)

SELECT * FROM Departments
INSERT INTO Departments(departmen_id, department_name)
VALUES
(1,'Finance'),
(2,'IT'),
(3,'Database'),
(4,'Freelancer'),
(5,'Developer')

INSERT INTO Employees(name, salary)
VALUES
('Emma Watson', 7500)
INSERT INTO Departments(departmen_id, department_name)VALUES(6, 'Database')

INSERT INTO Departments(departmen_id, department_name)VALUES(6, 'Database')
INSERT INTO Employees(name,salary)VALUES('Antonio Moreno', 8000)
SELECT * FROM Departments

--ამოიღე ყველა თანამშრომელი, რომლის ხელფასი მეტია 50000-ზე
SELECT e.name, e.salary, d.department_name 
FROM Employees e
INNER JOIN Departments d ON d.departmen_id = e.id
WHERE salary > 5000

--გამოთვალე ყველა თანამშრომლის საშუალო ხელფასი
SELECT AVG(salary) AS AverageSalary FROM Employees

--გამოიტანე ყველაზე დიდი ხელფასი თითოეული დეპარტამენტის მიხედვით
SELECT d.department_name, MAX(e.Salary) AS HighestSalary
FROM Employees e
INNER JOIN Departments d ON e.id = d.id
GROUP BY d.department_name
--სადაც წევრებიც არიან მინიმუმ 2 ადამიანი.
HAVING COUNT(departmen_id) > 1

--გამოთვალე მინიმალური ხელფასი "Database"-ის დეპარტამენტში
SELECT d.department_name, MIN(e.salary) AS MinSalary FROM Employees e
INNER JOIN Departments d ON D.id = e.id
WHERE department_name = 'Database'
GROUP BY d.department_name

--დააჯგუფი ყველა თანამშრომელი დეპარტამენტის მიხედვით და გამოიტანე მათი საშუალო ხელფასი.
SELECT d.department_name, AVG(e.salary) AS AvgSalary FROM Employees e
INNER JOIN Departments d ON e.id = d.id
GROUP BY d.department_name

--გამოიტანე თანამშრომლის სახელი, რომლის ხელფასი მეტია იმ თანამშრომლის ხელფასზე, ვინც ამჟამად იღებს მინიმალურ ხელფასს
SELECT name, salary
FROM Employees 
WHERE salary > (SELECT MIN(salary) FROM Employees)

--ჩაატარე შიდა შეკითხვა, რომ გამოიტანო დეპარტამენტის სახელები, სადაც მუშაობენ თანამშრომლები, რომელთა ხელფასი მეტია 7000-ზე
SELECT  e.name, d.department_name, e.salary
FROM Employees e
INNER JOIN Departments d ON d.departmen_id = e.id
WHERE e.salary IN (SELECT salary FROM Employees 
WHERE salary > 7000
)
   
--გამოიტანს ორი ერთნაირი ხელფასის მქონდე ადამიანის საშუალო არითმეტიკულს
SELECT 
    SUM(salary) AS total_salary, 
    AVG(salary) AS average_salary,
    STRING_AGG(name, ',') AS Name
FROM employees
WHERE id IN (4, 7);
