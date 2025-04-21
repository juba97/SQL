CREATE OR ALTER VIEW Sales.USACusts 
AS SELECT 
	custid,
	companyname, 
	contactname, 
	contacttitle, 
	address, 
	city, 
	region, 
	postalcode, 
	country, 
        phone, 
	fax
FROM Sales.Customers
WHERE country = N'USA';
GO

SELECT 
       custid,
       companyname
FROM Sales.USACusts;

SELECT 
	custid,
	companyname,
	region
FROM Sales.USACusts
ORDER BY region;

CREATE OR ALTER VIEW Sales.USACusts 
AS SELECT TOP (100) PERCENT
	    custid,
	    companyname, 
	    contactname,
	    contacttitle,
	    address,
	    city,
	    region,
	    postalcode,
	    country,
	    phone,
	    fax
FROM Sales.Customers
WHERE country = N'USA'
ORDER BY region;
GO

CREATE OR ALTER VIEW Sales.USACusts 
AS SELECT TOP (100) PERCENT
		    custid, 
		    companyname, 
		    contactname, 
		    contacttitle, 
		    address,
		    city,
		    region,
		    postalcode,
		    country,
		    phone,
		    fax
FROM Sales.Customers
WHERE country = N'USA'
ORDER BY region;
GO

SELECT 
	custid,
	companyname,
	region
FROM Sales.USACusts;

CREATE OR ALTER VIEW Sales.USACusts 
AS SELECT 
	custid,
	companyname,
	contactname,
	contacttitle,
	address,
	city,
	region,
	postalcode,
	country,
	phone,
	fax
FROM Sales.Customers
WHERE country = N'USA'
ORDER BY region
OFFSET 0 ROWS;
GO

CREATE OR ALTER VIEW Sales.USACusts
AS SELECT 
	custid,
	companyname, contactname, contacttitle, address,
	city, region, postalcode, country, phone, fax
FROM Sales.Customers
WHERE country = N'USA';
GO

SELECT OBJECT_DEFINITION(OBJECT_ID('Sales.USACusts'));

CREATE VIEW Sales.USACusts
AS
SELECT 
	custid, 
	companyname, 
	contactname,
	contacttitle, 
	address, 
	city,
	region, 
	postalcode, 
	country,
	phone, 
	fax
FROM Sales.Customers
WHERE country = N'USA';

CREATE OR ALTER VIEW Sales.USACusts 
WITH ENCRYPTION 
AS 
SELECT
	 custid, companyname, contactname, contacttitle,
	 address, city, region, postalcode, country, phone, fax
FROM Sales.Customers
WHERE country = N'USA';
GO

EXEC sp_helptext 'Sales.USACusts';

CREATE OR ALTER VIEW Sales.USACusts WITH SCHEMABINDING AS 
SELECT  custid, 
        companyname,  
        contactname, 
	contacttitle, 
	address,
	city, 
	region, 
	postalcode,  
	country,
	phone, 
	fax
FROM Sales.Customers
WHERE country = N'USA';
GO

ALTER TABLE Sales.Customers DROP COLUMN address;

INSERT INTO Sales.USACusts(companyname,
			contactname,
			contacttitle, 
			address,
			city,
			region,
			postalcode,
			country,
			phone,fax)
VALUES(N'Customer ABCDE',
	N'Contact ABCDE',
	N'Title ABCDE',
	N'Address ABCDE',
	N'London',NULL,
	N'12345', 
	N'UK',
	N'012-3456789',
	N'012-3456789');

SELECT custid,
       companyname,
       country
FROM Sales.USACusts
WHERE companyname = N'Customer ABCDE';

SELECT 
	custid,
	companyname,
	country
FROM Sales.Customers
WHERE companyname = N'Customer ABCDE';

CREATE OR ALTER VIEW Sales.USACusts WITH SCHEMABINDING AS 
SELECT custid, companyname, contactname, contacttitle, 
	   address, city, region, postalcode, country, phone, fax
FROM Sales.Customers
WHERE country = N'USA'
WITH CHECK OPTION;
GO

INSERT INTO Sales.USACusts(companyname, contactname, contacttitle, 
		address, city, region, postalcode, country, phone, fax) 
VALUES(N'Customer FGHIJ', N'Contact FGHIJ', N'Title FGHIJ',
	N'Address FGHIJ', N'London', NULL, N'12345', N'UK', N'012-3456789', N'012-3456789');

DELETE FROM Sales.Customers
WHERE custid > 91;
DROP VIEW IF EXISTS Sales.USACusts;

USE TSQLV6;
GO
CREATE OR ALTER FUNCTION dbo.GetCustOrders  
(@cid AS INT) RETURNS TABLE AS RETURN 
SELECT orderid, custid, empid, orderdate, requireddate,    
	  shippeddate, shipperid, freight, shipname, shipaddress, shipcity,   
	  shipregion, shippostalcode, shipcountry  
FROM Sales.Orders  
WHERE custid = @cid;
GO

SELECT orderid, 
       custid
FROM dbo.GetCustOrders(1) AS O;

SELECT O.orderid,
       O.custid,
       OD.productid,
       OD.qty
FROM dbo.GetCustOrders(1) AS O  
INNER JOIN Sales.OrderDetails AS OD ON O.orderid = OD.orderid;

DROP FUNCTION IF EXISTS dbo.GetCustOrders;

SELECT S.shipperid,
       E.empid
FROM Sales.Shippers AS S 
CROSS JOIN HR.Employees AS E;

SELECT S.shipperid, 
       E.empid
FROM Sales.Shippers AS S  
CROSS APPLY HR.Employees AS E

SELECT C.custid, 
       A.orderid, 
       A.orderdate
FROM Sales.Customers AS C 
CROSS APPLY (SELECT TOP (3) orderid, empid, orderdate, requireddate    
FROM Sales.Orders AS O     
WHERE O.custid = C.custid     
ORDER BY orderdate DESC, orderid DESC) AS A


SELECT C.custid, 
       A.orderid, 
       A.orderdate
FROM Sales.Customers AS C  
CROSS APPLY (SELECT orderid, empid, orderdate, requireddate     
   FROM Sales.Orders AS O     
   WHERE O.custid = C.custid     
   ORDER BY orderdate DESC, orderid DESC     
   OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY) AS A;

SELECT C.custid, 
       A.orderid, 
       A.orderdate
FROM Sales.Customers AS C  
OUTER APPLY (SELECT TOP (3) 
      orderid, empid, orderdate, requireddate     
FROM Sales.Orders AS O     
WHERE O.custid = C.custid     
ORDER BY orderdate DESC, orderid DESC) AS A

CREATE OR ALTER FUNCTION dbo.TopOrders  
(@custid AS INT, @n AS INT)  RETURNS TABLE AS RETURN 
SELECT TOP (@n) orderid, empid, orderdate, requireddate
FROM Sales.Orders  
WHERE custid = @custid  
ORDER BY orderdate DESC, orderid DESC;
GO

SELECT  C.custid, 
        C.companyname,  
	A.orderid, 
	A.empid, 
	A.orderdate, 
	A.requireddate
FROM Sales.Customers AS C 
CROSS APPLY dbo.TopOrders(C.custid, 3) AS A
