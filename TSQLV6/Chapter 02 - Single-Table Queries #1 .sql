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


SELECT TOP 5 WITH TIES orderid,
                  orderdate,
                  custid,
                  empid
FROM Sales.Orders
ORDER BY orderdate DESC

SELECT orderid,
       orderdate,
       custid,
       empid
FROM Sales.Orders
ORDER BY orderdate,
         orderid
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;


SELECT orderid,
       custid,
       val,
       ROW_NUMBER() OVER(PARTITION BY custid
                         ORDER BY val) AS rownum
FROM Sales.OrderValues
ORDER BY custid,
         val;


SELECT orderid,
       empid,
       orderdate
FROM Sales.Orders
WHERE orderid IN (10248,
                  10249,
                  10250)

  SELECT empid,
         firstname,
         lastname
  FROM HR.Employees WHERE lastname LIKE N'D%';


SELECT orderid,
       custid,
       empid,
       orderdate
FROM Sales.Orders
WHERE custid = 1
  AND empid IN (1,
                3,
                4)
  OR custid = 85
  AND empid IN(2,
               4,
               6);


SELECT supplierid,
       COUNT(*) AS numproducts,
       CASE COUNT(*) % 2
           WHEN 0 THEN 'Even'
           WHEN 1 THEN 'Odd'
           ELSE 'Unknown'
       END AS countparity
FROM Production.Products
GROUP BY supplierid;


SELECT orderid,
       custid,
       val,
       CASE
           WHEN val < 1000.00 THEN 'Less than 1000'
           WHEN val <= 3000.00 THEN 'Between 1000 and 3000'
           WHEN val > 3000.00 THEN 'More than 3000'
           ELSE 'Unknown'
       END AS valuecategory
FROM Sales.OrderValues;


SELECT custid,
       country,
       region,
       city
FROM Sales.Customers
WHERE region IS NOT DISTINCT
  FROM N'WA';


SELECT custid,
       country,
       region,
       city
FROM Sales.Customers
WHERE region IS NULL;


SELECT custid,
       country,
       region,
       city
FROM Sales.Customers
WHERE region != N'WA'
  OR region IS NULL;


SELECT custid,
       country,
       region,
       city
FROM Sales.Customers
WHERE region IS DISTINCT
  FROM N'WA';

SELECT orderid, requireddate, shippeddate, 
GREATEST(requireddate, shippeddate) AS latestdate, 
LEAST(requireddate, shippeddate) AS earliestdate
FROM Sales.Orders
WHERE custid = 8;

SELECT orderid, requireddate, shippeddate, 
CASE   
WHEN requireddate > shippeddate OR shippeddate IS NULL
THEN requireddate  ELSE shippeddate 
END AS latestdate,  CASE    
WHEN requireddate < shippeddate OR shippeddate IS NULL THEN requireddate   
ELSE shippeddate  END AS earliestdate
FROM Sales.Orders
WHERE custid = 8;


SELECT orderid,  YEAR(orderdate) AS orderyear,  YEAR(orderdate) + 1 AS nextyear
FROM Sales.Orders;

SELECT name, description
FROM sys.fn_helpcollations();

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname = N'davis';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CS_AS = N'Davis';

SELECT empid, firstname + N' ' + lastname AS fullname
FROM HR.Employees;

SELECT custid, country, region, city,country + N',' + region + N',' + city AS location
FROM Sales.Customers;

SELECT custid, country, region, city,  country + COALESCE(N',' + region, N'') + N',' + city AS location
FROM Sales.Customers;

SELECT custid, country, region, city,  CONCAT(country, N',' + region, N',' + city) AS location
FROM Sales.Customers;

SELECT custid, country, region, city,  CONCAT_WS(N',', country, region, city) AS location
FROM Sales.Customers;

SELECT DATALENGTH(N'abcde');

SELECT PATINDEX('%[0-9]%', 'abcd123efgh');

SELECT REPLACE('1-a 2-b', '-', ':');

SELECT empid, lastname,  LEN(lastname) - LEN(REPLACE(lastname, 'e', '')) AS numoccur
FROM HR.Employees;

SELECT TRANSLATE('123.456.789,00', '.,', ',.');

SELECT REPLICATE('abc', 2);

SELECT supplierid,  RIGHT(REPLICATE('0', 9) + CAST(supplierid AS VARCHAR(10)), 10) AS strsupplierid3
FROM Production.Suppliers;

SELECT STUFF('xyz', 2, 1, 'abc');

SELECT COMPRESS(N'This is my cv. Imagine it was much longer.');

SELECT  CAST(DECOMPRESS(COMPRESS(N'This is my cv. Imagine it was much longer.')) AS NVARCHAR(MAX));

SELECT custid, STRING_AGG(CAST(orderid AS VARCHAR(10)), ',')  WITHIN GROUP(ORDER BY orderdate DESC, orderid DESC) AS custorders
FROM Sales.Orders
GROUP BY custid;
