ALTER TABLE Users
ADD last_login DATE
     
SELECT * FROM Users

      
UPDATE Users
SET last_login = '2018-08-17'
WHERE id = 9

SELECT id, name, last_login 
FROM Users 
ORDER BY last_login DESC;

SELECT * FROM Orders

-- მოთხოვნა, რომელიც დააბრუნებს ყველაზე მაღალი და ყველაზე დაბალი შეკვეთის თანხას.
SELECT 
    u1.name AS Users1, 
    o1.amount AS [Max Amount],
    u2.name AS Users2,
    o2.amount AS [Min Amount]
FROM Users u1
JOIN Orders o1 ON u1.id = o1.userID
JOIN Orders o2 ON o2.amount = (SELECT MIN(amount) FROM Orders)
JOIN Users u2 ON u2.id = o2.userID
WHERE o1.amount = (SELECT MAX(amount) FROM Orders)

--4 ყველაზე ახალი შეკვეთის ჩვენება
SELECT TOP 4 u.name, o.order_date
FROM Orders o
JOIN Users u ON u.id = o.userID
ORDER BY order_date DESC

--ერთზე მეტი შეკვეთის მქონე მომხმარებლების პოვნა
SELECT u.name, COUNT(o.order_id) AS TotalOrder
FROM Users u
JOIN Orders o ON u.id = o.userID
GROUP BY u.name

--პროდუქტის საშუალო ფასი კატეგორიის მიხედვით
SELECT p.category_id, c.category_name, AVG(p.price) AS avg_price
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
GROUP BY p.category_id, c.category_name;

--ყველაზე მეტი შეკვეთა თვის მიხედვით
SELECT 
    YEAR(order_date) AS Year,
    MONTH(order_date) AS Month,
    COUNT(*) AS order_count
FROM Orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_count DESC

--მომხმარებლების პოვნა, რომლებიც არ აკეთებენ შეკვეთებს
SELECT u.name, o.amount, o.order_id
FROM Users u
LEFT JOIN Orders o ON u.id = o.userID
WHERE amount IS NULL

SELECT email, name
FROM Users
WHERE email LIKE '%gmailcom'

--მომხმარებლების ყველაზე ხშირად გამოყენებული დომენი
SELECT 
    SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email)) AS domain, 
    COUNT(*) AS domain_count
FROM Users
GROUP BY SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email))
ORDER BY domain_count DESC

ALTER TABLE Products
ADD price INT

UPDATE Products
SET price = 130
WHERE product_id = 10
