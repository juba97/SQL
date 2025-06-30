CREATE DATABASE LessonsDB
USE LessonsDB
 
--შექმენით ბაზა, რომელიც შედგება ორი მაგიდისგან: employees და departments
CREATE TABLE employees (
id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(20),
department_id INT 
)
CREATE TABLE departments (
id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(20)
)
ALTER TABLE departments
ADD CONSTRAINT FK_departments FOREIGN KEY (id) REFERENCES employees(id)
	 
--შეიტანეთ რამდენიმე მონაცემი ორივე მაგიდაში.
INSERT INTO employees(name, department_id) VALUES('Antonio Moreno', 1)
INSERT INTO employees(name, department_id) VALUES('Ana Trujillo', 2)
INSERT INTO employees(name, department_id) VALUES('Christina Berglund', 3)
INSERT INTO employees(name, department_id) VALUES('Christina Berglund', 3)

INSERT INTO departments(name) VALUES('IT')
INSERT INTO departments(name) VALUES('UI/UX')
INSERT INTO departments(name) VALUES('SQL Database')
INSERT INTO departments(name) VALUES('SQL Database')

--შექმენით შეკითხვა, რომელიც დააბრუნებს თანამშრომლების სახელებს და მათ მიერ მუშაობის დეპარტამენტებს.
SELECT 
	employees.id,  employees.name AS CustomerName, 
	employees.department_id, departments.name AS DepartmentsName
FROM employees
LEFT JOIN departments ON employees.id = departments.id

--მოიძიეთ ყველა თანამშრომელი, რომლის სახელიც იწყება "A"-თი.
SELECT * FROM employees
WHERE name LIKE 'A%'

--გაფილტრეთ დეპარტამენტები, რომელშიც მხოლოდ ერთი თანამშრომელია დასაქმებული.
SELECT COUNT(id) AS CustomerID, name AS Departments
FROM departments
GROUP BY name
HAVING COUNT(id) > 1
