CREATE DATABASE LessonsDB
USE LessonsDB
   
CREATE TABLE Persons(
ID VARCHAR (20),
Name VARCHAR (20),
LastName VARCHAR (20),
Addres VARCHAR (20),
City VARCHAR (20),
)

INSERT INTO Persons(
ID,
Name,
LastName,
Addres,
City
) VALUES(
1,
'Maria',
'Anders',
'Obere Str. 57',
'Berlin'
)

INSERT INTO Persons VALUES(2,'Ana', 'Trujillo', 'de la Constitución 2222', 'México D.F.')

INSERT INTO Persons (
Name,
LastName,
Addres
) VALUES(
'Antonio',
'Moreno',
'México D.F.'
)

UPDATE Persons
SET AGE = 33
WHERE ID = 104;

SET IDENTITY_INSERT dbo.Persons OFF;

DELETE FROM Persons
WHERE ID = 3;


ALTER TABLE Persons
DROP COLUMN ID

ALTER TABLE Persons
ADD  ID INT IDENTITY(100,2) PRIMARY KEY
ALTER TABLE Persons
ADD  AGE VARCHAR(20)

ALTER TABLE Persons
DROP COLUMN AGE

ALTER TABLE Persons
ADD AGE INT CHECK(AGE >= 18) 

UPDATE Persons
SET AGE = 18
WHERE ID = 102;

ALTER TABLE Persons
ADD CONSTRAINT DF_ADDRES DEFAULT 'AVLABRIS 38' FOR Addres
SET IDENTITY_INSERT Persons ON;

ALTER TABLE Persons
DROP COLUMN Name

ALTER TABLE Persons
ADD Name VARCHAR(20)
  
UPDATE Persons
SET Name = 'Thomas'
WHERE ID = 104

UPDATE Persons
SET Name = 'Christina'
WHERE ID = 100

ALTER TABLE Persons
ALTER COLUMN Name VARCHAR(20) NOT NULL

ALTER TABLE Persons
ALTER COLUMN LastName VARCHAR(20) NOT NULL

CREATE TABLE ORDERS(
ORDERID INT PRIMARY KEY IDENTITY(1,1),
ORDERNUMBERS INT NOT NULL,
PIRADIID INT,
CONSTRAINT FK_PIRADID FOREIGN KEY (PIRADIID) REFERENCES Persons(ID)
);

-- პოულობს ყველა ელემენტს ბაზაში
SELECT * FROM Persons;

-- ითვლის ყველა ელემენტს ბაზაში
SELECT COUNT (*) FROM Persons

SELECT ID FROM Persons
WHERE ID >= 100;

--იპოვის ასაკს რომელიც მეტია ან ტოლია 18-ზე და სახელი შეესაბამება 'ლანა'-ს
SELECT * FROM Persons
WHERE AGE >= 18 AND Name = 'Maria';
