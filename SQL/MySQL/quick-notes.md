# MySQL Master Reference Guide

This README.md is a **complete MySQL guide** combining professional documentation (Option A) + developer‑friendly format (Option B). It contains everything you need for:
- Writing efficient SQL queries
- Understanding DB concepts quickly
- Optimizing performance in production
- String/date/number manipulation
- Transactions, triggers, procedures, indexing
- Debugging
- Best practices
- Cheat‑sheet level quick references

Use this file whenever you forget something — everything is here.

---

# 📘 Table of Contents
1. [Introduction](#-introduction)
2. [Basics](#-basics)
3. [Database Operations](#-database-operations)
4. [Table Operations](#-table-operations)
5. [CRUD Operations](#-crud-operations)
6. [Filtering & Logic](#-filtering--logic)
7. [String Functions](#-string-functions)
8. [Date & Time Functions](#-date--time-functions)
9. [Number Functions](#-number-functions)
10. [Joins](#-joins)
11. [Subqueries](#-subqueries)
12. [Indexes & Performance](#-indexes--performance)
13. [Query Optimization Best Practices](#-query-optimization-best-practices)
14. [Transactions](#-transactions)
15. [Views](#-views)
16. [Stored Procedures](#-stored-procedures)
17. [Triggers](#-triggers)
18. [User Management](#-user-management)
19. [Backup & Restore](#-backup--restore)
20. [Advanced Production Tips](#-advanced-production-tips)
21. [Cheat Sheet](#-cheat-sheet)

---

# 🟦 Introduction
MySQL is a powerful relational database. Mastering it means:
- More stable backend systems
- Faster applications
- Predictable performance in production

This guide helps achieve expert‑level command.

---

# 🟦 Basics

## ▶️ Connect to MySQL
```bash
mysql -u root -p
```

## ▶️ Show MySQL version
```sql
SELECT VERSION();
```

## ▶️ Show current database
```sql
SELECT DATABASE();
```

---

# 🟦 Database Operations

### Create database
```sql
CREATE DATABASE appdb;
```

### Use database
```sql
USE appdb;
```

### Show all databases
```sql
SHOW DATABASES;
```

### Drop database
```sql
DROP DATABASE appdb;
```

---

# 🟦 Table Operations

## Create table
```sql
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(120) UNIQUE,
  age INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Show table structure
```sql
DESCRIBE users;
```

## Show columns
```sql
SHOW COLUMNS FROM users;
```

## Drop table
```sql
DROP TABLE users;
```

## Add column
```sql
ALTER TABLE users ADD phone VARCHAR(20);
```

## Modify column
```sql
ALTER TABLE users MODIFY age SMALLINT;
```

## Rename column
```sql
ALTER TABLE users RENAME COLUMN name TO full_name;
```

---

# 🟦 CRUD Operations

## Insert single row
```sql
INSERT INTO users (name, email) VALUES ('John', 'john@gmail.com');
```

## Insert multiple rows
```sql
INSERT INTO users (name, email) VALUES
('A', 'a@gmail.com'),
('B', 'b@gmail.com');
```

## Select
```sql
SELECT * FROM users;
```

## Select specific columns
```sql
SELECT id, name FROM users;
```

## Update
```sql
UPDATE users SET age = 25 WHERE id = 1;
```

## Delete row
```sql
DELETE FROM users WHERE id = 1;
```

---

# 🟦 Filtering & Logic

## WHERE
```sql
SELECT * FROM users WHERE age > 20;
```

## AND / OR
```sql
SELECT * FROM users
WHERE age > 18 AND email LIKE '%gmail%';
```

## BETWEEN
```sql
SELECT * FROM orders WHERE amount BETWEEN 100 AND 500;
```

## IN
```sql
SELECT * FROM users WHERE id IN (1,2,3);
```

## LIKE
```sql
SELECT * FROM users WHERE email LIKE '%gmail.com';
```

## ORDER BY
```sql
SELECT * FROM users ORDER BY created_at DESC;
```

## LIMIT
```sql
SELECT * FROM users LIMIT 10;
```

---

# 🟦 String Functions

| Function | Example | Result |
|---------|---------|--------|
| `UPPER()` | `UPPER('hello')` | HELLO |
| `LOWER()` | `LOWER('HELLO')` | hello |
| `CONCAT()` | `CONCAT('A','B')` | AB |
| `LTRIM()` | removes left spaces | |
| `RTRIM()` | removes right spaces | |
| `TRIM()` | both sides | |
| `SUBSTRING()` | `SUBSTRING('Hello', 2, 3)` | ell |
| `REPLACE()` | `REPLACE('Hi John', 'John', 'Sam')` | Hi Sam |
| `LENGTH()` | `LENGTH('abc')` | 3 |

### Example
```sql
SELECT CONCAT(UPPER(name), ' is ', age, ' years old') AS info
FROM users;
```

---

# 🟦 Date & Time Functions

| Function | Example |
|----------|---------|
| NOW() | current timestamp |
| CURDATE() | only date |
| CURTIME() | only time |
| DATE_ADD() | add time |
| DATE_SUB() | subtract time |
| DATEDIFF() | days difference |
| TIMESTAMPDIFF() | diff with unit |
| DATE_FORMAT() | formatting |

## Examples

### Add 5 hours
```sql
SELECT DATE_ADD(NOW(), INTERVAL 5 HOUR);
```

### Subtract 10 minutes
```sql
SELECT DATE_SUB(NOW(), INTERVAL 10 MINUTE);
```

### Difference in days
```sql
SELECT DATEDIFF('2025-01-20', '2025-01-10');
```

### Format date
```sql
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %h:%i %p');
```

---

# 🟦 Number Functions

```sql
SELECT ABS(-10);      -- 10
SELECT CEIL(10.2);    -- 11
SELECT FLOOR(10.8);   -- 10
SELECT ROUND(12.567, 2); -- 12.57
SELECT MOD(10, 3);    -- 1
```

---

# 🟦 Joins

## Inner Join
```sql
SELECT u.name, o.amount
FROM users u
JOIN orders o ON u.id = o.user_id;
```

## Left Join
```sql
SELECT u.*, o.amount
FROM users u
LEFT JOIN orders o ON u.id = o.user_id;
```

## Right Join
```sql
SELECT *
FROM users u
RIGHT JOIN orders o ON u.id = o.user_id;
```

---

# 🟦 Subqueries

## Basic subquery
```sql
SELECT * FROM users WHERE id IN (
  SELECT user_id FROM orders WHERE amount > 500
);
```

## Correlated subquery
```sql
SELECT name FROM users u
WHERE EXISTS (
  SELECT 1 FROM orders o WHERE o.user_id = u.id
);
```

---

# 🟦 Indexes & Performance

## Create index
```sql
CREATE INDEX idx_email ON users(email);
```

## Drop index
```sql
DROP INDEX idx_email ON users;
```

## Composite index
```sql
CREATE INDEX idx_user_status_date
ON orders(user_id, status, created_at);
```

### Best Practices
- Index columns used frequently in WHERE, JOIN, ORDER BY
- Avoid indexing low-cardinality columns (gender, active_flag)
- Use composite indexes in left-to-right order
- Keep indexes small and selective

---

# 🟦 Query Optimization Best Practices

### ✔️ Use SELECT specific columns (not *)
```sql
SELECT id, name FROM users;
```

### ✔️ Use LIMIT for pagination
```sql
SELECT * FROM orders ORDER BY id DESC LIMIT 50;
```

### ✔️ Avoid OR — use IN
```sql
SELECT * FROM users WHERE id IN (1,2,3);
```

### ✔️ Use proper indexing

### ✔️ Avoid functions on indexed columns
🚫 Bad:
```sql
WHERE DATE(created_at) = '2025-01-20';
```

✅ Good:
```sql
WHERE created_at BETWEEN '2025-01-20 00:00:00' AND '2025-01-20 23:59:59';
```

### ✔️ Analyze slow queries
```sql
EXPLAIN SELECT * FROM users WHERE email = "test@gmail.com";
```

### ✔️ Normalize for consistency
### ✔️ Denormalize for performance (if needed)

---

# 🟦 Transactions

```sql
START TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;
```

Rollback:
```sql
ROLLBACK;
```

---

# 🟦 Views
```sql
CREATE VIEW active_users AS
SELECT id, name FROM users WHERE active = 1;
```

Delete view:
```sql
DROP VIEW active_users;
```

---

# 🟦 Stored Procedures
```sql
DELIMITER $$
CREATE PROCEDURE GetUsers()
BEGIN
  SELECT * FROM users;
END $$
DELIMITER ;
```

Call:
```sql
CALL GetUsers();
```

---

# 🟦 Triggers
```sql
CREATE TRIGGER before_insert_user
BEFORE INSERT ON users
FOR EACH ROW
SET NEW.created_at = NOW();
```

---

# 🟦 User Management

### Create user
```sql
CREATE USER 'venk'@'localhost' IDENTIFIED BY 'password';
```

### Grant permissions
```sql
GRANT ALL PRIVILEGES ON appdb.* TO 'venk'@'localhost';
```

### Show users
```sql
SELECT User, Host FROM mysql.user;
```

---

# 🟦 Backup & Restore

Backup:
```bash
mysqldump -u root -p appdb > appdb.sql
```

Restore:
```bash
mysql -u root -p appdb < appdb.sql
```

---

# 🟦 Advanced Production Tips
- Enable slow query log
- Use connection pooling
- Prefer prepared statements
- Keep data types tight (INT vs BIGINT)
- Partition large tables
- Archive old data
- Monitor with EXPLAIN + performance schema

---

# 🟦 Cheat Sheet
- `SELECT * FROM table;`
- `INSERT INTO table (...) VALUES (...);`
- `UPDATE table SET ... WHERE ...;`
- `DELETE FROM table WHERE ...;`
- `JOIN table B ON A.id = B.id;`
- `CREATE INDEX idx ON table(col);`
- `DATE_ADD(NOW(), INTERVAL 1 DAY)`
- `CONCAT(), SUBSTRING(), REPLACE(), UPPER(), LOWER()`
- `START TRANSACTION; COMMIT;`


---

# 🟦 Advanced Chapters

## Query Execution Engine (How MySQL processes queries)
- Parse → Optimize → Execute → Return
- Important for understanding EXPLAIN plans

### EXPLAIN Example
```sql
EXPLAIN SELECT * FROM users WHERE email = 'a@gmail.com';
```

## Query Optimization Internals
- Cost-based optimizer
- Statistics & histograms
- Index cardinality awareness

---

# 🟦 Diagrams

## MySQL Architecture Diagram
```
          +--------------------+
          |       Client       |
          +--------------------+
                    |
          +--------------------+
          |   Connection Pool  |
          +--------------------+
                    |
          +--------------------+     +-----------------------+
          |   SQL Parser       | --> |   Query Optimizer     |
          +--------------------+     +-----------------------+
                    |                         |
                    |                         v
                    |               +-----------------------+
                    |               |  Execution Engine     |
                    |               +-----------------------+
                    |                         |
                    v                         v
          +--------------------+     +-----------------------+
          | Storage Engine     |     | Buffer Pool / Cache   |
          +--------------------+     +-----------------------+
```

---

# 🟦 Real-World Problems & Solutions

## 1. Slow Query on Large Table
### ❌ Problem Query
```sql
SELECT * FROM orders WHERE user_id = 10 AND status = 'PAID';
```
### ✔️ Solution
Add composite index:
```sql
CREATE INDEX idx_orders_user_status ON orders(user_id, status);
```
---

## 2. Table Locking Issues
### Fix
- Use **InnoDB** instead of MyISAM
- Keep transactions short

---

## 3. Query Timing Out
- Add LIMIT
- Add indexes
- Use proper pagination
- Avoid SELECT *

---

# 🟦 Performance Tuning Patterns

### 🔹 Pattern 1: Pagination Optimization
❌ Bad:
```sql
SELECT * FROM orders LIMIT 100000, 50;
```
✔️ Good (seek method):
```sql
SELECT * FROM orders
WHERE id > 100000
LIMIT 50;
```

### 🔹 Pattern 2: Avoid Functions on Indexed Columns
❌ Bad:
```sql
WHERE DATE(created_at) = '2025-01-20'
```
✔️ Good:
```sql
WHERE created_at BETWEEN '2025-01-20 00:00:00'
                      AND '2025-01-20 23:59:59'
```

### 🔹 Pattern 3: Prefer EXISTS over IN
```sql
SELECT name FROM users u
WHERE EXISTS (
  SELECT 1 FROM orders o WHERE o.user_id = u.id
);
```

---

# 🟦 Interview Questions (With Answers)

## 🔥 Basic + Intermediate

### 1. Difference between LEFT JOIN and INNER JOIN
**Answer:**
- `INNER JOIN` → returns matching rows only
- `LEFT JOIN` → returns matching + non-matching rows from left

### Example:
```sql
SELECT u.name, o.amount
FROM users u
LEFT JOIN orders o ON u.id = o.user_id;
```

---

### 2. What is ACID?
- **A**tomicity
- **C**onsistency
- **I**solation
- **D**urability

---

### 3. What is indexing?
Indexes make lookups faster.
```sql
CREATE INDEX idx_email ON users(email);
```

---

## 🔥 Advanced Interview Questions

### Q: How do you find duplicate rows?
```sql
SELECT email, COUNT(*)
FROM users
GROUP BY email
HAVING COUNT(*) > 1;
```

### Q: How do you delete duplicates?
```sql
DELETE u1 FROM users u1
JOIN users u2 ON u1.email = u2.email AND u1.id > u2.id;
```

---

### Q: How to find 2nd highest salary?
```sql
SELECT MAX(salary) as second_highest
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);
```

---

### Q: Explain EXPLAIN
```sql
EXPLAIN SELECT * FROM orders WHERE user_id = 5;
```
- Shows how MySQL executes query
- Helps identify full scans

---

### Q: How to optimize JOIN queries?
- Ensure join columns are indexed
- Use smallest table first
- Avoid functions in join conditions

---

### Q: What is a covering index?
Index containing all fields required by query → no table lookup needed.

```sql
CREATE INDEX idx_users_cover (email, name);
```

---

### Q: Difference between WHERE and HAVING
- `WHERE` filters rows **before** grouping
- `HAVING` filters rows **after** grouping

Example:
```sql
SELECT user_id, COUNT(*)
FROM orders
GROUP BY user_id
HAVING COUNT(*) > 5;
```

---

# 🟦 Final Notes
- Practice writing optimized queries
- Use EXPLAIN frequently
- Keep this reference as your all-in-one MySQL notebook

