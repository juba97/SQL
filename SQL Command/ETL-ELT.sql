-- OLTP ბაზა
CREATE DATABASE OLTP_DB;
GO

-- DSA ბაზა
CREATE DATABASE DSA_DB;
GO
    
-- DW ბაზა
CREATE DATABASE DW_DB;
GO


USE OLTP_DB;
GO

CREATE TABLE SalesTransactions (
    TransactionID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Quantity INT,
    Price DECIMAL(10, 2),
    TransactionDate DATETIME
);

INSERT INTO SalesTransactions
VALUES
(1, 'Keyboard', 2, 50.00, '2025-03-01'),
(2, 'Mouse', 1, 25.00, '2025-03-02'),
(3, 'Monitor', 1, 300.00, '2025-03-03');


USE DSA_DB;
GO

CREATE TABLE SalesTransactions_Staging (
    TransactionID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Quantity INT,
    Price DECIMAL(10, 2),
    TransactionDate DATETIME,
    LoadDate DATETIME
);

USE DW_DB;
GO

CREATE TABLE FactSales (
    TransactionID INT PRIMARY KEY,
    ProductID INT,
    ProductName NVARCHAR(100),
    Quantity INT,
    TotalAmount DECIMAL(12, 2),
    TransactionDate DATE
);

USE DSA_DB;
GO

INSERT INTO SalesTransactions_Staging (TransactionID, ProductName, Quantity, Price, TransactionDate, LoadDate)
SELECT
    TransactionID,
    ProductName,
    CASE WHEN Quantity <= 0 THEN 1 ELSE Quantity END,
    Price,
    TransactionDate,
    GETDATE()
FROM OLTP_DB.dbo.SalesTransactions;

SELECT * FROM SalesTransactions_Staging;

USE DW_DB;
GO

INSERT INTO FactSales (TransactionID, ProductID, ProductName, Quantity, TotalAmount, TransactionDate)
SELECT
    TransactionID,
    NULL, -- ProductID ჯერ არ გვაქვს (მომავალში Dimension ცხრილში გავაკეთებ)
    ProductName,
    Quantity,
    Quantity * Price AS TotalAmount,
    CAST(TransactionDate AS DATE)
FROM DSA_DB.dbo.SalesTransactions_Staging;

SELECT * FROM FactSales;
