# 🗄️ Complete MySQL & SQL Guide
### From Scratch to Advanced - A Beginner-Friendly Reference

[![MySQL](https://img.shields.io/badge/MySQL-8.0+-blue.svg)](https://www.mysql.com/)
[![SQL](https://img.shields.io/badge/SQL-Learning-green.svg)](https://www.mysql.com/)
[![License](https://img.shields.io/badge/License-Educational-yellow.svg)](https://opensource.org/licenses/MIT)

> 📚 A comprehensive guide covering all MySQL and SQL commands with practical examples, perfect for beginners and professionals alike.

---

## 📋 Table of Contents

- [🚀 Getting Started](#-getting-started)
- [💾 Database Operations](#-database-operations)
- [📊 Table Operations](#-table-operations)
- [🔤 Data Types](#-data-types)
- [✏️ CRUD Operations](#️-crud-operations)
- [🔍 Querying Data](#-querying-data)
- [🎯 Filtering and Sorting](#-filtering-and-sorting)
- [🔗 Joins](#-joins)
- [📈 Aggregate Functions](#-aggregate-functions)
- [📦 Grouping and Having](#-grouping-and-having)
- [🎭 Subqueries](#-subqueries)
- [🔒 Constraints](#-constraints)
- [⚡ Indexes](#-indexes)
- [👁️ Views](#️-views)
- [⚙️ Stored Procedures](#️-stored-procedures)
- [🎬 Triggers](#-triggers)
- [💰 Transactions](#-transactions)
- [👥 User Management](#-user-management)
- [🚀 Advanced Concepts](#-advanced-concepts)
- [📌 Quick Reference](#-quick-reference)
- [🎓 Learning Resources](#-learning-resources)

---

## 🚀 Getting Started

### 📥 Installing MySQL

Choose your operating system:

**Ubuntu/Debian** 🐧
```bash
sudo apt-get update
sudo apt-get install mysql-server
```

**MacOS** 🍎
```bash
brew install mysql
```

**Windows** 🪟
- Download from [mysql.com](https://www.mysql.com/)

---

### 🔌 Connecting to MySQL

**Basic Connection**
```bash
# Connect to MySQL
mysql -u root -p

# Connect to specific database
mysql -u username -p database_name

# Connect to remote server
mysql -h hostname -u username -p
```

---

### 🛠️ Basic MySQL Commands

```sql
-- 🔍 Show MySQL version
SELECT VERSION();

-- 👤 Show current user
SELECT USER();

-- 📂 Show current database
SELECT DATABASE();

-- ❓ Get help
HELP;

-- 🚪 Exit MySQL
EXIT;
-- or
QUIT;
```

---

## 💾 Database Operations

### ➕ Create Database

```sql
-- Create new database
CREATE DATABASE company;

-- Create database if not exists (prevents errors)
CREATE DATABASE IF NOT EXISTS company;

-- Create database with specific character set
CREATE DATABASE company 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;
```

**💡 Example Output:**
```
Query OK, 1 row affected (0.01 sec)
```

---

### 👀 Show Databases

```sql
-- List all databases
SHOW DATABASES;

-- Show databases matching pattern
SHOW DATABASES LIKE 'comp%';
```

**📝 Example Output:**
```
+--------------------+
| Database           |
+--------------------+
| company            |
| information_schema |
| mysql              |
+--------------------+
```

---

### 🎯 Use Database

```sql
-- Switch to database
USE company;
```

**✅ Success Message:**
```
Database changed
```

---

### ❌ Drop Database

```sql
-- Delete database (⚠️ Use with caution!)
DROP DATABASE company;

-- Delete if exists (safer option)
DROP DATABASE IF EXISTS company;
```

---

### 🔧 Alter Database

```sql
-- Change character set
ALTER DATABASE company 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;
```

---

## 📊 Table Operations

### ➕ Create Table

**Basic Table Creation**
```sql
CREATE TABLE employees (
    id INT,
    name VARCHAR(100),
    email VARCHAR(100),
    salary DECIMAL(10, 2),
    hire_date DATE
);
```

**Table with Constraints** ⭐ (Recommended)
```sql
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    salary DECIMAL(10, 2) DEFAULT 50000,
    hire_date DATE NOT NULL,
    department_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**Create from Another Table**
```sql
-- Copy structure and data
CREATE TABLE employees_backup AS 
SELECT * FROM employees;

-- Copy structure only
CREATE TABLE employees_copy LIKE employees;
```

---

### 👀 Show Tables

```sql
-- List all tables
SHOW TABLES;

-- Show tables matching pattern
SHOW TABLES LIKE 'emp%';

-- Describe table structure
DESCRIBE employees;
-- or
DESC employees;
```

**📝 Example Output:**
```
+---------------+--------------+------+-----+---------+----------------+
| Field         | Type         | Null | Key | Default | Extra          |
+---------------+--------------+------+-----+---------+----------------+
| id            | int          | NO   | PRI | NULL    | auto_increment |
| name          | varchar(100) | NO   |     | NULL    |                |
| email         | varchar(100) | YES  | UNI | NULL    |                |
+---------------+--------------+------+-----+---------+----------------+
```

---

### 🔧 Alter Table
```
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
```

---

### ❌ Drop Table

```sql
-- Delete table (⚠️ Permanent!)
DROP TABLE employees;

-- Delete if exists
DROP TABLE IF EXISTS employees;

-- Delete multiple tables
DROP TABLE employees, departments, projects;
```

---

### 🧹 Truncate Table

```sql
-- Remove all data (faster than DELETE)
TRUNCATE TABLE employees;
```

> **💡 Tip:** `TRUNCATE` is faster than `DELETE` as it doesn't log individual row deletions.

---

## 🔤 Data Types

### 🔢 Numeric Types

| Type | Range | Use Case |
|------|-------|----------|
| `TINYINT` | -128 to 127 | Small numbers (age, status) |
| `SMALLINT` | -32,768 to 32,767 | Medium numbers |
| `INT` | -2 billion to 2 billion | Primary keys, quantities |
| `BIGINT` | Very large numbers | Large IDs, statistics |
| `DECIMAL(10,2)` | Exact decimal | Money, prices |
| `FLOAT` | Approximate decimal | Scientific calculations |

**📝 Example:**
```sql
CREATE TABLE products (
    id INT PRIMARY KEY,
    price DECIMAL(10, 2),    -- 💰 For money
    weight FLOAT,             -- ⚖️ For measurements
    quantity SMALLINT         -- 📦 For counts
);
```

---

### 🔤 String Types

| Type | Max Length | Use Case |
|------|------------|----------|
| `CHAR(50)` | Fixed 50 | Fixed-length codes |
| `VARCHAR(255)` | Variable up to 255 | Names, emails |
| `TEXT` | 65,535 chars | Articles, descriptions |
| `MEDIUMTEXT` | 16 MB | Long content |
| `LONGTEXT` | 4 GB | Very long content |

**📝 Example:**
```sql
CREATE TABLE articles (
    title VARCHAR(200),      -- 📰 Short text
    content TEXT,            -- 📄 Long text
    author CHAR(50)          -- 👤 Fixed length
);
```

---

### 📅 Date and Time Types

| Type | Format | Example |
|------|--------|---------|
| `DATE` | YYYY-MM-DD | 2024-01-15 |
| `TIME` | HH:MM:SS | 14:30:00 |
| `DATETIME` | YYYY-MM-DD HH:MM:SS | 2024-01-15 14:30:00 |
| `TIMESTAMP` | Auto-updating | Current timestamp |
| `YEAR` | YYYY | 2024 |

**📝 Example:**
```sql
CREATE TABLE events (
    event_date DATE,
    event_time TIME,
    created_at DATETIME,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
               ON UPDATE CURRENT_TIMESTAMP
);
```

---

### 🎨 Other Types

**Enumeration**
```sql
size ENUM('small', 'medium', 'large')
```

**Set**
```sql
colors SET('red', 'green', 'blue')
```

**JSON** (MySQL 5.7+)
```sql
metadata JSON
```

**Boolean**
```sql
is_active BOOLEAN  -- Stored as TINYINT(1)
```

---

## ✏️ CRUD Operations

> **CRUD** = **C**reate, **R**ead, **U**pdate, **D**elete

### ➕ INSERT - Create Data
```
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
```

---

### 🔍 SELECT - Read Data

**Select All Columns**
```sql
SELECT * FROM employees;
```

**Select Specific Columns** ⭐ (Best Practice)
```sql
SELECT name, email, salary FROM employees;
```

**With Alias**
```sql
SELECT 
    name AS employee_name, 
    salary AS monthly_salary 
FROM employees;
```

**Distinct Values**
```sql
SELECT DISTINCT department_id FROM employees;
```

**Calculated Fields**
```sql
SELECT 
    name, 
    salary, 
    salary * 12 AS annual_salary 
FROM employees;
```

**📝 Example Output:**
```
+------------+--------+---------------+
| name       | salary | annual_salary |
+------------+--------+---------------+
| John Doe   | 60000  | 720000        |
| Jane Smith | 65000  | 780000        |
+------------+--------+---------------+
```

---

### 🔄 UPDATE - Modify Data

**Single Column**
```sql
UPDATE employees 
SET salary = 70000 
WHERE id = 1;
```

**Multiple Columns**
```sql
UPDATE employees 
SET salary = 75000, department_id = 2 
WHERE id = 1;
```

**With Calculation**
```sql
-- Give 10% raise to department 1
UPDATE employees 
SET salary = salary * 1.10 
WHERE department_id = 1;
```

> **⚠️ Warning:** Always use `WHERE` clause to avoid updating all rows!

---

### ❌ DELETE - Remove Data

**Delete Specific Rows**
```sql
DELETE FROM employees 
WHERE id = 1;
```

**Delete with Condition**
```sql
DELETE FROM employees 
WHERE salary < 50000;
```

**Delete with LIMIT** (Safe Practice)
```sql
DELETE FROM employees 
ORDER BY hire_date 
LIMIT 5;
```

> **⚠️ Danger:** `DELETE FROM employees;` will delete ALL rows!

---

## 🔍 Querying Data

### 🎯 WHERE Clause

**Basic Conditions**
```sql
-- Equal to
SELECT * FROM employees WHERE salary > 60000;

-- Multiple conditions (AND)
SELECT * FROM employees 
WHERE salary > 60000 AND department_id = 1;

-- Multiple conditions (OR)
SELECT * FROM employees 
WHERE department_id = 1 OR department_id = 2;
```

---

**IN Operator**
```sql
SELECT * FROM employees 
WHERE department_id IN (1, 2, 3);
```

---

**BETWEEN Operator**
```sql
SELECT * FROM employees 
WHERE salary BETWEEN 50000 AND 70000;
```

---

**LIKE Operator** (Pattern Matching)

| Pattern | Description | Example |
|---------|-------------|---------|
| `'John%'` | Starts with John | John Doe, Johnny |
| `'%son'` | Ends with son | Johnson, Wilson |
| `'%oh%'` | Contains oh | John, Ohio |
| `'_o%'` | 2nd char is 'o' | Joe, Bob |

```sql
-- Starts with John
SELECT * FROM employees WHERE name LIKE 'John%';

-- Ends with son
SELECT * FROM employees WHERE name LIKE '%son';

-- Contains 'oh'
SELECT * FROM employees WHERE name LIKE '%oh%';
```

---

**NULL Handling**
```sql
-- Find employees without department
SELECT * FROM employees WHERE department_id IS NULL;

-- Find employees with department
SELECT * FROM employees WHERE department_id IS NOT NULL;
```

---

### 📊 ORDER BY

**Ascending (Default)**
```sql
SELECT * FROM employees ORDER BY salary;
```

**Descending**
```sql
SELECT * FROM employees ORDER BY salary DESC;
```

**Multiple Columns**
```sql
SELECT * FROM employees 
ORDER BY department_id ASC, salary DESC;
```

---

### 📄 LIMIT and OFFSET

**Limit Results**
```sql
-- Get first 10 employees
SELECT * FROM employees LIMIT 10;
```

**Pagination**
```sql
-- Skip first 10, get next 10 (page 2)
SELECT * FROM employees LIMIT 10 OFFSET 10;

-- Shorthand: (offset, limit)
SELECT * FROM employees LIMIT 10, 10;
```

**Top N Results**
```sql
-- Top 5 highest paid employees
SELECT * FROM employees 
ORDER BY salary DESC 
LIMIT 5;
```

---

## 🎯 Filtering and Sorting

### 🔍 Advanced Filtering

**Combining Conditions**
```sql
SELECT * FROM employees 
WHERE (department_id = 1 OR department_id = 2) 
AND salary > 60000;
```

**NOT Operators**
```sql
-- NOT IN
SELECT * FROM employees 
WHERE department_id NOT IN (1, 2, 3);

-- NOT BETWEEN
SELECT * FROM employees 
WHERE salary NOT BETWEEN 50000 AND 70000;
```

**Regular Expressions**
```sql
-- Starts with J or A
SELECT * FROM employees 
WHERE name REGEXP '^[JA]';

-- Gmail addresses
SELECT * FROM employees 
WHERE email REGEXP '@gmail\\.com$';
```

---

### 🔀 CASE Statement

**Simple CASE**
```sql
SELECT 
    name, 
    salary,
    CASE 
        WHEN salary < 50000 THEN '💰 Low'
        WHEN salary BETWEEN 50000 AND 70000 THEN '💵 Medium'
        WHEN salary > 70000 THEN '💎 High'
        ELSE '❓ Unknown'
    END AS salary_grade
FROM employees;
```

**📝 Example Output:**
```
+------------+--------+--------------+
| name       | salary | salary_grade |
+------------+--------+--------------+
| John Doe   | 60000  | 💵 Medium    |
| Jane Smith | 75000  | 💎 High      |
+------------+--------+--------------+
```

---

## 🔗 Joins

> **Joins** combine rows from multiple tables based on related columns.

### 🎯 INNER JOIN

**Returns only matching rows from both tables**

```sql
SELECT e.name, e.salary, d.name AS department
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;
```

**Visual Representation:**
```
Employees    Departments
   ↓              ↓
[Match] ← INNER JOIN → [Match]
```

---

### ⬅️ LEFT JOIN

**Returns all rows from left table + matching rows from right table**

```sql
SELECT e.name, d.name AS department
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;
```

**Find Employees Without Departments:**
```sql
SELECT e.name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id
WHERE d.id IS NULL;
```

---

### ➡️ RIGHT JOIN

**Returns all rows from right table + matching rows from left table**

```sql
SELECT e.name, d.name AS department
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;
```

---

### 🔄 SELF JOIN

**Join table to itself**

```sql
-- Find employees and their managers
SELECT 
    e.name AS employee, 
    m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;
```

---

### ✖️ CROSS JOIN

**Cartesian product (every combination)**

```sql
SELECT e.name, d.name
FROM employees e
CROSS JOIN departments d;
```

---

## 📈 Aggregate Functions

### 🧮 Basic Aggregates

**COUNT**
```sql
-- Count all employees
SELECT COUNT(*) FROM employees;

-- Count distinct departments
SELECT COUNT(DISTINCT department_id) FROM employees;
```

**SUM**
```sql
-- Total salary expense
SELECT SUM(salary) AS total_payroll FROM employees;
```

**AVG (Average)**
```sql
-- Average salary
SELECT AVG(salary) AS average_salary FROM employees;
```

**MIN and MAX**
```sql
SELECT 
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary
FROM employees;
```

**Combined Example** ⭐
```sql
SELECT 
    COUNT(*) AS total_employees,
    AVG(salary) AS average_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    SUM(salary) AS total_payroll
FROM employees;
```

**📝 Example Output:**
```
+-----------------+-----------------+------------+------------+--------------+
| total_employees | average_salary  | min_salary | max_salary | total_payroll|
+-----------------+-----------------+------------+------------+--------------+
| 50              | 62500.00        | 45000      | 95000      | 3125000      |
+-----------------+-----------------+------------+------------+--------------+
```

---

### 🔤 String Functions

| Function | Description | Example |
|----------|-------------|---------|
| `CONCAT()` | Combine strings | `CONCAT('Hello', ' ', 'World')` |
| `UPPER()` | Convert to uppercase | `UPPER('hello')` → 'HELLO' |
| `LOWER()` | Convert to lowercase | `LOWER('HELLO')` → 'hello' |
| `LENGTH()` | String length | `LENGTH('Hello')` → 5 |
| `SUBSTRING()` | Extract substring | `SUBSTRING('Hello', 1, 3)` → 'Hel' |
| `TRIM()` | Remove spaces | `TRIM('  Hello  ')` → 'Hello' |

**📝 Example:**
```sql
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    UPPER(email) AS email_upper,
    LENGTH(name) AS name_length
FROM employees;
```

---

### 🔢 Numeric Functions

| Function | Description | Example |
|----------|-------------|---------|
| `ROUND()` | Round number | `ROUND(3.7)` → 4 |
| `CEILING()` | Round up | `CEILING(3.2)` → 4 |
| `FLOOR()` | Round down | `FLOOR(3.7)` → 3 |
| `ABS()` | Absolute value | `ABS(-5)` → 5 |
| `MOD()` | Modulo | `MOD(10, 3)` → 1 |
| `POWER()` | Power | `POWER(2, 3)` → 8 |

**📝 Example:**
```sql
SELECT 
    salary,
    ROUND(salary * 1.10, 2) AS salary_after_raise,
    MOD(salary, 1000) AS remainder
FROM employees;
```

---

### 📅 Date Functions

| Function | Description | Example |
|----------|-------------|---------|
| `NOW()` | Current datetime | 2024-01-15 14:30:00 |
| `CURDATE()` | Current date | 2024-01-15 |
| `CURTIME()` | Current time | 14:30:00 |
| `YEAR()` | Extract year | `YEAR('2024-01-15')` → 2024 |
| `MONTH()` | Extract month | `MONTH('2024-01-15')` → 1 |
| `DAY()` | Extract day | `DAY('2024-01-15')` → 15 |
| `DATEDIFF()` | Difference in days | `DATEDIFF('2024-01-15', '2024-01-01')` → 14 |

**📝 Example:**
```sql
SELECT 
    name,
    hire_date,
    DATEDIFF(NOW(), hire_date) AS days_employed,
    TIMESTAMPDIFF(YEAR, hire_date, NOW()) AS years_employed
FROM employees;
```

---

## 📦 Grouping and Having

### 📊 GROUP BY

**Single Column Grouping**
```sql
-- Count employees per department
SELECT 
    department_id, 
    COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;
```

**📝 Example Output:**
```
+---------------+----------------+
| department_id | employee_count |
+---------------+----------------+
| 1             | 15             |
| 2             | 20             |
| 3             | 10             |
+---------------+----------------+
```

**Multiple Column Grouping**
```sql
SELECT 
    department_id, 
    YEAR(hire_date) AS year,
    COUNT(*) AS hires
FROM employees
GROUP BY department_id, YEAR(hire_date);
```

**With Aggregates** ⭐
```sql
SELECT 
    department_id,
    COUNT(*) AS total_employees,
    AVG(salary) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM employees
GROUP BY department_id;
```

---

### 🎯 HAVING Clause

> **WHERE** filters rows before grouping, **HAVING** filters groups after grouping.

**Filter Groups**
```sql
-- Departments with average salary > 60000
SELECT 
    department_id, 
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING avg_salary > 60000;
```

**Combined WHERE and HAVING**
```sql
SELECT 
    department_id, 
    AVG(salary) AS avg_salary
FROM employees
WHERE hire_date > '2023-01-01'  -- Filter BEFORE grouping
GROUP BY department_id
HAVING avg_salary > 60000;       -- Filter AFTER grouping
```

---

### 📈 WITH ROLLUP

**Add Summary Row**
```sql
SELECT 
    department_id, 
    SUM(salary) AS total_salary
FROM employees
GROUP BY department_id WITH ROLLUP;
```

**📝 Example Output:**
```
+---------------+--------------+
| department_id | total_salary |
+---------------+--------------+
| 1             | 500000       |
| 2             | 800000       |
| NULL          | 1300000      | ← Total
+---------------+--------------+
```

---

## 🎭 Subqueries

> A **subquery** is a query nested inside another query.

### 🎯 Subquery in WHERE

**Find Above-Average Earners**
```sql
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

**IN Operator**
```sql
-- Find employees in Sales or Marketing
SELECT name
FROM employees
WHERE department_id IN (
    SELECT id FROM departments 
    WHERE name IN ('Sales', 'Marketing')
);
```

**ALL Operator**
```sql
-- Earning more than ANYONE in department 1
SELECT name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary FROM employees WHERE department_id = 1
);
```

**ANY Operator**
```sql
-- Earning more than SOMEONE in department 1
SELECT name, salary
FROM employees
WHERE salary > ANY (
    SELECT salary FROM employees WHERE department_id = 1
);
```

---

### 📊 Subquery in FROM

**Temporary Table**
```sql
SELECT dept_salary.department_id, dept_salary.avg_salary
FROM (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_salary
WHERE dept_salary.avg_salary > 60000;
```

---

### 🔍 EXISTS

**Check if Subquery Returns Rows**
```sql
-- Departments with employees
SELECT d.name
FROM departments d
WHERE EXISTS (
    SELECT 1 FROM employees e 
    WHERE e.department_id = d.id
);
```

**NOT EXISTS**
```sql
-- Departments without employees
SELECT d.name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e 
    WHERE e.department_id = d.id
);
```

---

## 🔒 Constraints

> **Constraints** enforce rules on data in tables.

### 🔑 Primary Key

**Uniquely identifies each row**

```sql
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);
```

**Composite Primary Key**
```sql
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);
```

---

### 🔗 Foreign Key

**Links tables together**

```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);
```

**With Cascade Options**
```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    department_id INT,
    FOREIGN KEY (department_id) 
        REFERENCES departments(id)
        ON DELETE CASCADE      -- Delete employees if department deleted
        ON UPDATE CASCADE      -- Update if department ID changes
);
```

| Option | Description |
|--------|-------------|
| `CASCADE` | Delete/update child rows |
| `SET NULL` | Set foreign key to NULL |
| `RESTRICT` | Prevent deletion/update |
| `NO ACTION` | Same as RESTRICT |

---

### ✨ UNIQUE Constraint

**Ensures all values are different**

```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE  -- No duplicate emails
);
```

---

### ❗ NOT NULL Constraint

**Field must have a value**

```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);
```

---

### ✅ CHECK Constraint

**Custom validation rules** (MySQL 8.0.16+)

```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    age INT CHECK (age >= 18),
    salary DECIMAL(10,2) CHECK (salary > 0)
);
```

---

### 🎨 DEFAULT Constraint

**Provides default value**

```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## ⚡ Indexes

> **Indexes** speed up data retrieval but slow down writes.

### ➕ Create Index

**Single Column**
```sql
CREATE INDEX idx_name ON employees(name);
```

**Composite Index**
```sql
CREATE INDEX idx_name_dept ON employees(name, department_id);
```

**Unique Index**
```sql
CREATE UNIQUE INDEX idx_email ON employees(email);
```

**Full-Text Index**
```sql
CREATE FULLTEXT INDEX idx_description ON products(description);
```

---

### 👀 Show Indexes

```sql
SHOW INDEXES FROM employees;
```

---

### ❌ Drop Index

```sql
DROP INDEX idx_name ON employees;
```

---

### 🔍 Check Query Performance

**EXPLAIN** shows how MySQL executes a query

```sql
EXPLAIN SELECT * FROM employees WHERE name = 'John';
```

---

## 👁️ Views

> A **view** is a saved query that acts like a virtual table.

### ➕ Create View

**Simple View**
```sql
CREATE VIEW employee_details AS
SELECT e.name, e.salary, d.name AS department
FROM employees e
JOIN departments d ON e.department_id = d.id;
```

**Use View**
```sql
-- Query like a regular table
SELECT * FROM employee_details;
```

---

### 🔧 Modify View

```sql
CREATE OR REPLACE VIEW employee_details AS
SELECT e.name, e.salary, e.email, d.name AS department
FROM employees e
JOIN departments d ON e.department_id = d.id;
```

---

### ❌ Drop View

```sql
DROP VIEW employee_details;
```

---

## ⚙️ Stored Procedures

> **Stored procedures** are reusable SQL code blocks.

### ➕ Create Procedure

**Simple Procedure**
```sql
DELIMITER //
CREATE PROCEDURE GetAllEmployees()
BEGIN
    SELECT * FROM employees;
END //
DELIMITER ;
```

**With Parameters**
```sql
DELIMITER //
CREATE PROCEDURE GetEmployeeById(IN emp_id INT)
BEGIN
    SELECT * FROM employees WHERE id = emp_id;
END //
DELIMITER ;
```

**With OUT Parameter**
```sql
DELIMITER //
CREATE PROCEDURE GetEmployeeCount(OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total FROM employees;
END //
DELIMITER ;
```

---

### ▶️ Call Procedure

```sql
-- Simple call
CALL GetAllEmployees();

-- With parameter
CALL GetEmployeeById(1);

-- With OUT parameter
CALL GetEmployeeCount(@total);
SELECT @total;
```

---

### 👀 Show Procedures

```sql
-- List all procedures
SHOW PROCEDURE STATUS WHERE Db = 'company';

-- Show procedure code
SHOW CREATE PROCEDURE GetAllEmployees;
```

---

### ❌ Drop Procedure

```sql
DROP PROCEDURE GetAllEmployees;
```

---

## 🎬 Triggers

> **Triggers** automatically execute code when certain events occur.

### ➕ Create Trigger

**BEFORE INSERT**
```sql
DELIMITER //
CREATE TRIGGER before_employee_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    SET NEW.created_at = NOW();
    SET NEW.email = LOWER(NEW.email);
END //
DELIMITER ;
```

**AFTER INSERT** (Audit Log)
```sql
DELIMITER //
CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (employee_id, action, action_date)
    VALUES (NEW.id, 'INSERT', NOW());
END //
DELIMITER ;
```

**BEFORE UPDATE** (Validation)
```sql
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
```

**AFTER UPDATE** (History Tracking)
```sql
DELIMITER //
CREATE TRIGGER after_employee_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_history 
        (employee_id, old_salary, new_salary, change_date)
        VALUES (NEW.id, OLD.salary, NEW.salary, NOW());
    END IF;
END //
DELIMITER ;
```

---

### 👀 Show Triggers

```sql
SHOW TRIGGERS;

-- For specific table
SHOW TRIGGERS WHERE `Table` = 'employees';
```

---

### ❌ Drop Trigger

```sql
DROP TRIGGER before_employee_insert;
```

---

## 💰 Transactions

> **Transactions** ensure data integrity by grouping operations.

### 🔄 Basic Transaction

```sql
START TRANSACTION;

-- Transfer money between accounts
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;

-- Save changes
COMMIT;

-- OR undo changes
-- ROLLBACK;
```

---

### 📌 Savepoints

```sql
START TRANSACTION;

UPDATE accounts SET balance = balance - 100 WHERE id = 1;

SAVEPOINT sp1;

UPDATE accounts SET balance = balance + 100 WHERE id = 2;

-- Rollback to savepoint
ROLLBACK TO sp1;

COMMIT;
```

---

### 🔒 Isolation Levels

| Level | Description | Issues Prevented |
|-------|-------------|------------------|
| `READ UNCOMMITTED` | Can read uncommitted data | None |
| `READ COMMITTED` | Only read committed data | Dirty reads |
| `REPEATABLE READ` | Same read in transaction | Dirty + Non-repeatable reads |
| `SERIALIZABLE` | Full isolation | All concurrency issues |

**Set Isolation Level**
```sql
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

---

### ⚙️ Auto-commit

```sql
-- Check status
SELECT @@autocommit;

-- Disable (manual commits)
SET autocommit = 0;

-- Enable (auto commits)
SET autocommit = 1;
```

---

### ✅ Transaction Best Practices

```sql
START TRANSACTION;

-- Lock row for update
SELECT balance INTO @current_balance 
FROM accounts 
WHERE id = 1 
FOR UPDATE;

-- Check condition
IF @current_balance >= 100 THEN
    UPDATE accounts SET balance = balance - 100 WHERE id = 1;
    UPDATE accounts SET balance = balance + 100 WHERE id = 2;
    COMMIT;
ELSE
    ROLLBACK;
    SELECT 'Insufficient balance' AS error;
END IF;
```

---

## 👥 User Management

### ➕ Create User

```sql
-- Local user
CREATE USER 'john'@'localhost' IDENTIFIED BY 'secure_password';

-- Remote user (any host)
CREATE USER 'john'@'%' IDENTIFIED BY 'secure_password';

-- Specific IP
CREATE USER 'john'@'192.168.1.100' IDENTIFIED BY 'secure_password';
```

---

### 🔑 Grant Privileges

**All Privileges**
```sql
-- On all databases
GRANT ALL PRIVILEGES ON *.* TO 'john'@'localhost';

-- On specific database
GRANT ALL PRIVILEGES ON company.* TO 'john'@'localhost';
```

**Specific Privileges**
```sql
GRANT SELECT, INSERT, UPDATE ON company.* TO 'john'@'localhost';

-- On specific table
GRANT SELECT, INSERT ON company.employees TO 'john'@'localhost';
```

**Common Privileges:**
- 📖 `SELECT` - Read data
- ✏️ `INSERT` - Add new data
- 🔄 `UPDATE` - Modify data
- ❌ `DELETE` - Remove data
- 🏗️ `CREATE` - Create databases/tables
- 🗑️ `DROP` - Delete databases/tables
- 🔧 `ALTER` - Modify structure
- 👀 `SHOW VIEW` - View definitions
- ⚙️ `EXECUTE` - Run procedures

**Apply Changes**
```sql
FLUSH PRIVILEGES;
```

---

### 👀 Show Privileges

```sql
-- Current user
SHOW GRANTS;

-- Specific user
SHOW GRANTS FOR 'john'@'localhost';
```

---

### 🔒 Revoke Privileges

```sql
-- Revoke specific privileges
REVOKE INSERT, UPDATE ON company.* FROM 'john'@'localhost';

-- Revoke all
REVOKE ALL PRIVILEGES ON company.* FROM 'john'@'localhost';
```

---

### 🔧 Modify User

```sql
-- Change password
ALTER USER 'john'@'localhost' IDENTIFIED BY 'new_password';

-- Rename user
RENAME USER 'john'@'localhost' TO 'john_smith'@'localhost';
```

---

### ❌ Delete User

```sql
DROP USER 'john'@'localhost';
```

---

### 👥 List Users

```sql
SELECT user, host FROM mysql.user;
```

---

## 🚀 Advanced Concepts

### 📊 Window Functions (MySQL 8.0+)

**ROW_NUMBER** - Sequential numbering
```sql
SELECT 
    name, 
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;
```

**RANK** - Ranking with gaps
```sql
SELECT 
    name, 
    salary,
    RANK() OVER (ORDER BY salary DESC) AS rank
FROM employees;
```

**📝 Example Output:**
```
+------------+--------+------+
| name       | salary | rank |
+------------+--------+------+
| Alice      | 90000  | 1    |
| Bob        | 80000  | 2    |
| Charlie    | 80000  | 2    | ← Same rank
| David      | 70000  | 4    | ← Gap in ranking
+------------+--------+------+
```

**DENSE_RANK** - Ranking without gaps
```sql
SELECT 
    name, 
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM employees;
```

**PARTITION BY** - Ranking within groups
```sql
SELECT 
    name,
    department_id,
    salary,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
FROM employees;
```

**LAG and LEAD** - Previous/Next row
```sql
SELECT 
    name,
    salary,
    LAG(salary) OVER (ORDER BY hire_date) AS previous_salary,
    LEAD(salary) OVER (ORDER BY hire_date) AS next_salary
FROM employees;
```

**Running Total**
```sql
SELECT 
    name,
    salary,
    SUM(salary) OVER (ORDER BY hire_date) AS running_total
FROM employees;
```

**Moving Average**
```sql
SELECT 
    name,
    salary,
    AVG(salary) OVER (
        ORDER BY hire_date 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_3
FROM employees;
```

---

### 🎯 Common Table Expressions (CTE)

**Simple CTE**
```sql
WITH high_earners AS (
    SELECT * FROM employees WHERE salary > 70000
)
SELECT * FROM high_earners WHERE department_id = 1;
```

**Multiple CTEs**
```sql
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
```

**Recursive CTE** - Organizational Hierarchy
```sql
WITH RECURSIVE employee_hierarchy AS (
    -- Base: Top-level employees
    SELECT id, name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive: Add subordinates
    SELECT e.id, e.name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.id
)
SELECT * FROM employee_hierarchy ORDER BY level, name;
```

---

### 📦 JSON Functions (MySQL 5.7+)

**Create Table with JSON**
```sql
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    attributes JSON
);
```

**Insert JSON Data**
```sql
INSERT INTO products (id, name, attributes) VALUES
(1, 'Laptop', '{"brand": "Dell", "ram": 16, "storage": 512}'),
(2, 'Phone', '{"brand": "Apple", "model": "iPhone 14"}');
```

**Extract JSON Values**
```sql
SELECT 
    name,
    JSON_EXTRACT(attributes, '$.brand') AS brand,
    attributes->'$.ram' AS ram,           -- Shorthand
    attributes->>'$.brand' AS brand_text  -- Unquoted string
FROM products;
```

**Query JSON Arrays**
```sql
-- Product with lenses array
INSERT INTO products VALUES
(3, 'Camera', '{"brand": "Canon", "lenses": ["50mm", "85mm", "24-70mm"]}');

-- Query array
SELECT 
    name,
    JSON_LENGTH(attributes->'$.lenses') AS lens_count,
    JSON_EXTRACT(attributes, '$.lenses[0]') AS first_lens
FROM products
WHERE JSON_CONTAINS(attributes->'$.lenses', '"50mm"');
```

**Modify JSON**
```sql
-- Update existing field
UPDATE products
SET attributes = JSON_SET(attributes, '$.ram', 32)
WHERE id = 1;

-- Add new field
UPDATE products
SET attributes = JSON_INSERT(attributes, '$.warranty', '2 years')
WHERE id = 1;

-- Remove field
UPDATE products
SET attributes = JSON_REMOVE(attributes, '$.color')
WHERE id = 2;
```

---

### 🔍 Full-Text Search

**Create Full-Text Index**
```sql
CREATE TABLE articles (
    id INT PRIMARY KEY,
    title VARCHAR(200),
    content TEXT,
    FULLTEXT (title, content)
);
```

**Natural Language Search**
```sql
SELECT * FROM articles
WHERE MATCH(title, content) AGAINST('database optimization');
```

**Boolean Search**
```sql
SELECT * FROM articles
WHERE MATCH(title, content) 
AGAINST('+mysql -oracle' IN BOOLEAN MODE);
```

**Boolean Operators:**
- `+` Must include
- `-` Must exclude
- `*` Wildcard
- `""` Exact phrase
- `>` Increase relevance
- `<` Decrease relevance

**With Relevance Score**
```sql
SELECT 
    title,
    MATCH(title, content) AGAINST('mysql optimization') AS relevance
FROM articles
WHERE MATCH(title, content) AGAINST('mysql optimization')
ORDER BY relevance DESC;
```

---

### 📊 Partitioning

**Range Partitioning** - By date range
```sql
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
```

**List Partitioning** - By specific values
```sql
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
```

**Hash Partitioning** - Even distribution
```sql
CREATE TABLE logs (
    id INT,
    message TEXT,
    created_at TIMESTAMP
)
PARTITION BY HASH(id)
PARTITIONS 4;
```

---

### ⚡ Performance Optimization

**EXPLAIN - Query Analysis**
```sql
EXPLAIN SELECT * FROM employees WHERE salary > 60000;
```

**📝 Example Output:**
```
+----+-------------+-----------+------+---------------+------+---------+------+------+-------------+
| id | select_type | table     | type | possible_keys | key  | key_len | ref  | rows | Extra       |
+----+-------------+-----------+------+---------------+------+---------+------+------+-------------+
| 1  | SIMPLE      | employees | ALL  | NULL          | NULL | NULL    | NULL | 100  | Using where |
+----+-------------+-----------+------+---------------+------+---------+------+------+-------------+
```

**ANALYZE TABLE** - Update statistics
```sql
ANALYZE TABLE employees;
```

**OPTIMIZE TABLE** - Defragment
```sql
OPTIMIZE TABLE employees;
```

**Index Hints**
```sql
-- Suggest index
SELECT * FROM employees USE INDEX (idx_salary) WHERE salary > 60000;

-- Force index
SELECT * FROM employees FORCE INDEX (idx_salary) WHERE salary > 60000;

-- Ignore index
SELECT * FROM employees IGNORE INDEX (idx_salary) WHERE salary > 60000;
```

---

### 📥 Import and Export

**Export to CSV**
```sql
SELECT * FROM employees
INTO OUTFILE '/tmp/employees.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
```

**Import from CSV**
```sql
LOAD DATA INFILE '/tmp/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;  -- Skip header
```

**mysqldump (Command Line)**
```bash
# Export database
mysqldump -u root -p company > company_backup.sql

# Export specific tables
mysqldump -u root -p company employees departments > backup.sql

# Export with compression
mysqldump -u root -p company | gzip > company.sql.gz

# Import
mysql -u root -p company < company_backup.sql

# Import compressed
gunzip < company.sql.gz | mysql -u root -p company
```

---

### 💾 Backup and Restore

```bash
# Full backup
mysqldump -u root -p --all-databases > all_databases.sql

# Single database
mysqldump -u root -p company > company.sql

# Structure only
mysqldump -u root -p --no-data company > structure.sql

# Data only
mysqldump -u root -p --no-create-info company > data.sql

# Restore
mysql -u root -p company < company.sql
```

---

### 📊 System Information

**Database Size**
```sql
SELECT 
    table_schema AS '📂 Database',
    ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS '📊 Size (MB)'
FROM information_schema.tables
GROUP BY table_schema;
```

**Table Size**
```sql
SELECT 
    table_name AS '📋 Table',
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS '💾 Size (MB)'
FROM information_schema.tables
WHERE table_schema = 'company'
ORDER BY (data_length + index_length) DESC;
```

**Active Connections**
```sql
SHOW PROCESSLIST;
```

**Server Status**
```sql
SHOW STATUS LIKE 'Threads_connected';
SHOW VARIABLES LIKE 'max_connections';
```

---

## 📌 Quick Reference

### 🎯 Most Common Commands

| Category | Command | Example |
|----------|---------|---------|
| **Database** | Create | `CREATE DATABASE company;` |
| | Use | `USE company;` |
| | Drop | `DROP DATABASE company;` |
| | Show | `SHOW DATABASES;` |
| **Table** | Create | `CREATE TABLE employees (...);` |
| | Drop | `DROP TABLE employees;` |
| | Describe | `DESCRIBE employees;` |
| | Show | `SHOW TABLES;` |
| **CRUD** | Insert | `INSERT INTO ... VALUES (...);` |
| | Select | `SELECT * FROM employees;` |
| | Update | `UPDATE ... SET ... WHERE ...;` |
| | Delete | `DELETE FROM ... WHERE ...;` |

---

### ✅ Best Practices

| ✅ Do | ❌ Don't |
|-------|----------|
| Use prepared statements | Trust user input directly |
| Use transactions for related operations | Forget COMMIT/ROLLBACK |
| Index frequently queried columns | Over-index (slows writes) |
| Use specific column names | Use `SELECT *` in production |
| Use `LIMIT` for large results | Load millions of rows at once |
| Regular backups | Assume data is safe |
| Use `WHERE` in UPDATE/DELETE | Update/delete without `WHERE` |
| Normalize database design | Duplicate data everywhere |
| Use appropriate data types | Use VARCHAR for everything |
| Test queries with EXPLAIN | Run slow queries blindly |

---

### 🔍 SQL Query Order

```sql
SELECT columns          -- 5. Select columns
FROM table             -- 1. Get data from table
WHERE condition        -- 2. Filter rows
GROUP BY columns       -- 3. Group rows
HAVING condition       -- 4. Filter groups
ORDER BY columns       -- 6. Sort results
LIMIT number;          -- 7. Limit results
```

---

### 🎨 Data Type Quick Guide

| Type | Use For | Example |
|------|---------|---------|
| `INT` | Whole numbers | Age, quantity, ID |
| `DECIMAL(10,2)` | Money | Prices, salaries |
| `VARCHAR(255)` | Text | Names, emails |
| `TEXT` | Long text | Descriptions, articles |
| `DATE` | Dates | Birth date, hire date |
| `DATETIME` | Date + time | Created at, updated at |
| `BOOLEAN` | True/false | Is active, is verified |
| `JSON` | JSON data | Metadata, settings |

---

## 🎓 Learning Resources

### 📚 Official Documentation
- [MySQL Official Docs](https://dev.mysql.com/doc/) - Complete reference
- [MySQL Tutorial](https://dev.mysql.com/doc/mysql-tutorial-excerpt/8.0/en/) - Official tutorial

### 🎯 Practice Platforms
- [SQLZoo](https://sqlzoo.net/) - Interactive SQL tutorial
- [LeetCode SQL](https://leetcode.com/problemset/database/) - SQL practice problems
- [HackerRank SQL](https://www.hackerrank.com/domains/sql) - Coding challenges
- [Mode SQL Tutorial](https://mode.com/sql-tutorial/) - Real-world examples

### 📖 Learning Paths
1. **Week 1-2:** Basic commands (CREATE, INSERT, SELECT, UPDATE, DELETE)
2. **Week 3-4:** Filtering, sorting, joins
3. **Week 5-6:** Aggregates, grouping, subqueries
4. **Week 7-8:** Indexes, views, stored procedures
5. **Week 9-10:** Transactions, triggers, advanced concepts

### 💡 Pro Tips
- 🎯 Practice daily with real datasets
- 📝 Start simple, build complexity gradually
- 🔍 Use EXPLAIN to understand query performance
- 💾 Always backup before major operations
- 📚 Read error messages carefully
- 🤝 Join SQL communities (Reddit, Stack Overflow)

---

## 🎯 Sample Database Schema

```sql
-- Create sample company database
CREATE DATABASE company;
USE company;

-- Departments table
CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    budget DECIMAL(12, 2)
);

-- Employees table
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2) DEFAULT 50000,
    department_id INT,
    manager_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL,
    FOREIGN KEY (manager_id) REFERENCES employees(id) ON DELETE SET NULL
);

-- Sample data
INSERT INTO departments (name, budget) VALUES
('Sales', 500000),
('Engineering', 1000000),
('Marketing', 300000),
('HR', 200000);

INSERT INTO employees (first_name, last_name, email, hire_date, salary, department_id) VALUES
('John', 'Doe', 'john.doe@company.com', '2020-01-15', 75000, 2),
('Jane', 'Smith', 'jane.smith@company.com', '2019-06-20', 85000, 2),
('Bob', 'Johnson', 'bob.j@company.com', '2021-03-10', 65000, 1),
('Alice', 'Williams', 'alice.w@company.com', '2020-09-05', 70000, 3),
('Charlie', 'Brown', 'charlie.b@company.com', '2022-01-12', 60000, 4);
```

---

## 🎉 Conclusion

Congratulations! 🎊 You now have a comprehensive reference for MySQL and SQL. Remember:

- 📖 **Learning SQL is a journey** - Start with basics, practice regularly
- 💻 **Hands-on practice is key** - Create databases, experiment with queries
- 🔍 **Read error messages** - They're your friends in debugging
- 💾 **Always backup** - Before making major changes
- 🚀 **Keep learning** - SQL is powerful and constantly evolving

---

### 🌟 Next Steps

1. ✅ Install MySQL on your system
2. ✅ Create the sample database above
3. ✅ Practice each section with your own examples
4. ✅ Build a small project (todo app, blog, etc.)
5. ✅ Learn about database design principles
6. ✅ Explore MySQL optimization techniques
7. ✅ Join SQL communities and forums

---

### 📞 Need Help?

- 💬 [Stack Overflow SQL Tag](https://stackoverflow.com/questions/tagged/sql)
- 💬 [MySQL Community Forums](https://forums.mysql.com/)
- 📧 [r/SQL on Reddit](https://www.reddit.com/r/SQL/)
- 📖 [MySQL Documentation](https://dev.mysql.com/doc/)

---

<div align="center">

### 🚀 Happy Learning! 

**Made with ❤️ for SQL Learners**

⭐ If this guide helped you, share it with others!

</div>

---

**Last Updated:** November 2025  
**Version:** 2.0  
**License:** Educational Use