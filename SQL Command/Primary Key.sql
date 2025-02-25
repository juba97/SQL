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
'Juba',
'Koguashvili',
'Kutaisi',
'Buxaidze'
);

INSERT INTO Persons1 VALUES(
2,
'Juba!',
'Koguashvili!',
'Kutaisi!',
'Buxaidze!'
);

-- უნიკალური მნიშვნელობები
ALTER TABLE Persons1
ADD PersonsID INT IDENTITY (100,2) PRIMARY KEY

INSERT INTO Persons1 VALUES(
'JUBA',
'KOGUASHVILI',
'KUTAISI',
'BUXAIDZE'),

('SEBASTIAN',
'BAXI',
'VAKE',
'CHAVCHAVADZE');








