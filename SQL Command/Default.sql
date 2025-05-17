CREATE DATABASE Lessons
USE Lessons

--თეიბლის შექმნა
CREATE TABLE Persons(
Firstname VARCHAR(20),
Lastname VARCHAR(20),
City VARCHAR(20),
Addres VARCHAR(20),
)

--თეიბლში დამატება
ALTER TABLE Persons
ADD PersonalID VARCHAR(20);

ALTER TABLE Persons
ADD Age VARCHAR(2);

--თერიბლის შევსება ინფორმაციით
INSERT INTO Persons(
Firstname,
Lastname,
City,
Addres,
PersonalID,
Age
) VALUES(
'Juba',
'Koguashvili',
'Kutaisi',
'Buxaidze',
'6000',
'27'
)

INSERT INTO Persons VALUES('Galaktion', 'Tabidze', 'Tbilisi', 'Rustaveli', '5000', '40')

INSERT INTO Persons (
Firstname,
Lastname,
City,
Age
)VALUES('Galaktion', 'Tabidze', 'Tbilisi', '21')


--თეიბლიდან ამოშლა
ALTER TABLE Persons
DROP COLUMN PersonalID

--თეიბლში უნიკალური მონაცემი
ALTER TABLE Persons
ADD PersonalID INT IDENTITY(1,2) PRIMARY KEY

ALTER TABLE Persons
DROP COLUMN Age

--თეიბლში შეზღუდვის დაყენება რომ არ შეივსოს 18-ზე ნაკლები ასაკით ველი
ALTER TABLE Persons
ADD Age INT CHECK (Age>=18) 

--თეიბლის განახლება
UPDATE Persons
SET Age = 27
WHERE  PersonalID= 1;

--თეიბლში ინფორმაციის შეყვანა აუცილებელია
ALTER TABLE Persons
ALTER COLUMN Age INT NOT NULL;

--თუ მომხმარებელი მნიშვნელობას არმიუთითებს, Default-ად იქნება "თბილისი"
ALTER TABLE Persons
ADD CONSTRAINT DF_Addres DEFAULT 'Tbilisi' FOR Addres

--კონკრეტული ქოლუმნის ამოშლა
DELETE FROM Persons
WHERE PersonalID = 5;
