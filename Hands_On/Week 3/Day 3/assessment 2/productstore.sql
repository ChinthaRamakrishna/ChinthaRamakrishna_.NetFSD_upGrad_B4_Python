-- Drop database if it already exists
IF DB_ID('ProductStoreDB') IS NOT NULL
DROP DATABASE ProductStoreDB;
GO

-- Create Database
CREATE DATABASE ProductStoreDB;
GO

-- Use Database
USE ProductStoreDB;
GO

-- Create Brands Table
CREATE TABLE brands (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(50)
);

-- Create Categories Table
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

-- Create Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    brand_id INT,
    category_id INT,
    model_year INT,
    list_price DECIMAL(10,2),
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Insert Data into Brands
INSERT INTO brands VALUES
(1,'Nike'),
(2,'Adidas'),
(3,'Puma');

-- Insert Data into Categories
INSERT INTO categories VALUES
(1,'Shoes'),
(2,'Clothing'),
(3,'Accessories');

-- Insert Data into Products
INSERT INTO products VALUES
(101,'Running Shoes',1,1,2023,650),
(102,'Sports T-Shirt',2,2,2022,350),
(103,'Training Shoes',3,1,2024,720),
(104,'Jacket',2,2,2023,900),
(105,'Cap',1,3,2023,250),
(106,'Sneakers',1,1,2024,800);

-- Product Price Listing by Category
SELECT 
    p.product_name,
    b.brand_name,
    c.category_name,
    p.model_year,
    p.list_price
FROM products p
INNER JOIN brands b
ON p.brand_id = b.brand_id
INNER JOIN categories c
ON p.category_id = c.category_id
WHERE p.list_price > 500
ORDER BY p.list_price ASC;