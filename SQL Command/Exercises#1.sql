CREATE DATABASE Exercises
USE Exercises

     
CREATE TABLE Employees (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE Departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO Departments (id, department_name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Marketing'),
(4, 'Finance');

INSERT INTO Employees (name, age, department, salary) VALUES
('Nika', 30, 'IT', 5000),
('Luka', 25, 'HR', 3500),
('Ana', 27, 'Marketing', 4000),
('Giorgi', 35, 'IT', 6000),
('Mariam', 28, 'HR', 3700);

-- რომელიც აბრუნებს მხოლოდ იმ თანამშრომლებს, რომლებიც IT დეპარტამენტში მუშაობენ.
SELECT name, department
FROM Employees
WHERE department = 'IT'

--მოძებნე ყველა თანამშრომელი, რომლის ასაკი 28 წელზე მეტია.
SELECT name, age 
FROM Employees
WHERE age > 28

--იპოვე თანამშრომლები, რომელთა ხელფასი 4000-6000 დიაპაზონშია.
SELECT name, salary 
FROM Employees
WHERE salary BETWEEN 4000 AND 6000

-- თანამშრომლები, რომლებიც არ მუშაობენ HR დეპარტამენტში
SELECT name, department
FROM Employees
WHERE NOT department = 'HR'

--თანამშრომელი, რომელთა სახელი იწყება "G" ან "M" ასოთი.
SELECT name, department
FROM Employees
WHERE name LIKE 'G%' OR name LIKE 'M%'

--თანამშრომლები, რომელთა ასაკი 25, 27 ან 30-ია.
SELECT name, age
FROM Employees
WHERE age IN (25,27,30)

--თანამშრომლები, რომლებიც IT ან Marketing დეპარტამენტში მუშაობენ და ხელფასი 4000-ზე მეტი აქვთ
SELECT name, department, salary
FROM Employees
WHERE department = 'IT' OR department = 'Marketing' AND salary > 4000

--ყველა თანამშრომელი, რომელთა ხელფასი მეტია საშუალო ხელფასზე.
SELECT * FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees)

--თანამშრომელი, ვინც იმავე დეპარტამენტში მუშაობს, სადაც "Nika".
SELECT * FROM Employees
WHERE department = (SELECT department FROM Employees WHERE name = 'Nika')

-- ყველაზე მაღალი ხელფასის მქონე თანამშრომელი.
SELECT * FROM Employees
WHERE salary = (SELECT MAX(salary) FROM Employees)

--ხელფასი მეტია ნებისმიერი HR თანამშრომლის ხელფასზე
SELECT * FROM Employees
WHERE salary > ANY (SELECT salary FROM Employees WHERE department = 'HR');

--ხელფასი მეტია HR დეპარტამენტის ყველა თანამშრომლის ხელფასზე
SELECT * FROM Employees
WHERE salary > ALL (SELECT salary FROM Employees WHERE department = 'HR')

SELECT e.name, d.department_name
FROM Employees AS e
INNER JOIN Departments d ON e.department = d.department_name

SELECT Departments.department_name, Employees.name
FROM Departments
LEFT JOIN Employees ON Employees.id = Departments.id;

SELECT Employees.name, Departments.department_name
FROM Employees
JOIN Departments ON Departments.id = Employees.id
WHERE department_name = 'IT'
