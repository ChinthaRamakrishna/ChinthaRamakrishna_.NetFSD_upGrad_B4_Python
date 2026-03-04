-- Drop database if already exists
IF DB_ID('SalesStoreDB') IS NOT NULL
DROP DATABASE SalesStoreDB;
GO

-- Create Database
CREATE DATABASE SalesStoreDB;
GO

-- Use Database
USE SalesStoreDB;
GO

-- Create Stores Table
CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100)
);

-- Create Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    store_id INT,
    order_status INT,
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

-- Create Order_Items Table
CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    quantity INT,
    list_price DECIMAL(10,2),
    discount DECIMAL(4,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Insert Data into Stores
INSERT INTO stores VALUES
(1,'Hyderabad Store'),
(2,'Delhi Store'),
(3,'Mumbai Store');

-- Insert Data into Orders
INSERT INTO orders VALUES
(101,1,4),
(102,2,4),
(103,1,2),
(104,3,4);

-- Insert Data into Order_Items
INSERT INTO order_items VALUES
(1,101,2,1000,0.10),
(2,101,1,500,0.05),
(3,102,3,800,0.10),
(4,103,2,700,0.00),
(5,104,1,1200,0.15);

-- Store Wise Sales Summary
SELECT 
    s.store_name,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales
FROM stores s
INNER JOIN orders o
ON s.store_id = o.store_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
WHERE o.order_status = 4
GROUP BY s.store_name
ORDER BY total_sales DESC;