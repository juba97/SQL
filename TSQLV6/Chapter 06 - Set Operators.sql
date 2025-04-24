SELECT  country, 
	region, 
	city
FROM HR.Employees
UNION ALL 
SELECT  country, 
	region, 
	city
FROM Sales.Customers;

SELECT  country, 
	region, 
	city
FROM HR.Employees
UNION  
SELECT  country, 
	region, 
	city
FROM Sales.Customers;

SELECT  country, 
	region, 
	city
FROM HR.Employees
INTERSECT
SELECT  country, 
	region,
	city
FROM Sales.Customers;

SELECT  ROW_NUMBER()
OVER(PARTITION BY country, region, city         
ORDER BY (SELECT 0)) AS rownum,  country, region, city
FROM HR.Employees
INTERSECT
SELECT ROW_NUMBER() 
OVER(PARTITION BY country, region, city         
ORDER BY (SELECT 0)),  country, region, city
FROM Sales.Customers;

WITH INTERSECT_ALL AS(SELECT ROW_NUMBER() OVER(PARTITION BY country, region, city         
ORDER BY (SELECT 0)) AS rownum, country, region, city  
FROM HR.Employees  
INTERSECT  
SELECT ROW_NUMBER()    
OVER(PARTITION BY country, region, city
ORDER BY (SELECT 0)), country, region, city  
FROM Sales.Customers)
SELECT  country, 
	region, 
	city
FROM INTERSECT_ALL;

SELECT  country,
	region, 
	city
FROM HR.Employees
EXCEPT
SELECT  country, 
	region, 
	city
FROM Sales.Customers;

-- The following query returns distinct locations that are customer locations but not employee locations
SELECT  country, 
	region,
	city
FROM Sales.Customers
EXCEPT
SELECT  country, 
	region,
	city 
FROM HR.Employees;

WITH EXCEPT_ALL AS
(  
	 SELECT    ROW_NUMBER() OVER(PARTITION BY country, region, city          
	 ORDER BY (SELECT 0)
)	 AS rownum, country, region, city 
FROM HR.Employees 
EXCEPT
SELECT ROW_NUMBER() OVER(PARTITION BY country, region, city       
ORDER BY (SELECT 0)), country, region, city  
FROM Sales.Customers)
SELECT country, region, city
FROM EXCEPT_ALL;

SELECT  country, 
	region, 
	city 
FROM Production.Suppliers
EXCEPT
SELECT  country, 
	region,
	city 
FROM HR.Employees
INTERSECT
SELECT  country,
	region, 
	city
FROM Sales.Customers;

(SELECT country, 
	region, 
	city 
FROM Production.Suppliers
EXCEPT
SELECT country, region, city
	FROM HR.Employees)
INTERSECT 
SELECT country, 
	region,
	city 
FROM Sales.Customers;

SELECT country, 
       COUNT(*) AS numlocations
FROM (SELECT country, region, city 
	FROM HR.Employees     
UNION      
SELECT country, region, city 
FROM Sales.Customers) AS U 
GROUP BY country;

SELECT  empid, 
	orderid, 
	orderdate
FROM (
    SELECT TOP (2) empid, orderid, orderdate 
    FROM Sales.Orders   
    WHERE empid = 3     
    ORDER BY orderdate DESC, orderid DESC
) AS D1
UNION ALL
SELECT  empid,
	orderid,
	orderdate
FROM (
    SELECT TOP (2) empid, orderid, orderdate      
    FROM Sales.Orders     
    WHERE empid = 5    
    ORDER BY orderdate DESC, orderid DESC
) AS D2;
