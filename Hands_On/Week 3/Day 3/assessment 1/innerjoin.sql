-- Drop database if it already exists
IF DB_ID('RamakrishnaDB') IS NOT NULL
DROP DATABASE RamakrishnaDB;
GO
-- Create Database
CREATE DATABASE RamakrishnaDB;
GO

-- Use Database
USE RamakrishnaDB;
GO

-- Create Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- Create Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert Data into Customers
INSERT INTO customers VALUES
(1,'Arjun','Reddy'),
(2,'Priya','Sharma'),
(3,'Karthik','Varma'),
(4,'Anjali','Mehta'),
(5,'Rahul','Singh');

-- Insert Data into Orders
INSERT INTO orders VALUES
(201,1,'2025-02-10',1),
(202,2,'2025-02-11',4),
(203,3,'2025-02-12',2),
(204,4,'2025-02-13',1),
(205,5,'2025-02-14',4),
(206,1,'2025-02-15',3);

-- Customer Order Report
SELECT 
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date,
    o.order_status
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_status = 1 
   OR o.order_status = 4
ORDER BY o.order_date DESC;