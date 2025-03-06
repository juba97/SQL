CREATE DATABASE Exercises2
USE Exercises2

CREATE TABLE Users(
	id INT IDENTITY(1,1) PRIMARY KEY,
	name CHAR(20),
	age INT CONSTRAINT DF_age CHECK (age >= 18),
	status CHAR(20)
)

INSERT INTO Users(
name,
age,
status
)
VALUES
('Maria Anders', 18, 'inactive'),
('Ana Trujillo', 32, 'active'),
('Antonio Moreno', 27, 'inactive'),
('Thomas Hardy', 46, 'active')

--მომხმარებელი, რომელიც 25 წელზე უფროსია და აქვს "active" სტატუსი.
SELECT * FROM Users
WHERE age > 25 AND status = 'active'

CREATE TABLE Products(
id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(20),
price INT 
)

INSERT INTO Products(
name,
price
)VALUES
('Maria Anders', 1000),
('Ana Trujillo', 1500),
('Antonio Moreno', 500),
('Thomas Hardy', 400)

--ყველაზე ძვირი 3 პროდუქტი (ანუ ის, რომლებსაც აქვთ ყველაზე მაღალი ფასი).
SELECT TOP 3 
		id, 
		name,
		price
FROM products
ORDER BY price DESC

CREATE TABLE Sales(
		id INT IDENTITY(1,1) PRIMARY KEY,
		product_id INT,
		quantity INT
)

INSERT INTO Sales(
product_id,
quantity
)
VALUES
(1, 3),
(1, 2),
(2, 1),
(2, 4),
(3, 5)

--რამდენჯერ გაიყიდა თითოეული პროდუქტი.
SELECT 
		product_id, 
		SUM(quantity)
FROM Sales
GROUP BY product_id

CREATE TABLE Orders(
		id INT IDENTITY(1,1) PRIMARY KEY,
		user_id INT,
		order_date DATE
)

INSERT INTO Orders(
user_id,
order_date
)VALUES
(1, '2024-01-15'),
(2, '2024-02-10'),
(1, '2024-03-01'),
(3, '2024-02-20')

INSERT INTO Orders(
user_id,
order_date
)VALUES
(1, '2024-03-05'),
(2, '2024-03-06'),
(1, '2024-03-01')

-- მომხმარებლების სია მათი ბოლო შეკვეთის თარიღით.
SELECT  
		u.name, 
		MAX(o.order_date) AS last_order_date
FROM Users u
JOIN Orders o ON u.id = o.user_id
GROUP BY u.name, o.user_id
ORDER BY last_order_date DESC

CREATE TABLE employees(
		id INT IDENTITY(1,1) PRIMARY KEY,
		name VARCHAR(20),
		position VARCHAR(20)
)

INSERT INTO employees(name, position)VALUES('Maria Anders', 'Developer'), 
										   ('Ana Trujillo', 'HR'), 
										   ('Antonio Moreno', 'Developer'),
										   ('Thomas Hardy', 'Desogner'),
										   ('Christina Berglund', 'HR')

SELECT DISTINCT position FROM employees

UPDATE employees
SET position = 'Designer'
WHERE id = 4

SELECT * FROM employees

UPDATE Users
SET status = 'blocked'
WHERE id IN (1, 3) 

--იპოვე მომხმარებლები, რომლებმაც ყველაზე მეტი შეკვეთა გააკეთეს და მოაწესრიგე შედეგები კლებადობით.
SELECT 
		u.name, 
	    COUNT(o.id) AS order_count
FROM Users u
LEFT JOIN Orders o ON u.id = o.user_id
GROUP BY u.name
ORDER BY order_count DESC, u.name ASC


CREATE TABLE Products_name(
		id INT IDENTITY(1,1) PRIMARY KEY,
		name VARCHAR(20),
		price INT
)

CREATE TABLE Products_sales(
		id INT IDENTITY(1,1) PRIMARY KEY,
		product_id INT,
		quantity INT,
		CONSTRAINT FK_prd_name FOREIGN KEY (product_id) REFERENCES Products_name(id)
)

INSERT INTO Products_name(name, price)
VALUES
('Telephone', '800'),
('Laptop', '1500'),
('Watch', '500'),
('Earpods', '200'),
('TV', '1200')

INSERT INTO Products_sales(product_id, quantity)
VALUES
(1, 3),
(2, 1),
(1, 2),
(3, 5),
(2, 4),
(5, 7),
(3, 2)

--ყველაზე გაყიდვადი პროდუქტი
SELECT
		p.name,
		SUM(s.quantity) AS total_sold
FROM Products_name p
JOIN Products_sales s ON p.id = s.product_id
GROUP BY p.name
HAVING p.name != 'Laptop'
ORDER BY total_sold DESC, p.name asc
