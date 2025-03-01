CREATE DATABASE Lessons
USE Lessons

CREATE TABLE Sales(
id INT IDENTITY(1,1) PRIMARY KEY,
Product_name VARCHAR(20),
Firstname VARCHAR(20)
)

SELECT * FROM Sales

INSERT INTO Sales(Product_name, Firstname)
VALUES
('Laptop', 'Thomas Hardy'),
('Phone', '	Christina Berglund'),
('Printer', 'Maria Anders'),
('Headphones', 'Ana Trujillo')

INSERT INTO Sales(Product_name, Firstname)
VALUES
('Laptop', 'Around the Horn'),
('Phone', '	Berglunds snabbköp'),
('Phone', 'Alfreds Futterkiste'),
('Headphones', 'Moreno Taquería')

--გავიგოთ გაყიდვების რაოდენობა თითოეული პროდუქტის მიხედვით
SELECT COUNT(id) AS Totalsell, Product_name, STRING_AGG(Firstname, ',')
FROM Sales
GROUP BY Product_name

CREATE TABLE Orders(
OrderID INT IDENTITY (1,1) PRIMARY KEY,
CustomerID INT,
OrderDates DATE
)

INSERT INTO Orders(CustomerID, OrderDates)
VALUES
(27, '2025-02-04')

INSERT INTO Orders(CustomerID, OrderDates)
VALUES
(34, '2025-06-08'),
(42, '2025-07-18'),
(76, '2025-11-22')

INSERT INTO Orders(CustomerID, OrderDates)
VALUES
(27, '2025-06-08'),
(14, '2025-07-18'),
(76, '2025-11-22')

--იპოვე, რამდენი შეკვეთა გააკეთა თითოეულმა მომხმარებელმა.
SELECT COUNT(OrderID) AS Totalorder, STRING_AGG(OrderDates,', ') AS Orderdate
FROM Orders
GROUP BY CustomerID

CREATE TABLE Products(
ProductID INT IDENTITY(1,1) PRIMARY KEY,
Price INT
)

CREATE TABLE Categorys(
CategoryID INT IDENTITY(1,1) CONSTRAINT FK FOREIGN KEY (CategoryID) REFERENCES Products(ProductID),
Category VARCHAR(20)
)


INSERT INTO Products(Price)
VALUES
('20'),
('150'),
('500'),
('330')

INSERT INTO Products(Price)
VALUES
('25'),
('76'),
('500'),
('200')

INSERT INTO Categorys(Category)
VALUES
('Monitors'),
('Dinamics'),
('Laptops'),
('Perifer Device')
INSERT INTO Categorys(Category)
VALUES
('Monitors2'),
('Dinamics2'),
('Laptops2'),
('Perifer Device2')



SELECT * FROM Products
SELECT * FROM Categorys

--ყველაზე ძვირადღირებული პროდუქტი თითოეულ კატეგორიაში.
SELECT c.Category, MAX(p.Price) AS MaxPrice
FROM Products p
INNER JOIN Categorys c ON p.ProductID = c.CategoryID
WHERE Price = (SELECT MAX(Price) FROM Products)
GROUP BY c.Category 
