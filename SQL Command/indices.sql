USE Exercises5

EXEC sp_rename  'Customers.CustomerId', 'CustomerID', 'COLUMN'

CREATE INDEX sample_index on Customers(name);

SELECT name FROM Customers


CREATE TABLE TEST(
id INT,
name VARCHAR(20)
);
CREATE CLUSTERED INDEX IX_1 ON TEST(id)

INSERT INTO TEST(id, name)
VALUES
(1,'Maria Anders'),
(2,'Ana Trujillo'),
(3,'Antonio Moreno'),
(4,'Thomas Hardy'),
(5,'Maria Anders')

SELECT id
FROM TEST
WHERE id = 1

CREATE TABLE Test2 (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    City NVARCHAR(50)
);


INSERT INTO Test2(FirstName, LastName, Email, City)
SELECT
    LEFT(NEWID(), 8),           -- უნიკალური FirstName
    LEFT(NEWID(), 8),           -- უნიკალური LastName
    LEFT(NEWID(), 8) + '@mail.com', -- უნიკალური Email
    CASE 
        WHEN ABS(CHECKSUM(NEWID())) % 3 = 0 THEN 'Tbilisi'
        WHEN ABS(CHECKSUM(NEWID())) % 3 = 1 THEN 'Batumi'
        ELSE 'Kutaisi'
    END
FROM sys.all_objects a
CROSS JOIN sys.all_objects b
WHERE a.object_id < 200 -- ეს ქმნის ~10,000 ჩანაწერს

SELECT * FROM Test2
WHERE Email = '2A47DE6B@mail.com';

CREATE NONCLUSTERED INDEX IX_Test2_Email
ON Test2 (Email);


SELECT * FROM Test2
WHERE Email = '9C5ADA2B@mail.com';

SELECT * FROM Test2

EXEC sp_helpindex 'Test2';

DROP INDEX [IX_Test2_Email] ON [Test2];
