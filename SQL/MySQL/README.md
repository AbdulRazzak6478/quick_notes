Complete MySQL & SQL Guide - From Scratch to Advanced
A comprehensive guide covering all MySQL and SQL commands from beginner to advanced level with practical examples.

- Table of Contents
Getting Started
Database Operations
Table Operations
Data Types
CRUD Operations
Querying Data
Filtering and Sorting
Joins
Aggregate Functions
Grouping and Having
Subqueries
Constraints
Indexes
Views
Stored Procedures
Triggers
Transactions
User Management
Advanced Concepts
Getting Started
Installing MySQL
bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install mysql-server

# MacOS
brew install mysql

# Windows - Download from mysql.com
Connecting to MySQL
bash
# Connect to MySQL
mysql -u root -p

# Connect to specific database
mysql -u username -p database_name

# Connect to remote server
mysql -h hostname -u username -p
Basic MySQL Commands
sql
-- Show MySQL version
SELECT VERSION();

-- Show current user
SELECT USER();

-- Show current database
SELECT DATABASE();

-- Get help
HELP;

-- Exit MySQL
EXIT;
-- or
QUIT;
Database Operations
Create Database
sql
-- Create new database
CREATE DATABASE company;

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS company;

-- Create database with character set
CREATE DATABASE company 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;
Show Databases
sql
-- List all databases
SHOW DATABASES;

-- Show databases matching pattern
SHOW DATABASES LIKE 'comp%';
Use Database
sql
-- Switch to database
USE company;
Drop Database
sql
-- Delete database
DROP DATABASE company;

-- Delete if exists
DROP DATABASE IF EXISTS company;
Alter Database
sql
-- Change character set
ALTER DATABASE company 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;
Table Operations
Create Table
sql
-- Basic table creation
CREATE TABLE employees (
    id INT,
    name VARCHAR(100),
    email VARCHAR(100),
    salary DECIMAL(10, 2),
    hire_date DATE
);

-- Table with constraints
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    salary DECIMAL(10, 2) DEFAULT 50000,
    hire_date DATE NOT NULL,
    department_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create table from another table
CREATE TABLE employees_backup AS 
SELECT * FROM employees;

-- Create table like another table
CREATE TABLE employees_copy LIKE employees;
Show Tables
sql
-- List all tables
SHOW TABLES;

-- Show tables matching pattern
SHOW TABLES LIKE 'emp%';

-- Describe table structure
DESCRIBE employees;
-- or
DESC employees;

-- Show complete table structure
SHOW CREATE TABLE employees;

-- Show table columns
SHOW COLUMNS FROM employees;
Alter Table
sql
-- Add column
ALTER TABLE employees 
ADD COLUMN phone VARCHAR(20);

-- Add multiple columns
ALTER TABLE employees 
ADD COLUMN age INT,
ADD COLUMN address TEXT;

-- Modify column
ALTER TABLE employees 
MODIFY COLUMN name VARCHAR(150);

-- Change column name and type
ALTER TABLE employees 
CHANGE COLUMN name full_name VARCHAR(150);

-- Drop column
ALTER TABLE employees 
DROP COLUMN phone;

-- Rename table
ALTER TABLE employees 
RENAME TO staff;

-- or
RENAME TABLE staff TO employees;

-- Add primary key
ALTER TABLE employees 
ADD PRIMARY KEY (id);

-- Drop primary key
ALTER TABLE employees 
DROP PRIMARY KEY;

-- Add foreign key
ALTER TABLE employees 
ADD CONSTRAINT fk_department 
FOREIGN KEY (department_id) 
REFERENCES departments(id);

-- Drop foreign key
ALTER TABLE employees 
DROP FOREIGN KEY fk_department;
Drop Table
sql
-- Delete table
DROP TABLE employees;

-- Delete if exists
DROP TABLE IF EXISTS employees;

-- Delete multiple tables
DROP TABLE employees, departments, projects;
Truncate Table
sql
-- Remove all data (faster than DELETE)
TRUNCATE TABLE employees;
Data Types
Numeric Types
sql
-- Integer types
TINYINT      -- -128 to 127
SMALLINT     -- -32,768 to 32,767
MEDIUMINT    -- -8,388,608 to 8,388,607
INT          -- -2,147,483,648 to 2,147,483,647
BIGINT       -- Very large integers

-- Decimal types
DECIMAL(10,2)  -- Fixed-point (exact)
FLOAT          -- Floating-point (approximate)
DOUBLE         -- Double precision floating-point

-- Example
CREATE TABLE products (
    id INT,
    price DECIMAL(10, 2),
    weight FLOAT,
    quantity SMALLINT
);
String Types
sql
-- Character types
CHAR(50)        -- Fixed length
VARCHAR(255)    -- Variable length
TEXT            -- Up to 65,535 characters
MEDIUMTEXT      -- Up to 16,777,215 characters
LONGTEXT        -- Up to 4GB

-- Binary types
BINARY(50)
VARBINARY(255)
BLOB
MEDIUMBLOB
LONGBLOB

-- Example
CREATE TABLE articles (
    title VARCHAR(200),
    content TEXT,
    author CHAR(50)
);
Date and Time Types
sql
DATE            -- YYYY-MM-DD
TIME            -- HH:MM:SS
DATETIME        -- YYYY-MM-DD HH:MM:SS
TIMESTAMP       -- Unix timestamp
YEAR            -- YYYY

-- Example
CREATE TABLE events (
    event_date DATE,
    event_time TIME,
    created_at DATETIME,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
Other Types
sql
-- Enumeration
ENUM('small', 'medium', 'large')

-- Set
SET('red', 'green', 'blue')

-- JSON (MySQL 5.7+)
JSON

-- Boolean (stored as TINYINT)
BOOLEAN  -- or BOOL

-- Example
CREATE TABLE orders (
    size ENUM('small', 'medium', 'large'),
    colors SET('red', 'green', 'blue'),
    metadata JSON,
    is_active BOOLEAN
);
CRUD Operations
INSERT - Create Data
sql
-- Insert single row
INSERT INTO employees (name, email, salary, hire_date)
VALUES ('John Doe', 'john@example.com', 60000, '2024-01-15');

-- Insert multiple rows
INSERT INTO employees (name, email, salary, hire_date)
VALUES 
    ('Jane Smith', 'jane@example.com', 65000, '2024-02-01'),
    ('Bob Johnson', 'bob@example.com', 55000, '2024-02-15'),
    ('Alice Brown', 'alice@example.com', 70000, '2024-03-01');

-- Insert without specifying columns (must match all columns)
INSERT INTO employees 
VALUES (1, 'Mike Wilson', 'mike@example.com', 58000, '2024-03-15', 1, NOW());

-- Insert from SELECT
INSERT INTO employees_backup 
SELECT * FROM employees WHERE salary > 60000;

-- Insert ignore duplicates
INSERT IGNORE INTO employees (email, name) 
VALUES ('john@example.com', 'John Duplicate');

-- Insert with ON DUPLICATE KEY UPDATE
INSERT INTO employees (id, name, salary)
VALUES (1, 'John Doe', 65000)
ON DUPLICATE KEY UPDATE salary = 65000;
SELECT - Read Data
sql
-- Select all columns
SELECT * FROM employees;

-- Select specific columns
SELECT name, email, salary FROM employees;

-- Select with alias
SELECT name AS employee_name, salary AS monthly_salary 
FROM employees;

-- Select distinct values
SELECT DISTINCT department_id FROM employees;

-- Select with calculated fields
SELECT name, salary, salary * 12 AS annual_salary 
FROM employees;
UPDATE - Modify Data
sql
-- Update single column
UPDATE employees 
SET salary = 70000 
WHERE id = 1;

-- Update multiple columns
UPDATE employees 
SET salary = 75000, department_id = 2 
WHERE id = 1;

-- Update with calculation
UPDATE employees 
SET salary = salary * 1.10 
WHERE department_id = 1;

-- Update all rows (use with caution)
UPDATE employees 
SET updated_at = NOW();

-- Update with JOIN
UPDATE employees e
JOIN departments d ON e.department_id = d.id
SET e.salary = e.salary * 1.05
WHERE d.name = 'Sales';
DELETE - Remove Data
sql
-- Delete specific rows
DELETE FROM employees 
WHERE id = 1;

-- Delete with condition
DELETE FROM employees 
WHERE salary < 50000;

-- Delete all rows (use with caution)
DELETE FROM employees;

-- Delete with JOIN
DELETE e FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE d.name = 'Closed Department';

-- Delete with LIMIT
DELETE FROM employees 
ORDER BY hire_date 
LIMIT 5;
Querying Data
WHERE Clause
sql
-- Basic WHERE
SELECT * FROM employees 
WHERE salary > 60000;

-- Multiple conditions (AND)
SELECT * FROM employees 
WHERE salary > 60000 AND department_id = 1;

-- Multiple conditions (OR)
SELECT * FROM employees 
WHERE department_id = 1 OR department_id = 2;

-- NOT condition
SELECT * FROM employees 
WHERE NOT department_id = 1;

-- IN operator
SELECT * FROM employees 
WHERE department_id IN (1, 2, 3);

-- BETWEEN operator
SELECT * FROM employees 
WHERE salary BETWEEN 50000 AND 70000;

-- LIKE operator (pattern matching)
SELECT * FROM employees 
WHERE name LIKE 'John%';  -- Starts with John

SELECT * FROM employees 
WHERE name LIKE '%son';   -- Ends with son

SELECT * FROM employees 
WHERE name LIKE '%oh%';   -- Contains oh

SELECT * FROM employees 
WHERE email LIKE '_o%';   -- Second character is 'o'

-- IS NULL / IS NOT NULL
SELECT * FROM employees 
WHERE department_id IS NULL;

SELECT * FROM employees 
WHERE department_id IS NOT NULL;
ORDER BY
sql
-- Sort ascending (default)
SELECT * FROM employees 
ORDER BY salary;

-- Sort descending
SELECT * FROM employees 
ORDER BY salary DESC;

-- Multiple columns
SELECT * FROM employees 
ORDER BY department_id ASC, salary DESC;

-- Order by calculated field
SELECT name, salary * 12 AS annual_salary 
FROM employees 
ORDER BY annual_salary DESC;
LIMIT and OFFSET
sql
-- Limit results
SELECT * FROM employees 
LIMIT 10;

-- Limit with offset (skip first 10, get next 10)
SELECT * FROM employees 
LIMIT 10 OFFSET 10;

-- Shorthand (offset, limit)
SELECT * FROM employees 
LIMIT 10, 10;

-- Top paid employees
SELECT * FROM employees 
ORDER BY salary DESC 
LIMIT 5;
Filtering and Sorting
Advanced Filtering
sql
-- Combining conditions
SELECT * FROM employees 
WHERE (department_id = 1 OR department_id = 2) 
AND salary > 60000;

-- NOT IN
SELECT * FROM employees 
WHERE department_id NOT IN (1, 2, 3);

-- NOT BETWEEN
SELECT * FROM employees 
WHERE salary NOT BETWEEN 50000 AND 70000;

-- Multiple LIKE conditions
SELECT * FROM employees 
WHERE name LIKE 'J%' OR name LIKE 'A%';

-- REGEXP (Regular Expression)
SELECT * FROM employees 
WHERE name REGEXP '^[JA]';  -- Starts with J or A

SELECT * FROM employees 
WHERE email REGEXP '@gmail\\.com$';  -- Gmail addresses
CASE Statement
sql
-- Simple CASE
SELECT name, salary,
    CASE 
        WHEN salary < 50000 THEN 'Low'
        WHEN salary BETWEEN 50000 AND 70000 THEN 'Medium'
        WHEN salary > 70000 THEN 'High'
        ELSE 'Unknown'
    END AS salary_grade
FROM employees;

-- CASE in ORDER BY
SELECT * FROM employees
ORDER BY 
    CASE department_id
        WHEN 1 THEN 1
        WHEN 2 THEN 2
        ELSE 3
    END;
Joins
INNER JOIN
sql
-- Basic INNER JOIN
SELECT e.name, e.salary, d.name AS department
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;

-- Multiple INNER JOINs
SELECT e.name, d.name AS department, p.name AS project
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
INNER JOIN projects p ON e.project_id = p.id;

-- Join with WHERE
SELECT e.name, d.name AS department
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
WHERE e.salary > 60000;
LEFT JOIN (LEFT OUTER JOIN)
sql
-- Get all employees and their departments (including employees without departments)
SELECT e.name, d.name AS department
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;

-- Find employees without departments
SELECT e.name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id
WHERE d.id IS NULL;
RIGHT JOIN (RIGHT OUTER JOIN)
sql
-- Get all departments and their employees (including departments without employees)
SELECT e.name, d.name AS department
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;

-- Find departments without employees
SELECT d.name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id
WHERE e.id IS NULL;
FULL OUTER JOIN
sql
-- MySQL doesn't support FULL OUTER JOIN directly, use UNION
SELECT e.name, d.name AS department
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id
UNION
SELECT e.name, d.name AS department
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;
CROSS JOIN
sql
-- Cartesian product (every combination)
SELECT e.name, d.name
FROM employees e
CROSS JOIN departments d;
SELF JOIN
sql
-- Find employees and their managers
SELECT e.name AS employee, m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;
Aggregate Functions
Basic Aggregate Functions
sql
-- COUNT
SELECT COUNT(*) FROM employees;
SELECT COUNT(DISTINCT department_id) FROM employees;

-- SUM
SELECT SUM(salary) FROM employees;

-- AVG
SELECT AVG(salary) FROM employees;

-- MIN and MAX
SELECT MIN(salary), MAX(salary) FROM employees;

-- Multiple aggregates
SELECT 
    COUNT(*) AS total_employees,
    AVG(salary) AS average_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    SUM(salary) AS total_payroll
FROM employees;
String Functions
sql
-- CONCAT
SELECT CONCAT(first_name, ' ', last_name) AS full_name 
FROM employees;

-- UPPER and LOWER
SELECT UPPER(name), LOWER(email) FROM employees;

-- LENGTH
SELECT name, LENGTH(name) AS name_length FROM employees;

-- SUBSTRING
SELECT SUBSTRING(name, 1, 5) FROM employees;

-- TRIM, LTRIM, RTRIM
SELECT TRIM(name) FROM employees;

-- REPLACE
SELECT REPLACE(email, '@old.com', '@new.com') FROM employees;

-- LEFT and RIGHT
SELECT LEFT(name, 3), RIGHT(name, 3) FROM employees;
Numeric Functions
sql
-- ROUND
SELECT ROUND(salary, 2) FROM employees;

-- CEILING and FLOOR
SELECT CEILING(salary/1000), FLOOR(salary/1000) FROM employees;

-- ABS
SELECT ABS(-100);

-- MOD
SELECT MOD(salary, 1000) FROM employees;

-- POWER
SELECT POWER(2, 3);  -- 2^3 = 8

-- SQRT
SELECT SQRT(16);  -- 4
Date Functions
sql
-- NOW and CURDATE
SELECT NOW(), CURDATE(), CURTIME();

-- DATE_FORMAT
SELECT DATE_FORMAT(hire_date, '%Y-%m-%d') FROM employees;
SELECT DATE_FORMAT(NOW(), '%W, %M %d, %Y');

-- YEAR, MONTH, DAY
SELECT YEAR(hire_date), MONTH(hire_date), DAY(hire_date) 
FROM employees;

-- DATEDIFF
SELECT name, DATEDIFF(NOW(), hire_date) AS days_employed 
FROM employees;

-- DATE_ADD and DATE_SUB
SELECT DATE_ADD(NOW(), INTERVAL 30 DAY);
SELECT DATE_SUB(NOW(), INTERVAL 1 YEAR);

-- TIMESTAMPDIFF
SELECT name, TIMESTAMPDIFF(YEAR, hire_date, NOW()) AS years_employed 
FROM employees;
Grouping and Having
GROUP BY
sql
-- Group by single column
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;

-- Group by multiple columns
SELECT department_id, YEAR(hire_date), COUNT(*) AS count
FROM employees
GROUP BY department_id, YEAR(hire_date);

-- Group with aggregate functions
SELECT department_id, 
       AVG(salary) AS avg_salary,
       MIN(salary) AS min_salary,
       MAX(salary) AS max_salary
FROM employees
GROUP BY department_id;
HAVING Clause
sql
-- Filter groups (HAVING comes after GROUP BY)
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING avg_salary > 60000;

-- Multiple HAVING conditions
SELECT department_id, COUNT(*) AS emp_count
FROM employees
GROUP BY department_id
HAVING emp_count > 5 AND department_id IS NOT NULL;

-- HAVING with WHERE
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
WHERE hire_date > '2023-01-01'
GROUP BY department_id
HAVING avg_salary > 60000;
WITH ROLLUP
sql
-- Add summary row
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id WITH ROLLUP;
Subqueries
Subquery in WHERE
sql
-- Find employees earning more than average
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Find employees in specific departments
SELECT name
FROM employees
WHERE department_id IN (
    SELECT id FROM departments WHERE name IN ('Sales', 'Marketing')
);

-- Find employees earning more than anyone in department 1
SELECT name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary FROM employees WHERE department_id = 1
);

-- Find employees earning more than someone in department 1
SELECT name, salary
FROM employees
WHERE salary > ANY (
    SELECT salary FROM employees WHERE department_id = 1
);
Subquery in FROM
sql
-- Use subquery as temporary table
SELECT dept_salary.department_id, dept_salary.avg_salary
FROM (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_salary
WHERE dept_salary.avg_salary > 60000;
Subquery in SELECT
sql
-- Scalar subquery
SELECT name, salary,
    (SELECT AVG(salary) FROM employees) AS company_avg,
    salary - (SELECT AVG(salary) FROM employees) AS diff_from_avg
FROM employees;
Correlated Subquery
sql
-- Subquery references outer query
SELECT e1.name, e1.salary
FROM employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);
EXISTS
sql
-- Check if subquery returns rows
SELECT d.name
FROM departments d
WHERE EXISTS (
    SELECT 1 FROM employees e WHERE e.department_id = d.id
);

-- NOT EXISTS
SELECT d.name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e WHERE e.department_id = d.id
);
Constraints
Primary Key
sql
-- Add primary key during creation
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

-- Add primary key after creation
ALTER TABLE employees 
ADD PRIMARY KEY (id);

-- Composite primary key
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);
Foreign Key
sql
-- Add foreign key during creation
CREATE TABLE employees (
    id INT PRIMARY KEY,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Add foreign key with options
CREATE TABLE employees (
    id INT PRIMARY KEY,
    department_id INT,
    FOREIGN KEY (department_id) 
        REFERENCES departments(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ON DELETE options:
-- CASCADE: Delete child rows
-- SET NULL: Set foreign key to NULL
-- RESTRICT: Prevent deletion
-- NO ACTION: Same as RESTRICT

-- Add foreign key after creation
ALTER TABLE employees
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id) REFERENCES departments(id);
Unique Constraint
sql
-- Single column unique
CREATE TABLE employees (
    id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE
);

-- Multiple column unique
CREATE TABLE employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    UNIQUE (first_name, last_name)
);

-- Add unique after creation
ALTER TABLE employees 
ADD UNIQUE (email);
NOT NULL Constraint
sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Add NOT NULL after creation
ALTER TABLE employees 
MODIFY name VARCHAR(100) NOT NULL;
CHECK Constraint (MySQL 8.0.16+)
sql
-- Add check during creation
CREATE TABLE employees (
    id INT PRIMARY KEY,
    age INT CHECK (age >= 18),
    salary DECIMAL(10,2) CHECK (salary > 0)
);

-- Named check constraint
CREATE TABLE employees (
    id INT PRIMARY KEY,
    age INT,
    CONSTRAINT chk_age CHECK (age >= 18 AND age <= 65)
);

-- Add check after creation
ALTER TABLE employees 
ADD CONSTRAINT chk_salary CHECK (salary > 0);
DEFAULT Constraint
sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    salary DECIMAL(10,2) DEFAULT 50000
);

-- Add default after creation
ALTER TABLE employees 
ALTER COLUMN status SET DEFAULT 'active';
Indexes
Create Index
sql
-- Single column index
CREATE INDEX idx_name ON employees(name);

-- Multiple column index (composite)
CREATE INDEX idx_name_dept ON employees(name, department_id);

-- Unique index
CREATE UNIQUE INDEX idx_email ON employees(email);

-- Full-text index
CREATE FULLTEXT INDEX idx_description ON products(description);

-- Index with length limit
CREATE INDEX idx_name ON employees(name(10));
Show Indexes
sql
-- Show all indexes on table
SHOW INDEXES FROM employees;

-- or
SHOW KEYS FROM employees;
Drop Index
sql
-- Drop index
DROP INDEX idx_name ON employees;

-- or
ALTER TABLE employees DROP INDEX idx_name;
Using Indexes Efficiently
sql
-- Check query execution plan
EXPLAIN SELECT * FROM employees WHERE name = 'John';

-- Force index usage
SELECT * FROM employees 
FORCE INDEX (idx_name) 
WHERE name = 'John';

-- Ignore index
SELECT * FROM employees 
IGNORE INDEX (idx_name) 
WHERE name = 'John';
Views
Create View
sql
-- Simple view
CREATE VIEW employee_details AS
SELECT e.name, e.salary, d.name AS department
FROM employees e
JOIN departments d ON e.department_id = d.id;

-- View with WHERE clause
CREATE VIEW high_earners AS
SELECT name, salary, department_id
FROM employees
WHERE salary > 70000;

-- View with aggregation
CREATE VIEW department_stats AS
SELECT 
    d.name AS department,
    COUNT(e.id) AS employee_count,
    AVG(e.salary) AS avg_salary
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.id;
Use View
sql
-- Query view like a table
SELECT * FROM employee_details;

SELECT * FROM high_earners WHERE department_id = 1;
Modify View
sql
-- Replace view
CREATE OR REPLACE VIEW employee_details AS
SELECT e.name, e.salary, e.email, d.name AS department
FROM employees e
JOIN departments d ON e.department_id = d.id;

-- Alter view
ALTER VIEW employee_details AS
SELECT e.name, e.salary, d.name AS department
FROM employees e
JOIN departments d ON e.department_id = d.id;
Drop View
sql
DROP VIEW employee_details;

DROP VIEW IF EXISTS employee_details;
Show Views
sql
-- Show all views
SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW';

-- Show view definition
SHOW CREATE VIEW employee_details;
Stored Procedures
Create Procedure
sql
-- Simple procedure
DELIMITER //
CREATE PROCEDURE GetAllEmployees()
BEGIN
    SELECT * FROM employees;
END //
DELIMITER ;

-- Procedure with parameters
DELIMITER //
CREATE PROCEDURE GetEmployeeById(IN emp_id INT)
BEGIN
    SELECT * FROM employees WHERE id = emp_id;
END //
DELIMITER ;

-- Procedure with OUT parameter
DELIMITER //
CREATE PROCEDURE GetEmployeeCount(OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total FROM employees;
END //
DELIMITER ;

-- Procedure with INOUT parameter
DELIMITER //
CREATE PROCEDURE IncreaseSalary(INOUT salary DECIMAL(10,2), IN percentage INT)
BEGIN
    SET salary = salary + (salary * percentage / 100);
END //
DELIMITER ;

-- Complex procedure with logic
DELIMITER //
CREATE PROCEDURE UpdateSalaryByPerformance(
    IN emp_id INT,
    IN performance_rating INT
)
BEGIN
    DECLARE current_salary DECIMAL(10,2);
    DECLARE increase_percentage INT;
    
    SELECT salary INTO current_salary 
    FROM employees 
    WHERE id = emp_id;
    
    IF performance_rating >= 9 THEN
        SET increase_percentage = 20;
    ELSEIF performance_rating >= 7 THEN
        SET increase_percentage = 10;
    ELSEIF performance_rating >= 5 THEN
        SET increase_percentage = 5;
    ELSE
        SET increase_percentage = 0;
    END IF;
    
    UPDATE employees 
    SET salary = current_salary + (current_salary * increase_percentage / 100)
    WHERE id = emp_id;
    
    SELECT increase_percentage AS applied_increase;
END //
DELIMITER ;
Call Procedure
sql
-- Call simple procedure
CALL GetAllEmployees();

-- Call with IN parameter
CALL GetEmployeeById(1);

-- Call with OUT parameter
CALL GetEmployeeCount(@total);
SELECT @total;

-- Call with INOUT parameter
SET @salary = 50000;
CALL IncreaseSalary(@salary, 10);
SELECT @salary;
Show Procedures
sql
-- Show all procedures
SHOW PROCEDURE STATUS WHERE Db = 'company';

-- Show procedure definition
SHOW CREATE PROCEDURE GetAllEmployees;
Drop Procedure
sql
DROP PROCEDURE GetAllEmployees;

DROP PROCEDURE IF EXISTS GetAllEmployees;
Triggers
Create Trigger
sql
-- BEFORE INSERT trigger
DELIMITER //
CREATE TRIGGER before_employee_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    SET NEW.created_at = NOW();
    SET NEW.email = LOWER(NEW.email);
END //
DELIMITER ;

-- AFTER INSERT trigger
DELIMITER //
CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (employee_id, action, action_date)
    VALUES (NEW.id, 'INSERT', NOW());
END //
DELIMITER ;

-- BEFORE UPDATE trigger
DELIMITER //
CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
    
    IF NEW.salary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be negative';
    END IF;
END //
DELIMITER ;

-- AFTER UPDATE trigger
DELIMITER //
CREATE TRIGGER after_employee_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_history (employee_id, old_salary, new_salary, change_date)
        VALUES (NEW.id, OLD.salary, NEW.salary, NOW());
    END IF;
END //
DELIMITER ;

-- BEFORE DELETE trigger
DELIMITER //
CREATE TRIGGER before_employee_delete
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO deleted_employees 
    SELECT * FROM employees WHERE id = OLD.id;
END //
DELIMITER ;
Show Triggers
sql
-- Show all triggers
SHOW TRIGGERS;

-- Show triggers for specific table
SHOW TRIGGERS WHERE `Table` = 'employees';

-- Show trigger definition
SHOW CREATE TRIGGER before_employee_insert;
Drop Trigger
sql
DROP TRIGGER before_employee_insert;

DROP TRIGGER IF EXISTS before_employee_insert;
Transactions
Basic Transaction
sql
-- Start transaction
START TRANSACTION;
-- or
BEGIN;

-- Execute queries
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;

-- Commit (save changes)
COMMIT;

-- Or rollback (undo changes)
ROLLBACK;
Transaction with Savepoint
sql
START TRANSACTION;

UPDATE accounts SET balance = balance - 100 WHERE id = 1;

SAVEPOINT sp1;

UPDATE accounts SET balance = balance + 100 WHERE id = 2;

SAVEPOINT sp2;

UPDATE accounts SET balance = balance - 50 WHERE id = 3;

-- Rollback to savepoint
ROLLBACK TO sp2;

COMMIT;
Transaction Isolation Levels
sql
-- Show current isolation level
SELECT @@transaction_ISOLATION;

-- Set isolation level
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Example with specific isolation level
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
SELECT * FROM accounts WHERE id = 1;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
COMMIT;
Auto-commit
sql
-- Check auto-commit status
SELECT @@autocommit;

-- Disable auto-commit
SET autocommit = 0;

-- Enable auto-commit
SET autocommit = 1;
Transaction Best Practices
sql
-- Complete transaction example
START TRANSACTION;

-- Check if sufficient balance
SELECT balance INTO @current_balance 
FROM accounts 
WHERE id = 1 
FOR UPDATE;  -- Lock the row

IF @current_balance >= 100 THEN
    UPDATE accounts SET balance = balance - 100 WHERE id = 1;
    UPDATE accounts SET balance = balance + 100 WHERE id = 2;
    COMMIT;
ELSE
    ROLLBACK;
    SELECT 'Insufficient balance' AS error;
END IF;
User Management
Create User
sql
-- Create user
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';

-- Create user for any host
CREATE USER 'username'@'%' IDENTIFIED BY 'password';

-- Create user with specific host
CREATE USER 'username'@'192.168.1.100' IDENTIFIED BY 'password';

-- Create user if not exists
CREATE USER IF NOT EXISTS 'username'@'localhost' IDENTIFIED BY 'password';
Grant Privileges
sql
-- Grant all privileges on all databases
GRANT ALL PRIVILEGES ON *.* TO 'username'@'localhost';

-- Grant all privileges on specific database
GRANT ALL PRIVILEGES ON company.* TO 'username'@'localhost';

-- Grant specific privileges
GRANT SELECT, INSERT, UPDATE ON company.* TO 'username'@'localhost';

-- Grant privileges on specific table
GRANT SELECT, INSERT ON company.employees TO 'username'@'localhost';

-- Grant with grant option (user can grant to others)
GRANT SELECT ON company.* TO 'username'@'localhost' WITH GRANT OPTION;

-- Common privileges:
-- SELECT, INSERT, UPDATE, DELETE
-- CREATE, DROP, ALTER, INDEX
-- CREATE VIEW, SHOW VIEW
-- CREATE ROUTINE, ALTER ROUTINE, EXECUTE
-- ALL PRIVILEGES

-- Apply changes
FLUSH PRIVILEGES;
Show Privileges
sql
-- Show current user's privileges
SHOW GRANTS;

-- Show specific user's privileges
SHOW GRANTS FOR 'username'@'localhost';
Revoke Privileges
sql
-- Revoke specific privileges
REVOKE INSERT, UPDATE ON company.* FROM 'username'@'localhost';

-- Revoke all privileges
REVOKE ALL PRIVILEGES ON company.* FROM 'username'@'localhost';
Modify User
sql
-- Change password
ALTER USER 'username'@'localhost' IDENTIFIED BY 'new_password';

-- Change authentication plugin
ALTER USER 'username'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';

-- Rename user
RENAME USER 'old_username'@'localhost' TO 'new_username'@'localhost';
Delete User
sql
-- Drop user
DROP USER 'username'@'localhost';

-- Drop if exists
DROP USER IF EXISTS 'username'@'localhost';
Show Users
sql
-- List all users
SELECT user, host FROM mysql.user;
Advanced Concepts
Window Functions (MySQL 8.0+)
sql
-- ROW_NUMBER
SELECT 
    name, 
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;

-- RANK (with gaps for ties)
SELECT 
    name, 
    salary,
    RANK() OVER (ORDER BY salary DESC) AS rank
FROM employees;

-- DENSE_RANK (no gaps for ties)
SELECT 
    name, 
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM employees;

-- PARTITION BY
SELECT 
    name,
    department_id,
    salary,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
FROM employees;

-- LAG (previous row)
SELECT 
    name,
    salary,
    LAG(salary) OVER (ORDER BY hire_date) AS previous_salary
FROM employees;

-- LEAD (next row)
SELECT 
    name,
    salary,
    LEAD(salary) OVER (ORDER BY hire_date) AS next_salary
FROM employees;

-- FIRST_VALUE and LAST_VALUE
SELECT 
    name,
    salary,
    FIRST_VALUE(salary) OVER (ORDER BY salary DESC) AS highest_salary,
    LAST_VALUE(salary) OVER (ORDER BY salary DESC 
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS lowest_salary
FROM employees;

-- NTILE (divide into N groups)
SELECT 
    name,
    salary,
    NTILE(4) OVER (ORDER BY salary) AS quartile
FROM employees;

-- Running total
SELECT 
    name,
    salary,
    SUM(salary) OVER (ORDER BY hire_date) AS running_total
FROM employees;

-- Moving average
SELECT 
    name,
    salary,
    AVG(salary) OVER (ORDER BY hire_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
FROM employees;
Common Table Expressions (CTE)
sql
-- Simple CTE
WITH high_earners AS (
    SELECT * FROM employees WHERE salary > 70000
)
SELECT * FROM high_earners WHERE department_id = 1;

-- Multiple CTEs
WITH 
high_earners AS (
    SELECT * FROM employees WHERE salary > 70000
),
dept_summary AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT h.name, h.salary, d.avg_salary
FROM high_earners h
JOIN dept_summary d ON h.department_id = d.department_id;

-- Recursive CTE (organizational hierarchy)
WITH RECURSIVE employee_hierarchy AS (
    -- Base case: top-level employees
    SELECT id, name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case: employees with managers
    SELECT e.id, e.name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.id
)
SELECT * FROM employee_hierarchy ORDER BY level, name;

-- Recursive CTE (number series)
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 10
)
SELECT * FROM numbers;
JSON Functions (MySQL 5.7+)
sql
-- Create table with JSON
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    attributes JSON
);

-- Insert JSON data
INSERT INTO products (id, name, attributes) VALUES
(1, 'Laptop', '{"brand": "Dell", "ram": 16, "storage": 512}'),
(2, 'Phone', '{"brand": "Apple", "model": "iPhone 14", "color": "black"}');

-- Extract JSON values
SELECT 
    name,
    JSON_EXTRACT(attributes, '$.brand') AS brand,
    attributes->'$.ram' AS ram,  -- Shorthand
    attributes->>'$.brand' AS brand_unquoted  -- Unquoted
FROM products;

-- Query JSON array
INSERT INTO products VALUES
(3, 'Camera', '{"brand": "Canon", "lenses": ["50mm", "85mm", "24-70mm"]}');

SELECT 
    name,
    JSON_LENGTH(attributes->'$.lenses') AS lens_count,
    JSON_EXTRACT(attributes, '$.lenses[0]') AS first_lens
FROM products
WHERE JSON_CONTAINS(attributes->'$.lenses', '"50mm"');

-- Modify JSON
UPDATE products
SET attributes = JSON_SET(attributes, '$.ram', 32)
WHERE id = 1;

UPDATE products
SET attributes = JSON_INSERT(attributes, '$.warranty', '2 years')
WHERE id = 1;

UPDATE products
SET attributes = JSON_REMOVE(attributes, '$.color')
WHERE id = 2;

-- JSON aggregate functions
SELECT JSON_ARRAYAGG(name) AS all_products FROM products;

SELECT JSON_OBJECTAGG(id, name) AS product_map FROM products;
Full-Text Search
sql
-- Create table with FULLTEXT index
CREATE TABLE articles (
    id INT PRIMARY KEY,
    title VARCHAR(200),
    content TEXT,
    FULLTEXT (title, content)
);

-- Add FULLTEXT index to existing table
ALTER TABLE articles ADD FULLTEXT(title, content);

-- Natural language search
SELECT * FROM articles
WHERE MATCH(title, content) AGAINST('database optimization');

-- Boolean search
SELECT * FROM articles
WHERE MATCH(title, content) 
AGAINST('+mysql -oracle' IN BOOLEAN MODE);

-- Boolean operators:
-- + : must include
-- - : must not include
-- > : increase relevance
-- < : decrease relevance
-- * : wildcard
-- "" : exact phrase

-- Query expansion
SELECT * FROM articles
WHERE MATCH(title, content) 
AGAINST('database' WITH QUERY EXPANSION);

-- Get relevance score
SELECT 
    title,
    MATCH(title, content) AGAINST('mysql optimization') AS relevance
FROM articles
WHERE MATCH(title, content) AGAINST('mysql optimization')
ORDER BY relevance DESC;
Partitioning
sql
-- Range partitioning
CREATE TABLE sales (
    id INT,
    sale_date DATE,
    amount DECIMAL(10,2)
)
PARTITION BY RANGE (YEAR(sale_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- List partitioning
CREATE TABLE employees (
    id INT,
    name VARCHAR(100),
    department VARCHAR(50)
)
PARTITION BY LIST COLUMNS(department) (
    PARTITION p_sales VALUES IN ('Sales', 'Marketing'),
    PARTITION p_tech VALUES IN ('IT', 'Development'),
    PARTITION p_other VALUES IN ('HR', 'Finance')
);

-- Hash partitioning
CREATE TABLE logs (
    id INT,
    message TEXT,
    created_at TIMESTAMP
)
PARTITION BY HASH(id)
PARTITIONS 4;

-- Key partitioning
CREATE TABLE users (
    id INT PRIMARY KEY,
    username VARCHAR(50)
)
PARTITION BY KEY()
PARTITIONS 4;

-- Show partitions
SELECT * FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'sales';

-- Add partition
ALTER TABLE sales 
ADD PARTITION (PARTITION p2025 VALUES LESS THAN (2026));

-- Drop partition
ALTER TABLE sales DROP PARTITION p2022;
Performance Optimization
sql
-- EXPLAIN - Analyze query execution
EXPLAIN SELECT * FROM employees WHERE salary > 60000;

EXPLAIN FORMAT=JSON SELECT * FROM employees WHERE salary > 60000;

-- ANALYZE TABLE - Update table statistics
ANALYZE TABLE employees;

-- OPTIMIZE TABLE - Defragment table
OPTIMIZE TABLE employees;

-- SHOW PROFILE - Detailed query profiling
SET profiling = 1;
SELECT * FROM employees WHERE salary > 60000;
SHOW PROFILES;
SHOW PROFILE FOR QUERY 1;

-- Query Cache (deprecated in MySQL 8.0)
-- Use result cache or application-level caching instead

-- Index hints
SELECT * FROM employees USE INDEX (idx_salary) WHERE salary > 60000;
SELECT * FROM employees FORCE INDEX (idx_salary) WHERE salary > 60000;
SELECT * FROM employees IGNORE INDEX (idx_salary) WHERE salary > 60000;
Import and Export
sql
-- Export to CSV
SELECT * FROM employees
INTO OUTFILE '/tmp/employees.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Import from CSV
LOAD DATA INFILE '/tmp/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;  -- Skip header row

-- mysqldump (command line)
-- Export database
-- mysqldump -u root -p company > company_backup.sql

-- Export specific tables
-- mysqldump -u root -p company employees departments > backup.sql

-- Export only structure
-- mysqldump -u root -p --no-data company > structure.sql

-- Export only data
-- mysqldump -u root -p --no-create-info company > data.sql

-- Import dump
-- mysql -u root -p company < company_backup.sql
Backup and Restore
bash
# Full database backup
mysqldump -u root -p --all-databases > all_databases.sql

# Single database backup
mysqldump -u root -p company > company.sql

# Backup with compression
mysqldump -u root -p company | gzip > company.sql.gz

# Restore from backup
mysql -u root -p company < company.sql

# Restore compressed backup
gunzip < company.sql.gz | mysql -u root -p company

# Backup specific tables
mysqldump -u root -p company employees departments > tables.sql
System Information
sql
-- Show server status
SHOW STATUS;

-- Show specific status
SHOW STATUS LIKE 'Threads_connected';

-- Show variables
SHOW VARIABLES;

-- Show specific variable
SHOW VARIABLES LIKE 'max_connections';

-- Show processlist (active queries)
SHOW PROCESSLIST;

-- Show full processlist
SHOW FULL PROCESSLIST;

-- Kill process
KILL PROCESS_ID;

-- Database size
SELECT 
    table_schema AS 'Database',
    ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS 'Size (MB)'
FROM information_schema.tables
GROUP BY table_schema;

-- Table size
SELECT 
    table_name AS 'Table',
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.tables
WHERE table_schema = 'company'
ORDER BY (data_length + index_length) DESC;

-- Show table engine
SELECT 
    table_name,
    engine
FROM information_schema.tables
WHERE table_schema = 'company';
Regular Expression Functions
sql
-- REGEXP / RLIKE
SELECT * FROM employees WHERE name REGEXP '^J';  -- Starts with J
SELECT * FROM employees WHERE name REGEXP 'son;  -- Ends with son
SELECT * FROM employees WHERE email REGEXP '@gmail\\.com;

-- REGEXP_LIKE (MySQL 8.0+)
SELECT * FROM employees WHERE REGEXP_LIKE(name, '^[AJ]');

-- REGEXP_REPLACE (MySQL 8.0+)
SELECT REGEXP_REPLACE(phone, '[^0-9]', '') AS clean_phone FROM employees;

-- REGEXP_SUBSTR (MySQL 8.0+)
SELECT REGEXP_SUBSTR(email, '[^@]+') AS username FROM employees;

-- REGEXP_INSTR (MySQL 8.0+)
SELECT REGEXP_INSTR(email, '@') AS at_position FROM employees;
Best Practices Checklist
sql
-- ✓ Always use prepared statements to prevent SQL injection
PREPARE stmt FROM 'SELECT * FROM employees WHERE id = ?';
SET @id = 1;
EXECUTE stmt USING @id;
DEALLOCATE PREPARE stmt;

-- ✓ Use transactions for related operations
START TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;

-- ✓ Index frequently queried columns
CREATE INDEX idx_email ON employees(email);

-- ✓ Use LIMIT for large result sets
SELECT * FROM employees ORDER BY id LIMIT 100;

-- ✓ Avoid SELECT * in production
SELECT id, name, email FROM employees;  -- Better

-- ✓ Use JOIN instead of subqueries when possible
-- Good
SELECT e.name, d.name 
FROM employees e 
JOIN departments d ON e.department_id = d.id;

-- ✓ Use EXPLAIN to optimize queries
EXPLAIN SELECT * FROM employees WHERE salary > 60000;

-- ✓ Regular maintenance
ANALYZE TABLE employees;
OPTIMIZE TABLE employees;

-- ✓ Use appropriate data types
-- Use INT instead of VARCHAR for IDs
-- Use DECIMAL for currency
-- Use appropriate VARCHAR length

-- ✓ Normalize database design
-- Follow 1NF, 2NF, 3NF rules
-- Avoid data redundancy

-- ✓ Use foreign keys for referential integrity
ALTER TABLE employees
ADD FOREIGN KEY (department_id) REFERENCES departments(id);

-- ✓ Regular backups
-- Schedule daily/weekly backups
-- Test restore procedures

-- ✓ Monitor slow queries
-- Enable slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 2;
Quick Reference Cheat Sheet
Most Common Commands
sql
-- Database
SHOW DATABASES;
CREATE DATABASE db_name;
USE db_name;
DROP DATABASE db_name;

-- Tables
SHOW TABLES;
DESCRIBE table_name;
CREATE TABLE table_name (...);
DROP TABLE table_name;

-- CRUD
INSERT INTO table_name VALUES (...);
SELECT * FROM table_name;
UPDATE table_name SET column = value WHERE condition;
DELETE FROM table_name WHERE condition;

-- Filtering
WHERE column = value
WHERE column IN (value1, value2)
WHERE column BETWEEN value1 AND value2
WHERE column LIKE 'pattern%'
WHERE column IS NULL

-- Sorting
ORDER BY column ASC|DESC

-- Limiting
LIMIT 10
LIMIT 10 OFFSET 20

-- Aggregates
COUNT(*), SUM(column), AVG(column), MIN(column), MAX(column)

-- Grouping
GROUP BY column
HAVING condition

-- Joins
INNER JOIN table ON condition
LEFT JOIN table ON condition
RIGHT JOIN table ON condition
Additional Resources
Official MySQL Documentation: https://dev.mysql.com/doc/
MySQL Tutorial: https://www.mysqltutorial.org/
Practice: https://sqlzoo.net/
SQL Style Guide: https://www.sqlstyle.guide/
Happy Learning! 🚀

Remember: The best way to learn SQL is by practicing. Create databases, write queries, and experiment with different commands. Start with simple queries and gradually move to complex ones.

