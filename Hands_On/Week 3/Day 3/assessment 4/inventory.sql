-- Drop database if it already exists
IF DB_ID('InventoryDB') IS NOT NULL
DROP DATABASE InventoryDB;
GO

-- Create Database
CREATE DATABASE InventoryDB;
GO

-- Use Database
USE InventoryDB;
GO

-- Create Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100)
);

-- Create Stores Table
CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100)
);

-- Create Stocks Table
CREATE TABLE stocks (
    store_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create Order_Items Table
CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    product_id INT,
    store_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

-- Insert Data into Products
INSERT INTO products VALUES
(1,'Laptop'),
(2,'Mobile'),
(3,'Tablet'),
(4,'Headphones');

-- Insert Data into Stores
INSERT INTO stores VALUES
(1,'Hyderabad Store'),
(2,'Delhi Store');

-- Insert Data into Stocks
INSERT INTO stocks VALUES
(1,1,50),
(1,2,30),
(1,3,20),
(2,1,40),
(2,4,25);

-- Insert Data into Order_Items
INSERT INTO order_items VALUES
(1,1,1,10),
(2,2,1,5),
(3,1,2,8),
(4,4,2,7);

-- Product Stock and Sales Analysis
SELECT 
    p.product_name,
    s.store_name,
    st.quantity AS available_stock,
    SUM(ISNULL(oi.quantity,0)) AS total_quantity_sold
FROM stocks st
INNER JOIN products p
ON st.product_id = p.product_id
INNER JOIN stores s
ON st.store_id = s.store_id
LEFT JOIN order_items oi
ON st.product_id = oi.product_id 
AND st.store_id = oi.store_id
GROUP BY 
    p.product_name,
    s.store_name,
    st.quantity
ORDER BY 
    p.product_name;