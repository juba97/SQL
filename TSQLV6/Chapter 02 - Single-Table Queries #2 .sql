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