-- 1) Write a query that returns all orders placed on the last day of activity that can be found in the Orders table
SELECT orderid,
	   orderdate,
	   custid,
	   empid
FROM Sales.Orders
WHERE orderdate = (SELECT MAX(orderdate) FROM Sales.Orders);

/* 2) Write a query that returns all orders placed by the customer(s) who placed the highest number of orders. 
   Note that more than one customer might have the same number of orders
*/
SELECT custid, 
	   orderid, 
	   orderdate, 
	   empid
FROM Sales.Orders
WHERE custid IN (SELECT TOP 1 WITH TIES custid FROM Sales.Orders 
GROUP BY custid
ORDER BY COUNT(*) DESC
);

-- 3) Write a query that returns employees who did not place orders on or after May 1, 2022
SELECT e.empid,
	   e.firstname,
	   e.lastname
FROM HR.Employees e
WHERE e.empid NOT IN (SELECT o.empid FROM Sales.Orders o 
WHERE o.orderdate >= '20220501'
);

-- 4) Write a query that returns countries where there are customers but not employees
SELECT DISTINCT country 
FROM Sales.Customers
WHERE country NOT IN (SELECT country FROM HR.Employees);

-- 5) Write a query that returns for each customer all orders placed on the customer’s last day of activity
SELECT custid,
	   orderid,
	   orderdate,
	   empid
FROM Sales.Orders o1
WHERE orderdate = (SELECT MAX(o2.orderdate) FROM Sales.Orders o2
WHERE o1.custid = o2.custid
)
ORDER BY custid;

-- 6) Write a query that returns customers who placed orders in 2021 but not in 2022
SELECT custid, 
       companyname
FROM Sales.Customers c
WHERE EXISTS (SELECT * FROM Sales.Orders o
WHERE c.custid = o.custid
	AND orderdate >= '20210101'
	AND orderdate < '20220101'
)
AND NOT EXISTS (SELECT * FROM Sales.Orders o
WHERE c.custid = o.custid
AND orderdate >= '20220101'
AND orderdate < '20230101'
)
ORDER BY custid;

-- Write a query that returns customers who placed orders in 2021 but not in 2022, 
-- Same logic using the IN predicate
SELECT custid, 
       companyname
FROM Sales.Customers
WHERE custid IN (
    SELECT custid
    FROM Sales.Orders
    WHERE orderdate >= '20210101' 
	AND orderdate < '20220101'
)
AND custid NOT IN (
    SELECT custid
    FROM Sales.Orders
    WHERE orderdate >= '20220101'
	AND orderdate < '20230101'
)
ORDER BY custid;

-- 7) Write a query that returns customers who ordered product 12
SELECT custid,
       companyname
FROM Sales.Customers c
	WHERE EXISTS
		(SELECT * FROM Sales.Orders o
	WHERE c.custid = o.custid
AND EXISTS 
		(SELECT * FROM Sales.OrderDetails od 
	WHERE od.orderid = o.orderid
AND od.productid = 12
));


-- 8) Write a query that calculates a running-total quantity for each customer and month
SELECT custid,
       ordermonth, 
       qty,
(SELECT SUM(c2.qty) FROM Sales.CustOrders c2
		WHERE c1.custid = c2.custid 
		AND c2.ordermonth <= c1.ordermonth ) AS runqty
FROM Sales.CustOrders c1
ORDER BY custid, ordermonth;

--Same logic using the Windows Function
SELECT 
  custid,
  ordermonth,
  qty,
  SUM(qty) OVER(PARTITION BY custid ORDER BY ordermonth) AS runqty
FROM Sales.CustOrders
ORDER BY custid, ordermonth;

-- 9) Explain the difference between IN and EXISTS
-- (IN) - Checks if a value is in a list (returned by a subquery or a static list)
-- (EXISTS) - Checks whether the subquery returns any rows. It only cares about the existence of rows, not their values

/*
10) Write a query that returns for each order the number of days that passed since the same customer’s previous order. 
To determine recency among orders, use orderdate as the primary sort element and orderid as the tiebreaker
*/
SELECT custid, 
	   orderdate, 
	   orderid,  (SELECT TOP (1) O2.orderdate   
FROM Sales.Orders AS O2   
WHERE O2.custid = O1.custid     
AND ( O2.orderdate = O1.orderdate AND O2.orderid < O1.orderid OR O2.orderdate < O1.orderdate )   
ORDER BY O2.orderdate DESC, O2.orderid DESC) AS diff
FROM Sales.Orders AS O1
ORDER BY custid, orderdate, orderid
