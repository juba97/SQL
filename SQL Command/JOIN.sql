CREATE DATABASE LessonsDB
USE LessonsDB

CREATE TABLE Persons(
PersonsID INT IDENTITY(1,1) PRIMARY KEY,
Firstname VARCHAR(20),
Lastname VARCHAR(20),
City VARCHAR(20),
Address VARCHAR(20) CONSTRAINT DF_Address DEFAULT 'Obere Str. 57',
Age INT CHECK(Age >= 18)
);

ALTER TABLE Persons
ALTER COLUMN Lastname VARCHAR(20) NOT NULL
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

SELECT * FROM Persons

SELECT MIN(Age) FROM Persons

SELECT * FROM Persons
WHERE Age = (SELECT MAX(Age) FROM Persons)

CREATE TABLE Orders(
OrdersID INT IDENTITY(1,1) PRIMARY KEY,
Ordernumber INT,
Orderdate INT,
CONSTRAINT FK_ORDERS FOREIGN KEY (OrdersID) REFERENCES Persons(PersonsID) 
);
SELECT * FROM Orders

ALTER TABLE Orders
ALTER COLUMN Orderdate VARCHAR(20)

INSERT INTO Orders(
Ordernumber,
Orderdate
)VALUES(
10,
2025
);
INSERT INTO Orders(
Ordernumber,
Orderdate
)VALUES(
11,
02.15
);
INSERT INTO Orders(
Ordernumber,
Orderdate
)VALUES(
22,
2013
);

UPDATE Orders
SET Ordernumber = '34'
WHERE OrdersID = 2

SELECT SUM(Age) FROM Persons

SELECT SUM(Age) FROM Persons
WHERE Age = (SELECT MAX(Age) FROM Persons)

SELECT * FROM Persons
WHERE Age >= 20 AND Age <=33

SELECT * FROM Persons
WHERE Age NOT IN (33)

SELECT * FROM Persons
WHERE Age BETWEEN 19 AND 40

SELECT * FROM Persons
WHERE Firstname LIKE 'A%'

SELECT * FROM Persons
ORDER BY Age ASC

SELECT Firstname AS Fname FROM Persons
SELECT Firstname AS Fname, Lastname AS Lname, CIty AS CT, Address AS Ad, Age AS Ag, Orderdate AS Odate, Ordernumber AS Onumber
FROM Persons AS P, Orders AS O
WHERE P.PersonsID = O.OrdersID

SELECT Persons.PersonsID, Persons.Firstname, Persons.Lastname, Orders.OrdersID, Orders.Ordernumber, Orders.Orderdate 
FROM Persons
--INNER JOIN აბრუნებს მხოლოდ იმ მონაცემებს, რომლებიც ორივე ცხრილში ემთხვევა.
INNER JOIN Orders ON Persons.PersonsID = Orders.OrdersID

--LEFT JOIN აბრუნებს ყველა ჩანაწერს მარცხენა (პირველი) ცხრილიდან და იმ ჩანაწერებს, რომლებსაც აქვთ შესაბამისი მონაცემები მარჯვენა ცხრილში.
--LEFT JOIN Orders ON Persons.PersonsID = Orders.OrdersID

--RIGHT JOIN მუშაობს LEFT JOIN-ის საპირისპიროდ: აბრუნებს ყველა მონაცემს მარჯვენა ცხრილიდან და შესაბამის ჩანაწერებს მარცხენა ცხრილიდან.
--RIGHT JOIN Orders ON Persons.PersonsID = Orders.

--აბრუნებს ყველა ჩანაწერს ორივე ცხრილიდან
--FULL OUTER JOIN Orders ON Persons.PersonsID = Orders.OrdersID

--CROSS JOIN ქმნის მთლიან კომბინაციას ორივე ცხრილის ჩანაწერებიდან. არ არის ON პირობა.
--CROSS JOIN Orders
