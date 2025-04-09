-- 1) Write a query that generates ve copies of each employee row
SELECT e.empid,
	   e.firstname, 
	   e.lastname,
	   n.n
FROM HR.Employees e
CROSS JOIN Nums n
WHERE n.n <= 5

-- 2) Write a query that returns a row for each employee and day in the range June 12, 2022 through June 16, 2022
SELECT e.empid, 
	   DATEADD(DAY, n - 1, CAST('20220612' AS DATE)) AS dt
FROM HR.Employees e
CROSS JOIN Nums n
WHERE n <= DATEDIFF(DAY, '20220612', '20220616') + 1
ORDER BY e.empid, dt

-- 3) Explain what’s wrong in the following query, and provide a correct alternative
/*
	SELECT Customers.custid, Customers.companyname, Orders.orderid, Orders.orderdate
	FROM Sales.Customers AS C  
	INNER JOIN Sales.Orders AS O ON Customers.custid = Orders.custid;
*/
-- Correct alternative
SELECT
	C.custid, 
	C.companyname, 
	O.orderid, 
	O.orderdate
FROM Sales.Customers AS C 
INNER JOIN Sales.Orders AS O ON C.custid = O.custid;

-- 4) Return US customers, and for each customer return the total number of orders and total quantities
SELECT  c.custid, 
		COUNT(DISTINCT o.orderid) AS numorders, 
		SUM(od.qty) AS totalqty
FROM Sales.Customers c
INNER JOIN Sales.Orders o ON c.custid = o.custid
INNER JOIN Sales.OrderDetails od ON o.orderid = od.orderid
WHERE country = 'USA'
GROUP BY c.custid

-- 5) Return customers and their orders, including customers who placed no orders and NULL is in first place
SELECT c.custid, 
	   c.companyname, 
	   o.orderid, 
	   o.orderdate
FROM Sales.Customers c
LEFT JOIN Sales.Orders o ON c.custid = o.custid
ORDER BY 
	CASE WHEN o.custid IS NULL THEN 0 ELSE 1 END 

-- 6) Return customers who placed no orders
SELECT c.custid, 
	   c.companyname
FROM Sales.Customers c
LEFT JOIN Sales.Orders o ON c.custid = o.custid
WHERE orderdate IS NULL

-- 7) Write a query that returns all customers, but matches them with their respective orders only if they were placed on February 12, 2022
SELECT c.custid, 
	   c.companyname, 
	   o.orderid, 
	   o.orderdate 
FROM Sales.Customers c
LEFT OUTER JOIN Sales.Orders o ON c.custid = o.custid AND o.orderdate = '20220212'

-- 8) Explain why the following query isn’t a correct solution query for Exercise 7

/*
	• პირველი ვარიანტი თარიღის მიხედვით ფილტრავს, მხოლოდ იმ შეკვეთებს აჩვენებს, რომლებსაც აქვთ orderdate = '20220212'
	• მეორე ვარიანტი ყველა კლიენტს აჩვენებს, მაგრამ მათი შეკვეთები უნდა იყოს NULL ან orderdate = '20220212' 
*/
SELECT C.custid,
	   C.companyname, 
	   O.orderid, 
	   O.orderdate
FROM Sales.Customers AS C 
LEFT OUTER JOIN Sales.Orders AS O ON O.custid = C.custid
WHERE O.orderdate = '20220212' OR O.orderid IS NULL;

-- 9) Return all customers, and for each return a Yes/No value depending on whether the customer placed orders on February 12, 2022
SELECT DISTINCT c.custid, c.companyname,
CASE WHEN o.orderid IS NOT NULL THEN 'Yes' ELSE 'No' END AS HasOrderOn20220212
FROM Sales.Customers c
LEFT OUTER JOIN Sales.Orders o ON c.custid = o.custid AND o.orderdate = '20220212'