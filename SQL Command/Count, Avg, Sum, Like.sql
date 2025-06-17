CREATE DATABASE LessonsDB
USE LessonsDB

   
CREATE TABLE Persons(
PersonID INT IDENTITY (1,1) PRIMARY KEY,
Firstname VARCHAR(20) NOT NULL,
Lastname VARCHAR(20) NOT NULL,
City VARCHAR(20),
Address VARCHAR(20) CONSTRAINT DF_Adress DEFAULT 'Obere Str. 57',
Age INT CHECK(Age >= 18)
);

INSERT INTO Persons(
Firstname,
Lastname,
City,
Age
) VALUES(
'Alfreds',
'Futterkiste',
'Berlin',
'23'
);
INSERT INTO Persons(
Firstname,
Lastname,
City,
Age
) VALUES(
'Antonio ',
'Taquería',
'Luleå',
'35'
);
INSERT INTO Persons(
Firstname,
Lastname,
City,
Address,
Age
) VALUES(
'Berglunds',
'snabbköp',
'México D.F.',
'Mataderos 2312',
'34'
);

INSERT INTO Persons(
Firstname,
Lastname,
City,
Address,
Age
) VALUES(
'Around',
'Horn',
'London',
'120 Hanover Sq.',
'55'
);

SELECT * FROM Persons

SELECT MIN(Age) FROM Persons
SELECT * FROM Persons
WHERE Age = (SELECT MIN(Age) FROM Persons)

SELECT * FROM Persons
ORDER BY PersonID DESC

SELECT * FROM Persons
WHERE Age > 20 AND age < 34

CREATE TABLE Orders(
PersonID INT,
OrderID  INT IDENTITY (1,1) PRIMARY KEY,
Ordernumber INT,
CONSTRAINT FK_Persons FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
)
SELECT * FROM Persons
INSERT INTO Orders(
PersonID,
Ordernumber
)VALUES(
1,
99
);
INSERT INTO Orders(
PersonID,
Ordernumber
)VALUES(
2,
76
);
INSERT INTO Orders(
PersonID,
Ordernumber
)VALUES(
3,
53
);

DELETE FROM Persons
WHERE PersonID = 4

-- გამოაქვს ცხრილში არსებული ინფორმაცია რომელსაც თვლის, საშვალო არითმეტიკული, და აჯამებს
SELECT COUNT(*) FROM Persons
WHERE Age >=24;
SELECT AVG(Age) FROM Persons
SELECT SUM(Age) FROM Persons
WHERE Age >=24  AND Age <= 55

--ეძებს მნიშვნელობებს რომელიც იწყება AB-ზე
SELECT * FROM Persons
WHERE Firstname LIKE '[AB]%';
