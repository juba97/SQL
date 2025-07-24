CREATE DATABASE OnlineStore;
USE OnlineStore;

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(20),
    Country VARCHAR(20)
);

INSERT INTO Customers (Name, Country) 
VALUES 
('Ana Smith', 'USA'), 
('Giorgi Ivanov', 'Georgia'), 
('Alice Brown', 'UK'), 
('David Kim', 'South Korea'), 
('Maria Lopez', 'Spain');

-- Orders Table
CREATE TABLE Orders(
    OrderID INT IDENTITY(101,1) PRIMARY KEY,
    CustomerID INT CONSTRAINT FK_Customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2)
);

INSERT INTO Orders(CustomerID, OrderDate, TotalAmount)
VALUES
(1, '2024-02-10', '250.00'),
(2, '2024-02-12', '120.50'),
(3, '2024-02-15', '340.75'),
(4, '2024-02-18', '89.99'),
(5, '2024-02-20', '410.00');

-- Products Table
CREATE TABLE Products (
    ProductsID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(20),
    Price DECIMAL(10,2)
);

INSERT INTO Products(ProductName, Price)
VALUES
('Laptop', '800.00'),
('Smartphone', '600.00'),
('Headphones', '100.00'),
('Mouse', '25.00'),
('Keyboard', '50.00');

-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT CONSTRAINT FK_Order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    ProductID INT CONSTRAINT FK_Product FOREIGN KEY (ProductID) REFERENCES Products(ProductsID),
    Quantity INT
);

INSERT INTO OrderDetails(OrderID, ProductID, Quantity)
VALUES
(101, 1, 1), 
(101, 3, 2), 
(102, 2, 1), 
(103, 4, 3), 
(103, 5, 1), 
(104, 3, 1), 
(105, 2, 2), 
(105, 4, 5);

SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Products;
SELECT * FROM OrderDetails;

--მომხმარებლების სახელები, შეკვეთის ID-ები, შეკვეთის თარიღები და შეკვეთის მთლიანი თანხა, ისე რომ მონაცემები დალაგდეს ბოლო შეკვეთის მიხედვით
SELECT 
    c.Name AS CustomerName, 
    o.OrderID, 
    o.OrderDate, 
    o.TotalAmount
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
ORDER BY 
    o.OrderDate DESC;
	
--პროდუქტი, რომელსაც ბაზაში ყველაზე დაბალი ფასი აქვს
SELECT ProductName, Price 
FROM Products 
WHERE Price = (SELECT MIN(Price) FROM Products);

--დავაბრუნოთ თითოეული ქვეყნიდან შესრულებული შეკვეთების რაოდენობა და დავალაგოთ ეს მონაცემები შეკვეთების რაოდენობის კლებადობის მიხედვით
SELECT C.Country, COUNT(O.OrderID) AS TotalOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.Country
ORDER BY TotalOrders DESC;

--მომხმარებელმა გააკეთა ბაზაში ყველაზე ძვირადღირებული შეკვეთა
SELECT C.Name, O.TotalAmount 
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.TotalAmount = (SELECT MAX(TotalAmount) FROM Orders);

--ვიპოვოთ პროდუქტი, რომელიც მომხმარებლების მიერ ყველაზე ხშირად შეკვეთილ პროდუქტად ითვლება
SELECT TOP 1 P.ProductName, SUM(OD.Quantity) AS TotalQuantity
FROM Products P
JOIN OrderDetails OD ON P.ProductsID = OD.ProductID
GROUP BY P.ProductName
ORDER BY TotalQuantity DESC;
