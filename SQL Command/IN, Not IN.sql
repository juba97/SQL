CREATE DATABASE LessonsDB
USE LessonsDB

CREATE TABLE Persons(
PersonID INT IDENTITY(100,2) PRIMARY KEY,
Firstname VARCHAR(20) NOT NULL,
Lastname VARCHAR(20) NOT NULL,
City VARCHAR(20),
Address VARCHAR(20) CONSTRAINT DF_Address DEFAULT 'Obere Str. 57',
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
33
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
45
);
INSERT INTO Persons(
Firstname,
Lastname,
City,
Age
) VALUES(
'Around ',
'Horn',
'México D.F.',
33
);
INSERT INTO Persons(
Firstname,
Lastname,
City,
Age
) VALUES(
'Ana Trujillo',
'Emparedados',
'London',
22
);
SELECT * FROM Persons

-- აბრუნებს მაქ, ასაკს
SELECT MAX(Age) FROM Persons

SELECT * FROM Persons
WHERE Age = (SELECT MAX(Age) FROM Persons)

CREATE TABLE Orders(
Personid INT IDENTITY(100,2) PRIMARY KEY,
Ordernumber INT,
OrderID INT,
CONSTRAINT FK_Order FOREIGN KEY (Personid) REFERENCES Persons(PersonID) 
)

SELECT * FROM Orders

INSERT INTO Orders(
Ordernumber,
OrderID
) VALUES (
10,
33
);
INSERT INTO Orders(
Ordernumber,
OrderID
) VALUES (
22,
43
);
INSERT INTO Orders(
Ordernumber,
OrderID
) VALUES (
19,
21
);
INSERT INTO Orders(
Ordernumber,
OrderID
) VALUES (
18,
87
);

SELECT MIN(OrderID) FROM Orders

-- SubQuery რომელიც აბრუნებს ყველას რომლებსაც მინ, ასაკი აქვთ
SELECT * FROM Orders
WHERE OrderID = (SELECT MAX(OrderID) FROM Orders)

SELECT * FROM Persons
WHERE Age > 18 AND Age < 45

--ვეძებთ კონკრეტულ მნიშვნელობებს ცხრილში
SELECT * FROM Persons
--SubQuery რომელიც მიმართავს Firstnaame-ს იპოვოს ცვხრილში ელემენტები რომლებიც იწყება A -ზე, იგივეა რაც OR ოპერატორი
WHERE Firstname IN (SELECT Firstname FROM Persons WHERE Firstname  LIKE 'A%')

--ისეთ მნიშვნელობებს გამოიტანს რომელიც არ არის მითითებული პირობის შესაბამისი
SELECT * FROM Persons
WHERE Age NOT IN (45,22) 
