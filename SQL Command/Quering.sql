--შევქმნათ ბაზაა
CREATE DATABASE Lessons
USE Lessons

  
--შევქმნათ ცხრილი სადაც შევიტანთ ინფორმაციას პიროვნებაზა
CREATE TABLE Persons(
PersonID INT IDENTITY(1,1) PRIMARY KEY,
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) NOT NULL,
City VARCHAR(20),
Address VARCHAR(20) CONSTRAINT DF_Address DEFAULT '	Mataderos 2312',
Age INT CONSTRAINT Chk_Age CHECK(Age >= 18)
);

--ცხრილში ინფორმაციის შეტანა
INSERT INTO Persons(
FirstName,
LastName,
City,
Age
)VALUES(
'Alfreds',
'Futterkiste',
'Berlin',
18
);
INSERT INTO Persons(
FirstName,
LastName,
City,
Address,
Age
)VALUES(
'Christina',
'Berglund',
'Luleå',
'Berguvsvägen 8',
18
);
INSERT INTO Persons(
FirstName,
LastName,
City,
Address,
Age
)VALUES(
'Antonio',
'Moreno',
'México D.F.',
'120 Hanover Sq.',
40
);

--გამოიტანს მაქსიმალურ მნიშვნელობას
SELECT MAX(Age) FROM Persons

--გამოიტანს ცხრილში რამდენ ადამიანს აქვს მინ, ასაკი
SELECT * FROM Persons
WHERE Age = (SELECT MIN(Age) FROM Persons)

--ირჩევს ბაზაში მინ, ასაკის მქონე პირებს და მათ ასაკს აჯამებს
SELECT SUM(Age) FROM Persons
WHERE Age = (SELECT MIN(Age) FROM Persons);

--ვქმნით ORDER ცხრილს რომელიც უკავშირდება PERSON ცხრილს
CREATE TABLE Orders(
OrderID INT IDENTITY(1,1) PRIMARY KEY,
CustomerID INT,
OrderDate INT,
CONSTRAINT FK_Orders FOREIGN KEY (OrderID) REFERENCES Persons(PersonID)
);

--ORDER ცხრილში ინფორმაციის შეტანა
INSERT INTO Orders(
CustomerID,
OrderDate
)VALUES(
101,
2025
);
INSERT INTO Orders(
CustomerID,
OrderDate
)VALUES(
102,
2024
);
INSERT INTO Orders(
CustomerID,
OrderDate
)VALUES(
103,
2023
);

SELECT * FROM Orders
SELECT * FROM Persons

--ვაერთიანებთ 2 ცხრილს, PERSONS და ORDERS
SELECT P.PersonID AS [ID P], P.LastName AS [Lastname P], P.FirstName AS [FirstName P], P.City AS [City P], P.Age AS [Age P],
O.CustomerID AS [Customer ID], O.OrderID AS [Order ID], O.OrderDate AS [Order ID]
FROM Persons AS P, Orders AS O
WHERE P.PersonID = O.OrderID;

--იპოვის მომხმარებელს რომლის სახელის პირველი ასო იწყება C -ზე
SELECT * FROM Persons
WHERE FirstName LIKE 'C%'

--ამოიღებს მნიშვნელობას 18 -დან 22 -მდე
SELECT * FROM Persons
WHERE Age BETWEEN 18 AND 22

--გამოიტანს მნიშვნელობას რომელიც = 40 -ის
SELECT Age FROM Persons
WHERE Age IN (40)

-- ცხრილში დააჯამებს მინ, ასაკებს რომელიც >=18 და <=40
SELECT SUM(Age) FROM Persons
WHERE Age >= 18 AND Age <= 40;
