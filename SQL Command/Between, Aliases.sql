CREATE DATABASE LessonsDB
USE LessonsDB
   
CREATE TABLE Persons(
PersonID INT IDENTITY(1,1) PRIMARY KEY,
Fname VARCHAR(20),
Lname VARCHAR(20),
City VARCHAR(20),
Address VARCHAR(20) CONSTRAINT DF_Address DEFAULT '	Obere Str. 57',
);

ALTER TABLE Persons
ADD Age INT

ALTER TABLE Persons
ADD CONSTRAINT CK_Age CHECK(Age >= 18)

ALTER TABLE Persons
ADD Fname VARCHAR(20)

ALTER TABLE Persons
ALTER COLUMN Lname VARCHAR(50) NOT NULL;

ALTER TABLE Persons
DROP COLUMN Age

ALTER TABLE Persons
DROP CONSTRAINT CK__Persons__Age__38996AB5;

INSERT INTO Persons(
Fname,
Lname,
City,
Age
) VALUES(
'Alfreds',
'Futterkiste',
'London',
22
);
INSERT INTO Persons(
Fname,
Lname,
City,
Age
) VALUES(
'Berglunds',
'snabbköp',
'Lisabon',
18
);
INSERT INTO Persons(
Fname,
Lname,
City,
Age
) VALUES(
'Antonio',
'Taquería',
'México D.F.',
18
);

SELECT MIN(Age) FROM Persons
SELECT * FROM Persons
WHERE Age = (SELECT MIN(Age) FROM Persons)

SELECT * FROM Persons

CREATE TABLE Orders(
PersonID INT,
OrderID INT IDENTITY(1,1) PRIMARY KEY,
Ordernumber INT,
CONSTRAINT FG_Persons FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
);

INSERT INTO Orders(
PersonID,
Ordernumber
) VALUES(
1,
99
);

INSERT INTO Orders(
PersonID,
Ordernumber
) VALUES(
3,
44
);
SELECT * FROM Orders

UPDATE Persons
SET Fname = 'Futterkiste'
WHERE PersonID = 4

SELECT SUM(Age) AS Total_Min_Age FROM Persons
WHERE Age = (SELECT MIN(Age) FROM Persons);

SELECT *  FROM Persons
WHERE Age  IN (18,22)
ORDER BY Age DESC

SELECT * FROM Persons
WHERE Lname LIKE 'S%'

SELECT * FROM Persons
WHERE Age BETWEEN 18 AND 20

--აბრუნებს მნიშვნელობას ქოლუმნის შეცვლილ სახელს
SELECT Fname AS Firstname FROM Persons

--ცხრილების გაერთიანება ერთ სვეტში Aliases
SELECT P.PersonID AS pID, P.Lname AS Lastname, O.OrderID AS oID, O.Ordernumber AS oNUMBER
FROM Persons AS P, Orders AS O
WHERE P.PersonID = O.PersonID
