CREATE DATABASE LessonsDB

   
USE LessonsDB

--თეიბლის შექმნა
CREATE TABLE Persons1(
PersonsID VARCHAR(50),
FirstName VARCHAR(50),
LastName VARCHAR(50),
City VARCHAR(50),
Addres VARCHAR(50)
);

----თეიბლიდან ინფორმაციის ამოშლა
TRUNCATE TABLE PEROSNS

--თეიბლიდან სვეტის წაშლა
ALTER TABLE Persons
DROP COLUMN City;

--თეიბლში სვეტის ჩასმა
ALTER TABLE Persons
ADD City VARCHAR(50);

ALTER TABLE Persons  
ALTER COLUMN PersonsID BIGINT;

--თეიბლში მონაცემის გაზრდა
ALTER TABLE Persons
ALTER COLUMN PersonsID varchar(50);

--თეიბლში ინფორმაციის შენახვა
INSERT INTO Persons1(
PersonsID,
FirstName,
LastName,
City,
Addres) VALUES(
1,
'Maria',
'Anders',
'Berlin',
'Obere Str. 57'
);

INSERT INTO Persons1 VALUES(
2,
'Antonio',
'Moreno',
'México D.F.',
'Mataderos 2312'
);

-- უნიკალური მნიშვნელობები
ALTER TABLE Persons1
ADD PersonsID INT IDENTITY (100,2) PRIMARY KEY

INSERT INTO Persons1 VALUES(
'Alfreds',
'Futterkiste',
'Luleå',
'Berguvsvägen 8'),

('Christina',
'Berglund',
'Avda. de la Constitución 2222',
'CHAVCHAVADZE');
