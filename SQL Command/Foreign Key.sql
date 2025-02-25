CREATE DATABASE LessonsDB
USE LessonsDB

CREATE TABLE Persons(
PersonID VARCHAR(20),
Firstname VARCHAR(20),
Lastname VARCHAR(20),
Addres VARCHAR(20),
City VARCHAR(20),
)

INSERT INTO Persons(
PersonID,
Firstname,
Lastname,
Addres,
City
) VALUES(
1,
'JUBA',
'KOGUASHVILI',
'BUXAIDZE',
'KUTAISI'
);
INSERT INTO Persons VALUES(2,'MURMAN', 'NIORADZE', 'RUSTAVELI', 'TBILISI')


INSERT INTO Persons (
Firstname,
Lastname,
City
) VALUES(
'SEBASTIAN',
'BAXI',
'TERJOLA'
)

ALTER TABLE Persons
DROP COLUMN PersonID

ALTER TABLE Persons
ADD  PersonsID INT IDENTITY(100,2) PRIMARY KEY

ALTER TABLE Persons
DROP COLUMN Age

ALTER TABLE Persons
ADD Age INT CHECK(Age>=18) 

ALTER TABLE Persons
ADD CONSTRAINT DF_Address DEFAULT 'WALENJIXA' FOR Addres

ALTER TABLE Persons
ALTER COLUMN Firstname VARCHAR(20) NOT NULL

ALTER TABLE Persons
ALTER COLUMN Lastname VARCHAR(20) NOT NULL


UPDATE Persons
SET Age = 22
WHERE PersonsID = 104;

--ცხრილებს შორის კავშირის შესაქმნელად
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderNumber INT NOT NULL,
    PersonsID INT,
    CONSTRAINT FK_PersonsID FOREIGN KEY (PersonsID) REFERENCES Persons(PersonsID)
);
