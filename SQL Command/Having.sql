USE LessonsDB

   
--თითოეული ასაკისთვის რაოდენობის დათვლა და სახელების გაერთიანება
SELECT COUNT(PersonsID) AS PersonsCount, Age, STRING_AGG(Firstname, ', ') AS Firstnames
FROM Persons
GROUP BY Age;

--ყველაზე მაღალი ასაკის მქონე პირების ასაკის ჯამი
SELECT SUM(Age) AS TotalMaxAge
FROM Persons
WHERE Age = (SELECT MAX(Age) FROM Persons);

--დააჯგუფებს ასაკს რომელიც >= 18 -ზე და HAVING -ით ტოვებს იმ ასაკს, სადაც 3 ზე ნაკლები ადამიანია
SELECT  COUNT(PersonsID) AS AdultPersons, Age, STRING_AGG(Firstname, ', ') AS Firstname
FROM Persons
WHERE Age >= 18
GROUP BY Age
HAVING COUNT(PersonsID) < 2;
