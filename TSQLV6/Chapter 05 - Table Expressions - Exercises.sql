/*
 1) The following query attempts to lter orders that were not placed on the last day of the year. 
It's sup-posed to return the order ID, order date, customer ID, employee ID, and respective end of year date for each order
*/
WITH CTE AS (
  SELECT 
    *,
    DATEFROMPARTS(YEAR(orderdate), 12, 31) AS endofyear
  FROM Sales.Orders
)
SELECT 
  orderid, 
  orderdate, 
  custid, 
  empid
FROM CTE
WHERE orderdate != endofyear;

-- 2-1) Write a query that returns the maximum value in the orderdate column for each employee
SELECT empid, 
       MAX(orderdate) AS maxorderdate
FROM Sales.Orders 
GROUP BY empid;

/* 2-2) Encapsulate the query from Exercise 1 in a derived table. 
Write a Join query between the derived table and the Orders table to return the orders with the maximum order date for each employee
*/
SELECT  o.empid,
	o.orderdate,
	o.orderid, 
	o.custid
FROM Sales.Orders o
INNER JOIN (
	SELECT empid, 
	MAX(orderdate) AS maxorderdate 
	FROM Sales.Orders 
	GROUP BY empid)  AS d
ON o.empid =  d.empid AND o.orderdate = d.maxorderdate

-- 3-1)  Write a query that calculates a row number for each order based on orderdate, orderid ordering
SELECT  orderid,
	orderdate,
	custid, 
	empid,
ROW_NUMBER() OVER(ORDER BY orderdate, orderid) AS rownum
FROM Sales.Orders

/*
 3-2) Write a query that returns rows with row numbers 11 through 20 based on the row-number
denition in Exercise 3-1. Use a CTE to encapsulate the code from Exercise 3-1
*/
WITH OrdersRN AS (
	SELECT orderid, orderdate, custid, empid,
	ROW_NUMBER() OVER(ORDER BY orderdate, orderid) AS rownum  
	FROM Sales.Orders
) 
SELECT * FROM OrdersRN 
WHERE rownum BETWEEN 11 AND 20

-- 4) Write a solution using a recursive CTE that returns the management chain leading to Patricia Doyle (employee ID 9)
WITH EmpsCTE AS
(
	SELECT  empid, 
		mgrid, 
	 	firstname, 
	 	lastname 
	FROM HR.Employees  
	WHERE empid = 9 

UNION ALL  

	SELECT  P.empid,
		P.mgrid, 
		P.firstname, 
		P.lastname 
	FROM EmpsCTE AS C    
	INNER JOIN HR.Employees AS P ON C.mgrid = P.empid
)
SELECT  empid, 
	mgrid, 
	firstname, 
	lastname
FROM EmpsCTE

-- 5-1) Create a view that returns the total quantity for each employee and year
GO
CREATE OR ALTER VIEW  Sales.VEmpOrders AS 
SELECT  empid,  
	YEAR(orderdate) AS orderyear,  
	SUM(qty) AS qty
FROM Sales.Orders AS o  
INNER JOIN Sales.OrderDetails AS od 
	ON o.orderid = od.orderid
GROUP BY  empid, 
	  YEAR(orderdate);
GO

SELECT * FROM Sales.VEmpOrders 
ORDER BY empid, 
	 orderyear

-- 5-2) Write a query against Sales.VEmpOrders that returns the running total quantity for each employee and year
SELECT  empid,
	orderyear, 
	qty,  
	(SELECT SUM(v2.qty) FROM  Sales.VEmpOrders AS v2  
WHERE v2.empid = v1.empid  
	AND v2.orderyear <= v1.orderyear) AS runqty
FROM  Sales.VEmpOrders AS v1
ORDER BY empid, 
	 orderyear;

/*
   6-1)	Create an inline TVF that accepts as inputs a supplier ID (@supid AS INT) and a requested number of products (@n AS INT). 
	The function should return @n products with the highest unit prices that are supplied by the specied supplier ID
*/
GO
CREATE OR ALTER FUNCTION Production.TopProducts 
	(@supid AS INT, @n AS INT) 
	RETURNS TABLE
AS
RETURN
	SELECT TOP (@n) productid, productname, unitprice
FROM Production.Products
WHERE supplierid = @supid  
ORDER BY unitprice DESC;
GO

SELECT * FROM Production.TopProducts(5, 2);

-- 6-2) Using the CROSS APPLY operator and the function you created in Exercise 6-1, return the two most expensive products for each supplier
SELECT  S.supplierid, 
        S.companyname, 
	P.productid,
	P.productname,
	P.unitprice
FROM Production.Suppliers AS S  
CROSS APPLY Production.TopProducts(S.supplierid, 2) AS P

DROP VIEW IF EXISTS Sales.VEmpOrders;
DROP FUNCTION IF EXISTS Production.TopProducts;
