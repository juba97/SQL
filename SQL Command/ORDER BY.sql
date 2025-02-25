CREATE DATABASE LessonsDB
USE LessonsDB
SELECT * FROM Persons

CREATE TABLE Persons(
PersonsID INT IDENTITY(1,1) PRIMARY KEY,
Firstname VARCHAR(20),
Lastname VARCHAR(20),
City VARCHAR(20),
Address VARCHAR(20) CONSTRAINT DF_Address DEFAULT 'Obere Str. 57',
Age INT CHECK (Age >= 18)
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
'22'
);

INSERT INTO Persons(
Firstname,
Lastname,
City,
Age
) VALUES (
'Antonio',
'Moreno',
'México D.F.',
'46'
);

ALTER TABLE Persons 
ALTER COLUMN Lastname VARCHAR(20) NOT NULL

CREATE TABLE Orders(
PersonsID INT,
OrdersID INT IDENTITY(1,1) PRIMARY KEY,
OrdersNumber INT,
CONSTRAINT FK_Persons FOREIGN KEY (PersonsID) REFERENCES Persons(PersonsID)
)

INSERT INTO Orders(
PersonsID,
OrdersNumber
) VALUES (
'100',
'21240'
);
INSERT INTO Persons (PersonsID, Firstname, Lastname, Age) VALUES (100, 'John', 'Doe', '35');

SELECT * FROM Persons
WHERE Age > 22 AND Age < 42

SELECT * FROM Persons
ORDER BY Age ASC
