CREATE DATABASE Exercises3
USE Exercises3

CREATE TABLE Users(
id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(20),
last_name VARCHAR(20),
position VARCHAR(20),
sallary INT 
)

SELECT * FROM Users
INSERT INTO Users(
name,
last_name,
position,
sallary
)VALUES(
'Maria',
'Anders',
'HR',
5200
)
INSERT INTO Users(
name,
last_name,
position,
sallary
)VALUES(
'Ana',
'Trujillo',
'Developer',
4500
)
INSERT INTO Users(
name,
last_name,
position,
sallary
)VALUES(
'Antonio',
'Moreno',
'Designer',
7000
)
INSERT INTO Users(
name,
last_name,
position,
sallary
)VALUES(
'Thomas',
'Hardy',
'SQL Database',
6000
)

--თანამშრომლების ფილტრაცია ხელფასის მიხედვით
SELECT name, last_name, position, sallary  
FROM Users
WHERE sallary > 5000
ORDER BY sallary DESC

-- სვეტზე სახელის გადარქმევა 
EXEC sp_rename /*(Stored Procedure)*/ 'Users.sallarty', 'sallary', 'COLUMN';

--სვეტების სახელების მოძებნა
SELECT column_name 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Users';

CREATE TABLE Customers(
id INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(30)
)

CREATE TABLE Orders(
OrderID INT IDENTITY(101,1) PRIMARY KEY,
CustomerID INT,
amount INT,
CONSTRAINT FK_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(id)
)

INSERT INTO Orders(
CustomerID,
amount
)VALUES
(1, 500),
(2, 1200),
(3, 800),
(1, 1200)

--მომხმარებლები, რომლებმაც განახორციელეს ყველაზე ძვირი შეკვეთა
SELECT  c.name, o.amount
FROM Customers c
JOIN Orders o ON c.id = o.CustomerID
WHERE amount = (SELECT MAX(amount) FROM Orders)

INSERT INTO Customers(name)VALUES
('Maria Anders'),
('Ana Trujillo'),
('Antonio Moreno'),
('Thomas Hardy')

CREATE TABLE Order_detail(
OrderID INT IDENTITY(1,1) PRIMARY KEY,
CustomerID INT,
Order_date DATE
CONSTRAINT FK_Cst FOREIGN KEY (CustomerID) REFERENCES Customers(id)
)

INSERT INTO Order_detail(CustomerID, Order_date)
VALUES
(1, '2025-01-10'),
(2, '2025-02-15'),
(1, '2025-03-01'),
(2, '2025-04-12'),
(3, '2025-07-22')

--შეკვეთების დათვლა თითო მომხმარებელზე
SELECT c.name, COUNT(o.CustomerID) AS TotalOrder
FROM Customers c
LEFT JOIN Order_detail o ON c.id = o.CustomerID
GROUP BY c.name

CREATE TABLE Products_info(
id INT IDENTITY(1,1) PRIMARY KEY,
product_name VARCHAR(20),
categories VARCHAR(20),
price INT
)

INSERT INTO Products_info(
product_name,
categories,
price
)VALUES
('Laptop', 'Electronic', 2000),
('Table', 'Furniture', 150),
('TV', 'Electronic', 1000),
('Chair', 'Furniture', 80)

--პროდუქტების ფასების გაზრდა 10% -ით
SELECT categories, price * 1.10 AS new_price
FROM Products_info
WHERE categories = 'Electronic';


--რომელთა ხელფასი აღემატება საშუალოს
SELECT name, sallary
FROM Users
WHERE sallary > (SELECT AVG(sallary) FROM Users);


--(correlated subquery) პროდუქტები, რომლებიც აღემატება თავიანთი კატეგორიის საშუალო ფასს
SELECT p1.product_name, p1.categories, p1.price
FROM Products_info p1
WHERE p1.price > (
    SELECT AVG(p2.price)
    FROM Products_info p2
    WHERE p2.categories = p1.categories
);