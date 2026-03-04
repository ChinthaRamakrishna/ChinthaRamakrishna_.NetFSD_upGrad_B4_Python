-- Drop table if already exists
IF OBJECT_ID('Staff', 'U') IS NOT NULL
DROP TABLE Staff;

-- Create Table
CREATE TABLE Staff (
    StaffId INT PRIMARY KEY,
    StaffName VARCHAR(50),
    Salary INT
);

-- Insert Data
INSERT INTO Staff VALUES
(1,'Ram',30000),
(2,'Ravi',40000),
(3,'Sita',30000),
(4,'Rani',50000),
(5,'Kiran',40000);

-- Find Duplicate Salaries using Self Join
SELECT 
    s1.StaffId,
    s1.StaffName,
    s1.Salary
FROM Staff s1
JOIN Staff s2
ON s1.Salary = s2.Salary
AND s1.StaffId <> s2.StaffId
ORDER BY s1.Salary;
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