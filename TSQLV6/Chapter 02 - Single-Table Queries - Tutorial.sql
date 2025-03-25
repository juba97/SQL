SELECT empid,
       YEAR(orderdate) AS orderyear,
       COUNT(*) AS numorders
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid,
         YEAR(orderdate)
HAVING COUNT(*) > 1
ORDER BY empid,
         orderyear;

SELECT orderid,
       empid,
       orderdate,
       freight
FROM Sales.Orders
WHERE custid = 71;

SELECT empid,
       YEAR(orderdate) AS orderyear
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid,
         YEAR(orderdate);

SELECT empid,
       YEAR(orderdate) AS orderyear,
       SUM(freight) AS totalfreight,
       COUNT(*) AS numorders
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid,
         YEAR(orderdate);

SELECT empid,
       YEAR(orderdate) AS orderyear,
       MAX(freight)
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid,
         YEAR(orderdate);

SELECT empid,
       YEAR(orderdate) AS orderyear,
       COUNT(DISTINCT custid) AS numcusts
FROM Sales.Orders
GROUP BY empid,
         YEAR(orderdate)
SELECT empid,
       YEAR(orderdate) AS orderyear
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid,
         YEAR(orderdate)
HAVING COUNT(*) > 1;

SELECT empid,
       YEAR(orderdate) AS orderyear,
       COUNT(*) AS numorders
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid,
         YEAR(orderdate)
HAVING COUNT(*) > 1;

SELECT empid,
       YEAR(orderdate) AS orderyear,
       COUNT(*) AS numorders
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid,
         YEAR(orderdate)
HAVING COUNT(*) > 1
SELECT orderid,
       YEAR(orderdate) AS orderyear,
       YEAR(orderdate) + 1 AS nextyear
FROM Sales.Orders;

SELECT empid,
       YEAR(orderdate) AS YEARDATE,
       COUNT(*) AS NUMORDER
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid,
         YEAR(orderdate)
HAVING COUNT(*) > 1
ORDER BY 1,
         2

SELECT empid,
       orderdate
FROM Sales.Orders
ORDER BY 1 DESC,
         2 DESC

SELECT orderid,
       orderdate,
       custid,
       empid
FROM Sales.Orders
WHERE YEAR(orderdate) = 2021
  AND MONTH(orderdate) = 6;