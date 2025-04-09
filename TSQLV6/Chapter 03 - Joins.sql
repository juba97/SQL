SELECT  C.custid, 
	E.empid
FROM Sales.Customers AS C
CROSS JOIN HR.Employees AS E;

SELECT  E1.empid, 
	E1.firstname, 
	E1.lastname, 
	E2.empid, 
	E2.firstname, 
	E2.lastname
FROM HR.Employees AS E1 
CROSS JOIN HR.Employees AS E2;

DROP TABLE IF EXISTS dbo.Digits;
CREATE TABLE dbo.Digits(digit INT NOT NULL PRIMARY KEY);
INSERT INTO dbo.Digits(digit)  VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
SELECT digit FROM dbo.Digits;

SELECT D3.digit * 100 + D2.digit * 10 + D1.digit + 1 AS n
FROM dbo.Digits AS D1 
CROSS JOIN dbo.Digits AS D2 
CROSS JOIN dbo.Digits AS D3
ORDER BY n;


SELECT  E.empid, 
	E.firstname, 
	E.lastname, 
	O.orderid
FROM HR.Employees AS E
INNER JOIN Sales.Orders AS O ON E.empid = O.empid

SELECT  E.empid,
	E.firstname,
	E.lastname, 
	O.orderid
FROM HR.Employees AS E, Sales.Orders AS O
WHERE E.empid = O.empid;

SELECT  E.empid, 
	E.firstname, 
	E.lastname, 
	O.orderid
FROM HR.Employees AS E, Sales.Orders AS O

SELECT  E1.empid,
	E1.firstname, 
	E1.lastname, 
	E2.empid, 
	E2.firstname, 
	E2.lastname
FROM HR.Employees AS E1 
CROSS JOIN HR.Employees AS E2;

SELECT D3.digit * 100 + D2.digit * 10 + D1.digit + 1 AS n
FROM  dbo.Digits AS D1 
CROSS JOIN dbo.Digits AS D2  
CROSS JOIN dbo.Digits AS D3
ORDER BY n;

SELECT value
FROM GENERATE_SERIES(1, 100, 5);

SELECT 
    e1.firstname AS OlderEmpFirstName,
    e1.lastname AS OlderEmpLastName,
    e1.hiredate AS OlderHireDate,
    e2.firstname AS YoungerEmpFirstName,
    e2.lastname AS YoungerEmpLastName,
    e2.hiredate AS YoungerHireDate
FROM HR.Employees e1
INNER JOIN HR.Employees e2 ON e1.empid < e2.empid

SELECT  e1.empid,
	e2.empid
FROM HR.Employees e1
CROSS JOIN HR.Employees e2

SELECT  e1.empid,
	e1.firstname,
	e1.lastname, 
	n2.n 
FROM HR.Employees e1
CROSS JOIN  Nums n2 
WHERE n2.n <= 5

SELECT  C.custid, 
	C.companyname,
	O.orderid, 
	O.orderdate
FROM Sales.Customers AS C 
INNER JOIN Sales.Orders AS O  ON C.custid = O.custid;


SELECT  C.custid,
	C.companyname,
	O.orderid, 
	O.orderdate
FROM Sales.Customers AS C  
INNER JOIN Sales.Orders AS O ON C.custid = O.custid;

SELECT orderid,
       orderdate,
       custid, 
       empid
FROM Sales.Orders
WHERE orderdate = DATEADD(month, DATEDIFF(month, '18991231', orderdate), '18991231')


SELECT  C.custid, 
        C.companyname,
	O.orderid, 
	O.orderdate
FROM Sales.Customers AS C  
LEFT OUTER JOIN Sales.Orders AS O ON C.custid = O.custid
WHERE O.orderdate >= '20220101'
