CREATE DATABASE LessonsDB
USE LessonsDB

CREATE TABLE Persons(
PersonsID INT IDENTITY(1,1) PRIMARY KEY,
Firstname VARCHAR(20) NOT NULL,
Lastname VARCHAR(20) NOT NULL,
City VARCHAR(20),
Adrees VARCHAR(20) CONSTRAINT DF_Address DEFAULT 'Obere Str. 57',
Age INT CHECK (Age>=18)
);
INSERT INTO Persons(
Firstname,
Lastname,
City,
Age
) VALUES(
'Berglunds',
'snabbköp',
'Luleå',
'33'
);

SELECT * FROM Persons

INSERT INTO Persons(
Firstname,
Lastname,
City,
Age
) VALUES('Around', 'horn', 'London', '45');

CREATE TABLE Orders(
PersonsID INT,
OrderID INT IDENTITY(1,1) PRIMARY KEY,
Ordernumber INT,
CONSTRAINT FK_Persons FOREIGN KEY (PersonsID) REFERENCES Persons(PersonsID)
)

INSERT INTO Orders(
Ordernumber
) VALUES(10 ,2)

SELECT * FROM Orders

UPDATE Orders
SET Ordernumber = 2
WHERE OrderID = 1;

SELECT * FROM Persons
WHERE Age > 30 AND Age < 40
ORDER BY  Age ASC

SELECT DISTINCT Age FROM Persons

SELECT TOP 2 * FROM Persons

SELECT MIN(Age) FROM Persons

SELECT MAX(Age) FROM Persons

SELECT * FROM Persons
WHERE Age = (SELECT MAX(Age) FROM Persons)


