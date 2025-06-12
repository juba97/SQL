/*

	1) Explain the difference between the UNION ALL and UNION operators. 
	In what cases are the two equivalent? When they are equivalent, which one should you use?
*/

/*
	• UNION removes duplicates, which incurs additional processing.
	• UNION ALL includes all rows, including duplicates, and is faster.
	• Use UNION ALL when you know or don’t care about duplicates and want better performance.
	• Use UNION only when you need to remove duplicates.
*/

/*
	2) Write a query that generates a virtual auxiliary table of 10 numbers in the range 1 through 10 without using a looping construct or the GENERATE_SERIES function. 
	You do not need to guarantee any pre-sentation order of the rows in the output of your solution
*/
SELECT 1 AS n
UNION ALL SELECT 2 
UNION ALL SELECT 3
UNION ALL SELECT 4
UNION ALL SELECT 5
UNION ALL SELECT 6
UNION ALL SELECT 7
UNION ALL SELECT 8
UNION ALL SELECT 9
UNION ALL SELECT 10

-- 3) Write a query that returns customer and employee pairs that had order activity in January 2022 but not in February 2022
SELECT custid, empid
FROM Sales.Orders
WHERE  orderdate >= '20220101' AND orderdate < '20220201'

EXCEPT

SELECT custid, empid
FROM Sales.Orders
WHERE  orderdate >= '20220201' AND orderdate < '20220301'

-- 4) Write a query that returns customer and employee pairs that had order activity in both January 2022 and February 2022.
SELECT custid, empid
FROM Sales.Orders
WHERE  orderdate >= '20220101' AND orderdate < '20220201'

INTERSECT

SELECT custid, empid
FROM Sales.Orders
WHERE  orderdate >= '20220201' AND orderdate < '20220301'

-- 5) Write a query that returns customer and employee pairs that had order activity in both January 2022 and February 2022 but not in 2021.
SELECT custid, empid
FROM Sales.Orders
WHERE orderdate >= '20220101' AND orderdate < '20220201'

INTERSECT

SELECT custid, empid
FROM Sales.Orders
WHERE orderdate >= '20220201' AND orderdate < '20220301'

EXCEPT

SELECT custid, empid
FROM Sales.Orders
WHERE orderdate >= '20210101' AND orderdate < '20220101'

/*
	6) You are asked to add logic to the query so that it guarantees that the rows from Employees are returned in the output before the rows from Suppliers. 
	Also, within each segment, the rows should be sorted by country, region, and city
*/

SELECT country, region, city
FROM (
    SELECT 1 AS sortcol, country, region, city      
    FROM HR.Employees     

    UNION ALL  

    SELECT 2, country, region, city     
    FROM Production.Suppliers
) AS D
ORDER BY sortcol, country, region, city;
