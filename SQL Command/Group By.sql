CREATE DATABASE LessonsDB
USE LessonsDB

CREATE TABLE Persons(
PersonsID INT IDENTITY(1,1) PRIMARY KEY,
Firstname VARCHAR(20) NOT NULL,
Lastname VARCHAR(20)NOT NULL,
City VARCHAR(20),
Address VARCHAR(20) CONSTRAINT DF_Address DEFAULT 'Mataderos 2312',
Age INT CONSTRAINT Chk_Age CHECK (Age >= 18)
);

INSERT INTO Persons(
Firstname,
Lastname,
City,
Age
)VALUES(
'Antonio',
'Moreno',
'México D.F.',
33
);
INSERT INTO Persons(
Firstname,
Lastname,
City,
Age
)VALUES(
'Thomas',
'Hardy', 
'London',
18
);
INSERT INTO Persons(
Firstname,
Lastname,
Address,
City,
Age
)VALUES(
'Christina',
'Berglund', 
'Berguvsvägen 8',
'Luleå',
33
);
INSERT INTO Persons(
Firstname,
Lastname,
Address,
City,
Age
)VALUES(
'Ana',
'Trujillo', 
'Constitución 2222',
'London',
25
);
SELECT MAX(Age) FROM Persons
SELECT * FROM Persons
WHERE Age = (SELECT MAX(Age) FROM Persons)

SELECT SUM(Age) FROM Persons
WHERE Age = (SELECT MAX(Age) FROM Persons)

CREATE TABLE Orders(
OrdersID INT IDENTITY (1,1) PRIMARY KEY,
Ordernumber INT,
Orderdate INT,
CONSTRAINT FK_ORDERS FOREIGN KEY (OrdersID) REFERENCES Persons(PersonsID)
);

ALTER TABLE Orders
ALTER COLUMN Orderdate DECIMAL(5,2)

INSERT INTO Orders(
Ordernumber,
Orderdate
)VALUES(
44,
'03.04'
);
SELECT * FROM Orders
INSERT INTO Orders(
Ordernumber,
Orderdate
)VALUES(
36,
'5.6'
);
INSERT INTO Orders(
Ordernumber,
Orderdate
)VALUES(
44,
'03.04'
);

SELECT * FROM Persons
SELECT * FROM Orders

SELECT P.PersonsID AS ID, P.Firstname AS Fname, P.Lastname AS Lname, O.OrdersID AS Oid, O.Ordernumber AS number, O.Orderdate AS date
FROM Persons AS P, Orders AS O 
WHERE P.PersonsID = O.OrdersID

SELECT Persons.PersonsID, Persons.Firstname, Persons.Lastname, Persons.Address, Persons.Age, Persons.City, Orders.Orderdate, Orders.Ordernumber, Orders.OrdersID
FROM Persons 
LEFT JOIN Orders ON Persons.PersonsID = Orders.OrdersID

SELECT * FROM Persons
WHERE Age NOT IN (18)

SELECT * FROM Persons
WHERE Age BETWEEN 18 AND 25

--მონაცემების ჯგუფებად დაყოფისთვის, გარკვეული სვეტების მიხედვით
SELECT COUNT(PersonsID) AS PersonsID, City FROM Persons
GROUP BY City
ORDER BY COUNT(PersonsID) ASC;


--ითვლის რამდენი მომხმარებელია ერთი და იგივეა საკის 
SELECT Persons.Age, COUNT(Persons.Age) AS AgeCount
FROM Persons
LEFT JOIN Orders ON Persons.PersonsID = Orders.OrdersID
GROUP BY Persons.Age;
