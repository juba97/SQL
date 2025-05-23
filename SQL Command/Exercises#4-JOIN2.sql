CREATE DATABASE Lessons
USE Lessons


CREATE TABLE Customers(
CustomerID INT IDENTITY(1,1) PRIMARY KEY,
Customername VARCHAR(20)
)

CREATE TABLE Orders(
OrderID INT,
CustomerID INT CONSTRAINT FK_Cust FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
Orderdate DATE
)

INSERT INTO Customers(Customername)
VALUES
('Maria Anders'),
('Ana Trujillo'),
('Antonio Moreno'),
('Thomas Hardy'),
('Christina Berglund')

INSERT INTO Orders(OrderID, CustomerID, Orderdate)
VALUES
(23, 1, '2025-06-11'),
(41, 2, '2025-07-12'),
(16, 3, '2025-08-13'),
(78, 4, '2025-09-14'),
(80, 5, '2025-10-15')

SELECT c.Customername, o.Orderdate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID

CREATE TABLE Employees(
EmployeeID INT IDENTITY(1,1) PRIMARY KEY, 
EmployeeName VARCHAR(20)
)

CREATE TABLE Sales(
SaleID INT,
EmployeeID INT CONSTRAINT FK_Empl FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
Saleamount INT
)

INSERT INTO Employees(EmployeeName)
VALUES
('Maria Anders'),
('Ana Trujillo'),
('Antonio Moreno'),
('Thomas Hardy'),
('Christina Berglund')

INSERT INTO Employees(EmployeeName)VALUES('Alfreds Futterkiste')
INSERT INTO Sales(SaleID, EmployeeID)VALUES(45, 6)


INSERT INTO Sales(SaleID, EmployeeID, Saleamount)
VALUES
(23, 1, 50),
(41, 2, 220),
(16, 3, 400),
(78, 4, 115),
(80, 5, 127)

SELECT e.EmployeeName, COALESCE(CAST(s.Saleamount AS VARCHAR), 'NOT SELL') AS Saleamount
FROM Employees e
LEFT JOIN Sales s ON e.EmployeeID = s.EmployeeID

CREATE TABLE Products(
ProductID INT IDENTITY(1,1) PRIMARY KEY,
Productname VARCHAR(20)
)

CREATE TABLE OrderDetails(
OrderdetailID INT,
ProductID INT CONSTRAINT FK_Prdc FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
Quantity INT
)

INSERT INTO Products(Productname)
VALUES
('Mouse'),
('Printer'),
('Dinamic'),
('Computer'),
('Hair Dryer')

INSERT INTO Products(Productname)VALUES('Micorwave')
INSERT INTO OrderDetails(OrderdetailID)VALUES(33)

INSERT INTO OrderDetails(OrderdetailID, ProductID, Quantity)
VALUES
(23, 1, 4),
(41, 2, 12),
(16, 3, 20),
(78, 4, 15),
(80, 5, 64)

SELECT p.Productname, COALESCE(CAST(o.OrderdetailID AS VARCHAR), 'NOT Order') AS [Order detail],
COALESCE(CAST(o.Quantity AS VARCHAR), 'NOT Quantity') AS Quantity
FROM OrderDetails o
RIGHT JOIN Products p ON o.ProductID = p.ProductID

CREATE TABLE Employees2(
Employee2ID INT IDENTITY(1,1) PRIMARY KEY,
Employename VARCHAR(20),
ManagerID INT CONSTRAINT FK_Empl2 FOREIGN KEY (ManagerID) REFERENCES Employees2(Employee2ID),
Managername VARCHAR(20)
)

INSERT INTO Employees2(Employename, ManagerID, Managername)
VALUES
('Maria Anders', 1, 'helados'),
('Ana Trujillo', 1, 'helados'),
('Antonio Moreno', 4, 'Berglunds snabbköp'),
('Thomas Hardy', 4, 'Berglunds snabbköp'),
('Christina Berglund', 5, 'Alfreds Futterkiste')

SELECT 
    COUNT(e1.Employee2ID) AS NumberEmployees, 
	STRING_AGG( e1.Employename, ',') AS Employee,  e2.Managername AS Manager
FROM Employees2 e1
JOIN Employees2 e2 ON e1.ManagerID = e2.Employee2ID
GROUP BY e2.Managername;
