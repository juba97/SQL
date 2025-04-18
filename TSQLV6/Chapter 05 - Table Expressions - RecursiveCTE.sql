WITH USACusts AS
(
SELECT custid, 
       companyname 
FROM Sales.Customers 
WHERE country = 'USA')
SELECT * FROM USACusts;

WITH C AS 
(
	SELECT YEAR(orderdate) AS orderyear, custid 
	FROM Sales.Orders
)
SELECT orderyear, 
       COUNT(DISTINCT custid) AS numcusts
FROM C 
GROUP BY orderyear;

WITH C (orderyear, custid) AS 
(
	SELECT YEAR(orderdate), custid 
	FROM Sales.Orders
)
SELECT orderyear, 
       COUNT(DISTINCT custid) AS numcusts
FROM C
GROUP BY orderyear;

DECLARE @empid AS INT = 3;
WITH C AS
(
	SELECT YEAR(orderdate) AS orderyear, custid 
	FROM Sales.Orders 
	WHERE empid = @empid
)
SELECT orderyear, 
       COUNT(DISTINCT custid) AS numcusts
FROM C 
GROUP BY orderyear;

WITH C1 AS
(
	SELECT YEAR(orderdate) AS orderyear, custid 
	FROM Sales.Orders
), C2 AS
(
	SELECT orderyear, 
        COUNT(DISTINCT custid) AS numcusts 
	FROM C1 
	GROUP BY orderyear
)
SELECT orderyear, 
       numcusts 
FROM C2
WHERE numcusts > 70;

WITH YearlyCount AS
(
	SELECT YEAR(orderdate) AS orderyear, 
        COUNT(DISTINCT custid) AS numcusts 
FROM Sales.Orders
GROUP BY YEAR(orderdate)
)
SELECT Cur.orderyear, 
       Cur.numcusts AS 
       curnumcusts, 
       Prv.numcusts AS
       prvnumcusts, 
       Cur.numcusts - Prv.numcusts AS growth
FROM YearlyCount AS Cur
	  LEFT OUTER JOIN YearlyCount AS Prv 
	   ON Cur.orderyear = Prv.orderyear + 1;

WITH EmpsCTE AS
(
SELECT empid,
       mgrid,
       firstname, 
       lastname
FROM HR.Employees 
WHERE empid = 2

UNION ALL

SELECT C.empid, 
       C.mgrid, 
       C.firstname,  
       C.lastname 
FROM EmpsCTE AS P 
INNER JOIN HR.Employees AS C 
	ON C.mgrid = P.empid
)
SELECT empid, 
       mgrid, 
       firstname,
       lastname
FROM EmpsCTE;
