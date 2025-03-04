CREATE DATABASE Exercises
USE Exercises

CREATE TABLE Users(
id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(20),
age INT CONSTRAINT DF_age CHECK (age >= 18),
email VARCHAR(255)
)

INSERT INTO Users(
name,
age,
email
)VALUES
('Maria Anders', 23, 'Maria23@gmailcom'),
('Antonio Moreno', 45, 'Antonio45@gmailcom'),
('Thomas Hardy', 18, 'Thomas18@gmailcom'),
('Christina Berglund', 27, 'Christina27@gmailcom')

INSERT INTO Users(
name,
age,
email
)VALUES
('Alfreds Futterkiste', 56, 'Alfreds56@gmailcom'),
('helados', 25, 'helados25@gmailcom'),
('Moreno Taquería', 65, 'Taquería65@gmailcom'),
('Around the Horn', 54, 'Horn54@gmailcom')

INSERT INTO Users(
name,
age,
email
)VALUES
('Maria Anders', 23, 'Maria23@gmailcom')

UPDATE Users
SET name = 'Berglunds snabbköp'
WHERE id = 9

SELECT * FROM Users
--SQL მოთხოვნა, რომელიც აბრუნებს მხოლოდ იმ მომხმარებლების სიას, რომელთა ასაკი მეტია 25-ზე და ნაკლებია 40-ზე.
SELECT * FROM Users
WHERE age BETWEEN 25 AND 40 
ORDER BY age ASC

CREATE TABLE Orders(
order_id INT IDENTITY(1,1) PRIMARY KEY,
userID INT CONSTRAINT FK_users FOREIGN KEY (userID) REFERENCES Users(id),
amount INT
)

INSERT INTO Orders(userID, amount)
VALUES
(1, 35),
(2, 156),
(3, 234),
(4, 78)
INSERT INTO Orders(userID, amount)
VALUES
(5, 10),
(6, 30),
(7, 300),
(8, 218)
INSERT INTO Orders(userID, amount)
VALUES
(1, 100)

INSERT INTO Orders(userID,amount, order_date)
VALUES
(1, 35, '2025-03-15'),
(2, 156, '2024-10-15'),
(3, 234, '2018-03-26'),
(4, 78, '2025-09-11')
INSERT INTO Orders(userID, amount, order_date)
VALUES
(5, 10, '2025-10-22'),
(6, 30, '2024-07-17'),
(7, 300, '2018-08-19'),
(8, 218, '2025-12-11')
INSERT INTO Orders(userID, amount)
VALUES
(1, 100)

UPDATE Orders
SET order_date = '2025-02-14'
WHERE order_id = 9

TRUNCATE TABLE order_date;

ALTER TABLE Orders
DROP COLUMN order_date

UPDATE Orders
SET userID = 4
WHERE order_id = 5

--SQL მოთხოვნა, რომელიც დააბრუნებს თითოეული მომხმარებლის მიერ დახარჯული თანხის ჯამს.
SELECT u.id, u.name, SUM(o.amount) AS AmountSpent
FROM Users u
JOIN Orders o ON u.id = o.userID
GROUP BY u.id, u.name
ORDER BY AmountSpent DESC

--დაწერო SQL მოთხოვნა, რომელიც აბრუნებს ყველაზე ძვირადღირებული შეკვეთის დეტალებს.
SELECT TOP 1  u.name, MAX(o.amount) AS MaxAmount
FROM Orders o
JOIN Users u ON u.id = o.order_id
GROUP BY u.name
ORDER BY MaxAmount DESC


CREATE TABLE Categories (
category_id INT IDENTITY(1,1) PRIMARY KEY,
category_name VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE Products (
product_id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(255) NOT NULL,
category_id INT,
FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);

INSERT INTO Categories (category_name) VALUES ('Electronics'), ('Furniture'), ('Clothing');

INSERT INTO Products (name, category_id) VALUES 
('Laptop', 1),
('Smartphone', 1),
('Sofa', 2),
('T-shirt', 3),
('Table', 2);

INSERT INTO Products (name, category_id) VALUES 
('Laptop', 1),
('Headphone', 1),
('Pilow', 2),
('Jaket', 3),
('Table', 2);

--დაწერო SQL მოთხოვნა, რომელიც დააბრუნებს თითო კატეგორიაში არსებული პროდუქტების რაოდენობას.
SELECT COUNT(*) AS Quantity, c.category_name
FROM Categories c
JOIN Products p ON P.category_id = c.category_id
GROUP BY c.category_name

/*SQL მოთხოვნა, რომელიც აბრუნებს თითოეულ მომხმარებელსა და მათ მიერ გაკეთებული შეკვეთების რაოდენობას.
თუ მომხმარებელს არ აქვს შეკვეთა, მაინც უნდა გამოჩნდეს სიაში ნულოვანი მნიშვნელობით. */
SELECT u.name, COUNT(o.order_id) AS order_count
FROM Users u
LEFT JOIN Orders o ON u.id = o.userID
GROUP BY u.name, u.id

ALTER TABLE Orders
ADD order_date DATE

DELETE FROM Orders
WHERE order_id IN (14, 15, 16, 17)

--დაწერო SQL მოთხოვნა, რომელიც აბრუნებს ბოლო 30 დღის განმავლობაში გაკეთებულ შეკვეთებს.
SELECT order_id, userID, amount, order_date
FROM Orders
WHERE order_date >= DATEADD(DAY, -30, GETDATE());










