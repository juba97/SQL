CREATE DATABASE LessonsDB
USE LessonsDB
  

CREATE TABLE Persons(
PersonsID INT IDENTITY(1,1) PRIMARY KEY,
name VARCHAR(20) NOT NULL,
lastname VARCHAR(20) NOT NULL,
city VARCHAR(20),
address VARCHAR(20) CONSTRAINT df_address DEFAULT '120 Hanover Sq.',
age INT CHECK (age >= 18)
);

CREATE TABLE Orders(
OrderID INT IDENTITY(1,1) PRIMARY KEY,
ordernamber INT,
orderdate DATE
CONSTRAINT fk_orders FOREIGN KEY (OrderID) REFERENCES Persons(PersonsID)
);

INSERT INTO Persons(
name,
lastname,
city,
age
)VALUES(
'Maria',
'Anders',
'Berlin',
33
);
INSERT INTO Persons(
name,
lastname,
city,
age
)VALUES(
'Ana',
'Trujillo',
'México D.F.',
33
);
INSERT INTO Persons(
name,
lastname,
city,
address,
age
)VALUES(
'Thomas',
'Hardy',
'Berguvsvägen 8.',
'London',
43
);


INSERT INTO Orders(
ordernamber,
orderdate
)VALUES(
1209,
'2017-06-15'
)
INSERT INTO Orders(
ordernamber,
orderdate
)VALUES(
3521,
'2008-11-09'
)
INSERT INTO Orders(
ordernamber,
orderdate
)VALUES(
4526,
'2008-11-11'
)

SELECT Persons.PersonsID, Orders.OrderID, Persons.name, Persons.lastname, Persons.city, Persons.address, Persons.age, Orders.ordernamber, Orders.orderdate
FROM Persons
LEFT JOIN Orders ON Persons.PersonsID = Orders.OrderID

SELECT * FROM Persons
WHERE age = (SELECT MIN(age) FROM Persons)

SELECT COUNT(age) AS TotAlage, STRING_AGG(name, ', ') AS Name FROM Persons
GROUP BY age
HAVING age >= 33

SELECT * FROM Persons
WHERE lastname LIKE 'A%'

SELECT SUM (age) AS Total FROM Persons
WHERE age = (SELECT MIN(age) FROM Persons)

SELECT COUNT(PersonsID), age FROM Persons
GROUP BY age
HAVING COUNT(PersonsID) = 2
