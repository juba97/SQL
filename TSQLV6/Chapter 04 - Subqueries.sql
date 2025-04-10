DECLARE @maxid AS INT = (SELECT MAX(orderid)   
FROM Sales.Orders);
SELECT orderid, 
	   orderdate,
	   empid,
	   custid
FROM Sales.Orders
WHERE orderid = @maxid;

SELECT orderid, 
	   orderdate, 
	   empid, 
	   custid
FROM Sales.Orders
WHERE orderid = (SELECT MAX(O.orderid) FROM Sales.Orders AS O);

SELECT orderid
FROM Sales.Orders
WHERE empid = (SELECT E.empid FROM HR.Employees AS E  WHERE E.lastname LIKE N'C%');

SELECT orderid
FROM Sales.Orders
WHERE empid =  (SELECT E.empid FROM HR.Employees AS E WHERE E.lastname LIKE N'D%');

SELECT orderid
FROM Sales.Orders
WHERE empid = (SELECT E.empid FROM HR.Employees AS E WHERE E.lastname LIKE N'A%');

SELECT orderid
FROM Sales.Orders
WHERE empid IN (SELECT E.empid   FROM HR.Employees AS E   WHERE E.lastname LIKE N'D%');

SELECT custid, 
	   orderid, 
	   orderdate,
	   empid
FROM Sales.Orders
WHERE custid IN (SELECT C.custid FROM Sales.Customers AS C WHERE C.country = N'USA');

SELECT custid,
	   companyname
FROM Sales.Customers
WHERE custid NOT IN (SELECT O.custid FROM Sales.Orders AS O);

DROP TABLE IF EXISTS dbo.Orders;
CREATE TABLE dbo.Orders(orderid INT NOT NULL CONSTRAINT PK_Orders PRIMARY KEY);
INSERT INTO dbo.Orders(orderid) 
SELECT orderid  FROM Sales.Orders  
WHERE orderid % 2 = 0;

SELECT n
FROM dbo.Nums
WHERE n BETWEEN (SELECT MIN(O.orderid) FROM dbo.Orders AS O) 
AND (SELECT MAX(O.orderid) FROM dbo.Orders AS O)
AND n NOT IN (SELECT O.orderid FROM dbo.Orders AS O);

DROP TABLE IF EXISTS dbo.Orders;
