SELECT *
FROM (SELECT custid, 
			 companyname FROM Sales.Customers 
			 WHERE country = 'USA') AS USACusts;

SELECT YEAR(orderdate) AS orderyear,
	   COUNT(DISTINCT custid) AS numcusts 
	   FROM Sales.Orders
	   GROUP BY YEAR(orderdate);

SELECT orderyear, COUNT(DISTINCT custid) AS numcusts 
FROM(SELECT YEAR(orderdate) AS orderyear, custid FROM Sales.Orders)AS D
GROUP BY orderyear;

SELECT orderyear, 
	   COUNT(DISTINCT custid) AS numcusts 
	   FROM (SELECT YEAR(orderdate), custid FROM Sales.Orders) AS D(orderyear, custid)
GROUP BY orderyear;

DECLARE @empid AS INT = 3;
SELECT orderyear,
	   COUNT(DISTINCT custid) AS numcusts 
FROM (SELECT YEAR(orderdate) AS orderyear, 
	  custid FROM Sales.Orders 
	  WHERE empid = @empid) AS D 
	  GROUP BY orderyear;

SELECT orderyear , numcusts 
FROM(SELECT orderyear, 
COUNT(DISTINCT custid) AS numcusts 
FROM(SELECT YEAR(orderdate) AS orderyear, custid
FROM Sales.Orders) AS D1 
GROUP BY orderyear) AS D2
WHERE numcusts > 70

SELECT YEAR(orderdate) AS orderyear,
COUNT(DISTINCT custid) AS numcusts
FROM Sales.Orders
GROUP BY YEAR(orderdate)
HAVING COUNT(DISTINCT custid) > 70

SELECT 
    Cur.orderyear,  
    Cur.numcusts AS curnumcusts,
    Prv.numcusts AS prvnumcusts, 
    Cur.numcusts - Prv.numcusts AS growth 
FROM (
    SELECT YEAR(orderdate) AS orderyear,
           COUNT(DISTINCT custid) AS numcusts 
    FROM Sales.Orders 
    GROUP BY YEAR(orderdate)
) AS Cur 
LEFT OUTER JOIN (
    SELECT YEAR(orderdate) AS orderyear,
           COUNT(DISTINCT custid) AS numcusts 
    FROM Sales.Orders 
    GROUP BY YEAR(orderdate)
) AS Prv 
ON Cur.orderyear = Prv.orderyear + 1;



