CREATE DATABASE Exercises
USE Exercises

CREATE TABLE Employees(
id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(20),
age INT,
)

INSERT INTO Employees(name, age)
VALUES
('Maria Anders', 22),
('Antonio Moreno', 34),
('Thomas Hardy', 46)

INSERT INTO Employees(name, age)VALUES('Christina Berglund', 56)
INSERT INTO Employees(name, age)VALUES('Ana Trujillo', 41)
INSERT INTO Employees(name, age)VALUES('Berglunds snabbköp', 29)

CREATE TABLE Departments(
departments_id INT CONSTRAINT FK FOREIGN KEY (departments_id) REFERENCES Employees(id),
departments_name VARCHAR(20),
)
INSERT INTO Departments (departments_id, departments_name)
VALUES
(1, 'IT'),
(2, 'Financy'),
(3, 'Sciency')
INSERT INTO Departments(departments_id, departments_name)VALUES(5, 'SQL Database')
INSERT INTO Departments(departments_id, departments_name)VALUES(6, 'SQL Database')


--მოიძიოს ყველა თანამშრომლის სახელი, ასაკი და დეპარტამენტის სახელი, სადაც ისინი მუშაობენ.
SELECT e.name, COALESCE(d.departments_name, 'NO Departments') AS department, e.age
FROM Employees e
INNER JOIN Departments d ON d.departments_id = e.id

--მოიძიოს ყველა თანამშრომელი და მათი დეპარტამენტი.
--თუ რომელიმე თანამშრომელი არ არის დაკავშირებული დეპარტამენტთან, მაშინ დეპარტამენტის სახელი NULL იქნება.
SELECT e.name, d.departments_name
FROM Employees e
LEFT JOIN Departments d ON d.departments_id = e.id

--საჭიროა მოიძიოთ ყველა დეპარტამენტი და ის თანამშრომლები,
--რომლებიც ამ დეპარტამენტებში მუშაობენ. თუ რომელიმე დეპარტამენტი არ უკავშირდება თანამშრომლებს,
--მაშინ თანამშრომლის სახელი იქნება NULL.
SELECT e.name, d.departments_name
FROM Departments d
RIGHT JOIN Employees e ON e.id = d.departments_id

-- მოიძიოთ ყველა თანამშრომელი და მათი დეპარტამენტი, ასევე ყველა დეპარტამენტი, 
--რომელშიც არ არის თანამშრომელი. თუ რომელიმე თანამშრომელი ან დეპარტამენტი არ აქვს შესაბამისი მონაცემები, გამოიყენეთ NULL.
SELECT Employees.name, Departments.departments_name
FROM Employees
FULL OUTER JOIN Departments ON Departments.departments_id = Employees.id


--მოიძიოთ თითოეული დეპარტამენტის თანამშრომელთა რაოდენობა
SELECT COUNT(departments_id) AS [Total persons], STRING_AGG(Employees.name, ',') AS [Person name], departments_name AS [Department Name]
FROM Departments
JOIN Employees ON Departments.departments_id = Employees.id
GROUP BY departments_name

--მოიძიოთ ყველა თანამშრომელი, რომლებიც მუშაობენ მხოლოდ "SQL Database" დეპარტამენტში.
SELECT COUNT(departments_id) AS [Total Person], Employees.name, STRING_AGG(departments_name, ',') AS DepartmentName
FROM Employees
INNER JOIN Departments ON Departments.departments_id = Employees.id
WHERE departments_name = 'SQL Database'
GROUP BY Employees.name

--მოიძიოს ყველა თანამშრომელი და მათი დეპარტამენტი, ხოლო თანამშრომლები დალაგდნენ ასაკის მიხედვით. 
SELECT Employees.name, departments_name, Employees.age
FROM Employees
INNER JOIN Departments ON Departments.departments_id = Employees.id
ORDER BY age DESC
