CREATE DATABASE NOTEBOOK
USE NOTEBOOK

      
--შეიქმნა ცხრილი რომელშიც შეტანილია მომხმარებლის Name და ID
CREATE TABLE customers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

--შეიქმნა ცხრილი სადაც შეტანილია ID, AMOUNT AND CREDIT_DATE და REFERENCE -ით უკავშირდება CUSTOMERS ID -ს
CREATE TABLE credits (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2) NOT NULL,
    credit_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

--შეიქმნა ცხრილი სადაც შევიტანთ დარჩენილი გადასახადის შესახებ ინფორმაციას
CREATE TABLE payments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    credit_id INT,
    amount_paid DECIMAL(10,2) NOT NULL,
    paid_date DATE NOT NULL,
    FOREIGN KEY (credit_id) REFERENCES credits(id)
);

INSERT INTO customers (name) VALUES 
('Maria  Anders'),
('Antonio Moreno');
INSERT INTO customers (name) VALUES 
('Christina Berglund'),
('Thomas Hardy');

INSERT INTO credits (customer_id, amount, credit_date) VALUES 
(1, 500.00, '2024-01-15'),
(2, 300.00, '2024-02-10');
INSERT INTO credits (customer_id, amount, credit_date) VALUES 
(3, 400.00, '2024-01-15'),
(4, 600.00, '2024-02-10');

INSERT INTO payments (credit_id, amount_paid, paid_date) VALUES 
(1, 200.00, '2024-03-01'),
(2, 150.00, '2024-04-01');
INSERT INTO payments (credit_id, amount_paid, paid_date) VALUES 
(3, 200.00, '2024-03-01'),
(4, 150.00, '2024-04-01');

-- აქ გამოვიტანთ თუ რამდენი აიღო კრედიტი, რამდენი გადაიხადა და რამდენი დარჩა გადასახდელი
SELECT 
    customers.name, 
    SUM(credits.amount) AS total_credit, 
    SUM(payments.amount_paid) AS total_paid,
    SUM(credits.amount) - SUM(payments.amount_paid) AS remaining_balance
FROM customers
INNER JOIN credits ON customers.id = credits.customer_id
LEFT JOIN payments ON credits.id = payments.credit_id
GROUP BY customers.name;
