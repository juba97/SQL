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



