-- 1) Write a query against the Sales.Orders table that returns orders placed in June 2021


SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE YEAR(orderdate) = 2021 AND MONTH(orderdate) = 6

-- 2) Write a query against the Sales.Orders table that returns orders placed on the day before the last day of the month
SELECT orderid, orderdate, custid, empid 
FROM Sales.Orders
WHERE orderdate = DATEADD(day, - 1, EOMONTH(orderdate));

-- 3) Write a query against the HR.Employees table that returns employees with a last name containing the letter e twice or more
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE '%e%e%'

-- 4) Write a query against the Sales.OrderDetails table that returns orders with a total value (quantity * unitprice) greater than 10,000, sorted by total value, descending
SELECT orderid, SUM(qty*unitprice) AS Totalvalue 
FROM Sales.OrderDetails
GROUP BY orderid
HAVING SUM(qty* unitprice) > 10000
ORDER BY Totalvalue DESC

/* 5) To check the validity of the data, write a query against the HR.Employees
table that returns employees with a last name that starts
with a lowercase English letter in the range a through
z. Remember that the collation of the sample database is case
insensitive (Latin1_General_CI_CP1_AS if you didn’t 
choose an explicit collation during the SQL Server installation,
or Latin1_General_CI_AS if you chose Windows collation, Case Insensitive, Accent Sensitive) */

SELECT empid, lastname
FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CS_AS LIKE N'[a-z]%';

-- 6)Explain the difference between the following two queries

-- Query 1
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
WHERE orderdate < '20220501'
GROUP BY empid;

-- Query 2
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY empid
HAVING MAX(orderdate) < '20220501';

-- 7) Write a query against the Sales.Orders table that returns the three shipped-to countries with the highest average freight for orders placed in 2021
SELECT TOP 3 shipcountry, AVG(freight) AS avgfreight 
FROM Sales.Orders
WHERE orderdate BETWEEN '20210101' AND '20220101'
GROUP BY shipcountry
ORDER BY avgfreight DESC

-- 8) Write a query against the Sales.Orders table that calculates row numbers for orders based on order date ordering (using the order ID as the tiebreaker) for each customer separately
SELECT custid, orderdate, orderid, 
ROW_NUMBER() OVER(PARTITION BY custid ORDER BY orderdate, orderid) AS rownum
FROM Sales.Orders
ORDER BY custid, rownum;

/* 9) Using the HR.Employees table, write a SELECT statement that returns for each employee the gender based on the title of courtesy. 
for 'Ms.' and 'Mrs.' return 'female' for 'Mr.' return 'Male' and in all other cases for example, 'Dr.' return 'Unknown' 
*/
SELECT empid, firstname, lastname, titleofcourtesy,
CASE titleofcourtesy
WHEN 'Ms.' THEN 'Female'
WHEN 'Mrs.' THEN 'Female'
WHEN 'Mr.' THEN 'Male'
ELSE 'Unknown' END AS Gender
FROM HR.Employees

/* 10) Write a query against the Sales.Customers table that returns for each customer the customer ID and region. Sort the rows in the output by region, ascending,
having NULLs sort last (after non-NULL values). Note that the default sort behavior for NULLs in T-SQL is to sort first (before non-NULL values) 
*/
SELECT custid, region 
FROM Sales.Customers
ORDER BY
CASE WHEN region  IS NULL THEN 1 ELSE 0 END, region 
