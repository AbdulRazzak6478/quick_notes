# 🐘 Complete PostgreSQL Guide
### From Scratch to Advanced - CMD & pgAdmin Edition

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16+-blue.svg)](https://www.postgresql.org/)
[![SQL](https://img.shields.io/badge/SQL-Learning-green.svg)](https://www.postgresql.org/)
[![License](https://img.shields.io/badge/License-Educational-yellow.svg)](https://opensource.org/licenses/MIT)

> 📚 A comprehensive guide covering all PostgreSQL commands with practical examples for both Command Line (psql) and pgAdmin 4. Perfect for beginners and professionals!

---

## 📋 Table of Contents

- [🚀 Getting Started](#-getting-started)
- [🔧 Connection Methods](#-connection-methods)
- [💾 Database Operations](#-database-operations)
- [📊 Schema Operations](#-schema-operations)
- [🏗️ Table Operations](#️-table-operations)
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
- [⚙️ Functions](#️-functions)
- [🎬 Triggers](#-triggers)
- [💰 Transactions](#-transactions)
- [👥 User Management & Roles](#-user-management--roles)
- [🚀 Advanced PostgreSQL Features](#-advanced-postgresql-features)
- [📌 Quick Reference](#-quick-reference)

---

## 🚀 Getting Started

### 📥 Installing PostgreSQL

**Windows** 🪟
```bash
# Download installer from postgresql.org
# Or use chocolatey
choco install postgresql
```

**MacOS** 🍎
```bash
# Using Homebrew
brew install postgresql@16

# Start PostgreSQL service
brew services start postgresql@16
```

**Ubuntu/Debian** 🐧
```bash
# Add PostgreSQL repository
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update

# Install PostgreSQL
sudo apt-get install postgresql-16
```

---

### 🔍 Verify Installation

**CMD/Terminal:**
```bash
# Check PostgreSQL version
psql --version

# Check server status (Linux/Mac)
pg_ctl status

# Windows - Check service
sc query postgresql-x64-16
```

**Expected Output:**
```
psql (PostgreSQL) 16.0
```

---

### 📦 What Gets Installed?

| Component | Description |
|-----------|-------------|
| **PostgreSQL Server** | Database engine |
| **psql** | Command-line interface |
| **pgAdmin 4** | Graphical administration tool |
| **pg_dump** | Backup utility |
| **pg_restore** | Restore utility |

---

## 🔧 Connection Methods

### 💻 Method 1: Using CMD/Terminal (psql)

**Basic Connection:**
```bash
# Connect as default user (postgres)
psql -U postgres

# Connect to specific database
psql -U postgres -d company

# Connect to remote server
psql -h hostname -U username -d database_name

# Connect with password prompt
psql -U postgres -W
```

**Connection String:**
```bash
psql postgresql://username:password@localhost:5432/database_name
```

---

### 🖥️ Method 2: Using pgAdmin 4

**Step-by-Step:**

1. **Open pgAdmin 4**
2. **Right-click on "Servers"** → Register → Server
3. **General Tab:**
   - Name: `Local PostgreSQL`
4. **Connection Tab:**
   - Host: `localhost`
   - Port: `5432`
   - Database: `postgres`
   - Username: `postgres`
   - Password: `your_password`
   - ✅ Save password
5. **Click Save**

**Running Queries in pgAdmin:**
1. Navigate to database → Right-click → **Query Tool** (or press `Alt + Shift + Q`)
2. Write your SQL query
3. Press **F5** or click **Execute (▶️)** button

---

### 🛠️ Basic psql Commands

**Meta Commands** (psql only, not SQL):

```sql
-- List all databases
\l
-- or
\list

-- Connect to database
\c database_name
-- or
\connect database_name

-- List all tables in current database
\dt

-- List all schemas
\dn

-- Describe table structure
\d table_name

-- List all users/roles
\du

-- Show current connection info
\conninfo

-- Execute commands from file
\i /path/to/file.sql

-- Turn on query execution time
\timing

-- Get help
\?

-- Quit psql
\q
```

> **📝 Note:** Meta commands (starting with `\`) work only in psql, not in pgAdmin's Query Tool. Use SQL commands in pgAdmin instead.

---

### 🎯 SQL Commands (Work in Both CMD & pgAdmin)

```sql
-- Show PostgreSQL version
SELECT version();

-- Show current user
SELECT current_user;

-- Show current database
SELECT current_database();

-- Show current date and time
SELECT NOW();

-- Show all databases (SQL way)
SELECT datname FROM pg_database;

-- Show all tables (SQL way)
SELECT tablename FROM pg_tables WHERE schemaname = 'public';
```

---

## 💾 Database Operations

### ➕ Create Database

**CMD (psql):**
```sql
CREATE DATABASE company;

-- With specific owner
CREATE DATABASE company OWNER postgres;

-- With encoding
CREATE DATABASE company 
    ENCODING 'UTF8' 
    LC_COLLATE = 'en_US.UTF-8' 
    LC_CTYPE = 'en_US.UTF-8';

-- With template
CREATE DATABASE company_test 
    TEMPLATE company;
```

**pgAdmin:**
1. Right-click **Databases** → Create → Database
2. Fill in:
   - Database: `company`
   - Owner: `postgres`
   - Encoding: `UTF8`
3. Click **Save**

**Expected Output:**
```
CREATE DATABASE
```

---

### 👀 List Databases

**CMD (psql):**
```sql
-- Meta command (psql only)
\l

-- SQL query (works everywhere)
SELECT datname FROM pg_database WHERE datistemplate = false;
```

**pgAdmin:**
- Expand **Servers** → **PostgreSQL** → **Databases** in the browser tree

**Output:**
```
      Name       |  Owner   | Encoding 
-----------------+----------+----------
 postgres        | postgres | UTF8
 company         | postgres | UTF8
 template0       | postgres | UTF8
 template1       | postgres | UTF8
```

---

### 🎯 Connect to Database

**CMD (psql):**
```sql
-- Meta command
\c company

-- SQL command (for scripts)
-- Not directly available, use \c in psql
```

**pgAdmin:**
- Click on the database name in the browser tree
- Or right-click → **Query Tool**

**Output:**
```
You are now connected to database "company" as user "postgres".
```

---

### ❌ Drop Database

**CMD (psql):**
```sql
-- Drop database (must not be connected to it)
DROP DATABASE company;

-- Drop if exists
DROP DATABASE IF EXISTS company;
```

**pgAdmin:**
1. Right-click database → **Delete/Drop**
2. Confirm deletion

> **⚠️ Warning:** This permanently deletes all data!

---

### 🔧 Alter Database

**CMD/pgAdmin:**
```sql
-- Rename database
ALTER DATABASE company RENAME TO company_new;

-- Change owner
ALTER DATABASE company OWNER TO new_owner;

-- Set connection limit
ALTER DATABASE company CONNECTION LIMIT 50;
```

---

### 📊 Database Information

**CMD/pgAdmin:**
```sql
-- Database size
SELECT 
    pg_database.datname AS database_name,
    pg_size_pretty(pg_database_size(pg_database.datname)) AS size
FROM pg_database
ORDER BY pg_database_size(pg_database.datname) DESC;

-- Current database size
SELECT pg_size_pretty(pg_database_size(current_database()));
```

**Output:**
```
 database_name |  size   
---------------+---------
 company       | 8945 kB
 postgres      | 8897 kB
```

---

## 📊 Schema Operations

> **Schemas** are like folders within a database. Default schema is `public`.

### ➕ Create Schema

**CMD/pgAdmin:**
```sql
-- Create schema
CREATE SCHEMA sales;

-- With authorization
CREATE SCHEMA sales AUTHORIZATION postgres;

-- Create if not exists
CREATE SCHEMA IF NOT EXISTS sales;
```

**pgAdmin:**
1. Expand Database → Right-click **Schemas** → Create → Schema
2. Name: `sales`
3. Click **Save**

---

### 👀 List Schemas

**CMD (psql):**
```sql
-- Meta command
\dn

-- SQL query
SELECT schema_name FROM information_schema.schemata;
```

**pgAdmin:**
- Expand database → **Schemas** folder

---

### 🎯 Set Search Path

```sql
-- Set current schema
SET search_path TO sales, public;

-- Show current search path
SHOW search_path;

-- Set permanent default for user
ALTER USER postgres SET search_path TO sales, public;
```

---

### ❌ Drop Schema

```sql
-- Drop empty schema
DROP SCHEMA sales;

-- Drop schema and all objects
DROP SCHEMA sales CASCADE;

-- Drop if exists
DROP SCHEMA IF EXISTS sales CASCADE;
```

---

## 🏗️ Table Operations

### ➕ Create Table

**Basic Table:**
```sql
CREATE TABLE employees (
    id INTEGER,
    name VARCHAR(100),
    email VARCHAR(100),
    salary DECIMAL(10, 2),
    hire_date DATE
);
```

**Table with Constraints** ⭐ (Recommended):
```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    salary DECIMAL(10, 2) DEFAULT 50000 CHECK (salary >= 0),
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE,
    department_id INTEGER,
    manager_id INTEGER,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**pgAdmin:**
1. Expand Database → Schemas → public → Right-click **Tables** → Create → Table
2. **General Tab:** Name: `employees`
3. **Columns Tab:** Click **+** to add columns
4. **Constraints Tab:** Add constraints
5. Click **Save**

---

### 👀 Show Tables

**CMD (psql):**
```sql
-- Meta command (current schema)
\dt

-- All schemas
\dt *.*

-- Specific schema
\dt sales.*

-- SQL query
SELECT tablename FROM pg_tables WHERE schemaname = 'public';
```

**pgAdmin:**
- Expand Schemas → public → **Tables**

---

### 🔍 Describe Table

**CMD (psql):**
```sql
-- Meta command (detailed)
\d employees

-- Just structure
\d+ employees

-- SQL query
SELECT 
    column_name, 
    data_type, 
    character_maximum_length,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'employees';
```

**pgAdmin:**
- Right-click table → **Properties**
- Or expand table → **Columns**

**Output:**
```
                Table "public.employees"
    Column     |          Type          | Nullable |      Default      
---------------+------------------------+----------+-------------------
 id            | integer                | not null | nextval('...')
 first_name    | character varying(50)  | not null | 
 email         | character varying(100) | not null | 
 salary        | numeric(10,2)          |          | 50000
```

---

### 🔧 Alter Table

**Add Column:**
```sql
ALTER TABLE employees ADD COLUMN phone VARCHAR(20);

-- With constraint
ALTER TABLE employees 
ADD COLUMN birth_date DATE CHECK (birth_date > '1900-01-01');
```

**Modify Column:**
```sql
-- Change data type
ALTER TABLE employees ALTER COLUMN name TYPE VARCHAR(150);

-- Set NOT NULL
ALTER TABLE employees ALTER COLUMN email SET NOT NULL;

-- Remove NOT NULL
ALTER TABLE employees ALTER COLUMN phone DROP NOT NULL;

-- Set default
ALTER TABLE employees ALTER COLUMN salary SET DEFAULT 55000;

-- Remove default
ALTER TABLE employees ALTER COLUMN salary DROP DEFAULT;
```

**Rename Column:**
```sql
ALTER TABLE employees RENAME COLUMN name TO full_name;
```

**Drop Column:**
```sql
ALTER TABLE employees DROP COLUMN phone;

-- Drop if exists
ALTER TABLE employees DROP COLUMN IF EXISTS phone;
```

**Rename Table:**
```sql
ALTER TABLE employees RENAME TO staff;
```

**Change Schema:**
```sql
ALTER TABLE employees SET SCHEMA sales;
```

**pgAdmin:**
1. Right-click table → **Properties**
2. Modify in respective tabs
3. Click **Save**

---

### ❌ Drop Table

```sql
-- Drop table
DROP TABLE employees;

-- Drop if exists
DROP TABLE IF EXISTS employees;

-- Drop multiple tables
DROP TABLE employees, departments, projects;

-- Drop with all dependent objects
DROP TABLE employees CASCADE;
```

---

### 🧹 Truncate Table

```sql
-- Remove all data (faster than DELETE)
TRUNCATE TABLE employees;

-- Reset sequences
TRUNCATE TABLE employees RESTART IDENTITY;

-- Truncate with dependent tables
TRUNCATE TABLE employees CASCADE;
```

---

## 🔤 Data Types

### 🔢 Numeric Types

| Type | Size | Range | Use Case |
|------|------|-------|----------|
| `SMALLINT` | 2 bytes | -32,768 to 32,767 | Small numbers |
| `INTEGER` or `INT` | 4 bytes | -2 billion to 2 billion | IDs, counts |
| `BIGINT` | 8 bytes | Very large | Large IDs |
| `SERIAL` | 4 bytes | Auto-increment | Primary keys |
| `BIGSERIAL` | 8 bytes | Auto-increment large | Large primary keys |
| `DECIMAL(p,s)` | Variable | Exact | Money, prices |
| `NUMERIC(p,s)` | Variable | Exact | Same as DECIMAL |
| `REAL` | 4 bytes | 6 decimal digits | Measurements |
| `DOUBLE PRECISION` | 8 bytes | 15 decimal digits | Scientific |

**Example:**
```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    sku VARCHAR(50) UNIQUE,
    price NUMERIC(10, 2),  -- 💰 For money (exact)
    weight REAL,           -- ⚖️ For measurements
    stock INTEGER,         -- 📦 For counts
    views BIGINT          -- 👁️ For large counters
);
```

---

### 🔤 Character Types

| Type | Description | Max Size | Use Case |
|------|-------------|----------|----------|
| `CHAR(n)` | Fixed length | n chars | Fixed codes |
| `VARCHAR(n)` | Variable length | n chars | Names, text |
| `TEXT` | Unlimited | ~1 GB | Long content |

**Example:**
```sql
CREATE TABLE articles (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,      -- 📰 Headlines
    slug VARCHAR(200) UNIQUE,         -- 🔗 URLs
    content TEXT,                     -- 📄 Article body
    status CHAR(1) DEFAULT 'D'        -- D=Draft, P=Published
);
```

---

### 📅 Date/Time Types

| Type | Storage | Description | Example |
|------|---------|-------------|---------|
| `DATE` | 4 bytes | Date only | 2024-01-15 |
| `TIME` | 8 bytes | Time only | 14:30:00 |
| `TIMESTAMP` | 8 bytes | Date + time | 2024-01-15 14:30:00 |
| `TIMESTAMPTZ` | 8 bytes | Timestamp with timezone | 2024-01-15 14:30:00+05:30 |
| `INTERVAL` | 16 bytes | Time interval | 1 year 2 months |

**Example:**
```sql
CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    event_name VARCHAR(100),
    event_date DATE,
    event_time TIME,
    start_datetime TIMESTAMP,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    duration INTERVAL
);

-- Insert with interval
INSERT INTO events (event_name, event_date, duration)
VALUES ('Conference', '2024-06-15', INTERVAL '3 days');
```

---

### ✅ Boolean Type

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50),
    is_active BOOLEAN DEFAULT true,
    is_verified BOOLEAN DEFAULT false
);

-- Insert boolean values
INSERT INTO users (username, is_active) 
VALUES ('john', true);

-- Query boolean
SELECT * FROM users WHERE is_active = true;
-- or
SELECT * FROM users WHERE is_active;
```

---

### 🎨 PostgreSQL-Specific Types

**JSON/JSONB:**
```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    attributes JSONB  -- JSONB is better (indexed, faster)
);

-- Insert JSON
INSERT INTO products (name, attributes) VALUES
('Laptop', '{"brand": "Dell", "ram": 16, "storage": 512}');

-- Query JSON
SELECT attributes->>'brand' AS brand FROM products;
SELECT * FROM products WHERE attributes->>'ram' = '16';
```

**ARRAY:**
```sql
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200),
    tags TEXT[]  -- Array of text
);

-- Insert array
INSERT INTO posts (title, tags) VALUES
('PostgreSQL Guide', ARRAY['database', 'postgresql', 'tutorial']);

-- Query array
SELECT * FROM posts WHERE 'postgresql' = ANY(tags);
```

**UUID:**
```sql
CREATE TABLE sessions (
    session_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**ENUM:**
```sql
-- Create enum type
CREATE TYPE status_enum AS ENUM ('draft', 'published', 'archived');

CREATE TABLE articles (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200),
    status status_enum DEFAULT 'draft'
);
```

---

## ✏️ CRUD Operations

### ➕ INSERT - Create Data

**Single Row:**
```sql
INSERT INTO employees (first_name, last_name, email, salary, hire_date)
VALUES ('John', 'Doe', 'john@example.com', 60000, '2024-01-15');
```

**Multiple Rows** ⭐ (Efficient):
```sql
INSERT INTO employees (first_name, last_name, email, salary, hire_date)
VALUES 
    ('Jane', 'Smith', 'jane@example.com', 65000, '2024-02-01'),
    ('Bob', 'Johnson', 'bob@example.com', 55000, '2024-02-15'),
    ('Alice', 'Brown', 'alice@example.com', 70000, '2024-03-01');
```

**Return Inserted Data** (PostgreSQL Feature):
```sql
INSERT INTO employees (first_name, last_name, email, salary)
VALUES ('Mike', 'Wilson', 'mike@example.com', 58000)
RETURNING id, first_name, email, created_at;
```

**Insert from SELECT:**
```sql
INSERT INTO employees_backup 
SELECT * FROM employees WHERE salary > 60000;
```

**Insert with ON CONFLICT** (UPSERT):
```sql
-- Update if exists, insert if not
INSERT INTO employees (id, first_name, email, salary)
VALUES (1, 'John', 'john@example.com', 65000)
ON CONFLICT (id) 
DO UPDATE SET salary = EXCLUDED.salary;

-- Do nothing if conflict
INSERT INTO employees (email, first_name)
VALUES ('john@example.com', 'John')
ON CONFLICT (email) DO NOTHING;
```

**pgAdmin:**
1. Right-click table → **View/Edit Data** → **All Rows**
2. Click **+** (Add Row) button
3. Fill in data
4. Click **Save** (F6)

---

### 🔍 SELECT - Read Data

**Select All:**
```sql
SELECT * FROM employees;
```

**Select Specific Columns** ⭐ (Best Practice):
```sql
SELECT first_name, last_name, email, salary FROM employees;
```

**With Aliases:**
```sql
SELECT 
    first_name AS "First Name",
    last_name AS "Last Name",
    salary AS "Monthly Salary",
    salary * 12 AS "Annual Salary"
FROM employees;
```

**DISTINCT:**
```sql
SELECT DISTINCT department_id FROM employees;

-- Count distinct
SELECT COUNT(DISTINCT department_id) FROM employees;
```

**With Expressions:**
```sql
SELECT 
    first_name || ' ' || last_name AS full_name,  -- String concatenation
    salary * 1.10 AS salary_after_raise,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) AS years_employed
FROM employees;
```

---

### 🔄 UPDATE - Modify Data

**Single Column:**
```sql
UPDATE employees 
SET salary = 70000 
WHERE id = 1;
```

**Multiple Columns:**
```sql
UPDATE employees 
SET 
    salary = 75000,
    department_id = 2,
    updated_at = CURRENT_TIMESTAMP
WHERE id = 1;
```

**With Calculation:**
```sql
-- Give 10% raise to department 1
UPDATE employees 
SET salary = salary * 1.10 
WHERE department_id = 1;
```

**Update with JOIN:**
```sql
UPDATE employees e
SET salary = e.salary * 1.05
FROM departments d
WHERE e.department_id = d.id AND d.name = 'Sales';
```

**Return Updated Data:**
```sql
UPDATE employees 
SET salary = salary * 1.15 
WHERE department_id = 2
RETURNING id, first_name, salary;
```

> **⚠️ Warning:** Always use `WHERE` clause!

**pgAdmin:**
1. Right-click table → **View/Edit Data** → **All Rows**
2. Edit cells directly
3. Press **F6** to save

---

### ❌ DELETE - Remove Data

**Delete Specific Rows:**
```sql
DELETE FROM employees WHERE id = 1;
```

**Delete with Condition:**
```sql
DELETE FROM employees WHERE salary < 50000;
```

**Delete with JOIN:**
```sql
DELETE FROM employees e
USING departments d
WHERE e.department_id = d.id AND d.name = 'Closed Department';
```

**Return Deleted Data:**
```sql
DELETE FROM employees 
WHERE hire_date < '2020-01-01'
RETURNING *;
```

> **⚠️ Danger:** `DELETE FROM employees;` deletes ALL rows!

---

## 🔍 Querying Data

### 🎯 WHERE Clause

**Comparison Operators:**
```sql
-- Equal
SELECT * FROM employees WHERE salary = 60000;

-- Not equal
SELECT * FROM employees WHERE salary != 50000;
-- or
SELECT * FROM employees WHERE salary <> 50000;

-- Greater than, Less than
SELECT * FROM employees WHERE salary > 60000;
SELECT * FROM employees WHERE salary <= 70000;

-- Between
SELECT * FROM employees WHERE salary BETWEEN 50000 AND 70000;

-- IN
SELECT * FROM employees WHERE department_id IN (1, 2, 3);

-- NOT IN
SELECT * FROM employees WHERE department_id NOT IN (4, 5);
```

---

**Logical Operators:**
```sql
-- AND
SELECT * FROM employees 
WHERE salary > 60000 AND department_id = 1;

-- OR
SELECT * FROM employees 
WHERE department_id = 1 OR department_id = 2;

-- NOT
SELECT * FROM employees 
WHERE NOT (department_id = 1);
```

---

**Pattern Matching (LIKE/ILIKE):**

| Pattern | Description | Example Matches |
|---------|-------------|-----------------|
| `'John%'` | Starts with John | John, Johnny, Johnson |
| `'%son'` | Ends with son | Johnson, Wilson, Anderson |
| `'%oh%'` | Contains oh | John, Mahoney |
| `'_oh%'` | 2nd & 3rd chars are 'oh' | John, Mohan |

```sql
-- LIKE (case-sensitive)
SELECT * FROM employees WHERE first_name LIKE 'J%';

-- ILIKE (case-insensitive) - PostgreSQL specific
SELECT * FROM employees WHERE first_name ILIKE 'j%';

-- Ends with
SELECT * FROM employees WHERE email LIKE '%@gmail.com';

-- Contains
SELECT * FROM employees WHERE first_name LIKE '%oh%';

-- NOT LIKE
SELECT * FROM employees WHERE email NOT LIKE '%@company.com';
```

---

**NULL Handling:**
```sql
-- IS NULL
SELECT * FROM employees WHERE department_id IS NULL;

-- IS NOT NULL
SELECT * FROM employees WHERE department_id IS NOT NULL;

-- COALESCE (return first non-null)
SELECT 
    first_name,
    COALESCE(phone, 'No phone') AS contact_phone
FROM employees;
```

---

**Regular Expressions:**
```sql
-- POSIX regex (~ operator)
SELECT * FROM employees WHERE email ~ '@gmail\.com$';

-- Case-insensitive regex
SELECT * FROM employees WHERE first_name ~* '^j';

-- NOT matching
SELECT * FROM employees WHERE email !~ '@company\.com$';
```

---

### 📊 ORDER BY

**Ascending (Default):**
```sql
SELECT * FROM employees ORDER BY salary;
-- or
SELECT * FROM employees ORDER BY salary ASC;
```

**Descending:**
```sql
SELECT * FROM employees ORDER BY salary DESC;
```

**Multiple Columns:**
```sql
SELECT * FROM employees 
ORDER BY department_id ASC, salary DESC;
```

**NULLS Handling:**
```sql
-- NULLS FIRST (default for DESC)
SELECT * FROM employees ORDER BY department_id NULLS FIRST;

-- NULLS LAST (default for ASC)
SELECT * FROM employees ORDER BY department_id NULLS LAST;
```

**Order by Expression:**
```sql
SELECT first_name, salary, salary * 12 AS annual 
FROM employees 
ORDER BY annual DESC;
```

---

### 📄 LIMIT and OFFSET

**Limit Results:**
```sql
-- Get first 10 rows
SELECT * FROM employees LIMIT 10;
```

**Pagination:**
```sql
-- Page 1 (rows 1-10)
SELECT * FROM employees ORDER BY id LIMIT 10 OFFSET 0;

-- Page 2 (rows 11-20)
SELECT * FROM employees ORDER BY id LIMIT 10 OFFSET 10;

-- Page 3 (rows 21-30)
SELECT * FROM employees ORDER BY id LIMIT 10 OFFSET 20;
```

**Top N:**
```sql
-- Top 5 highest paid employees
SELECT * FROM employees 
ORDER BY salary DESC 
LIMIT 5;
```

---

## 🎯 Filtering and Sorting

### 🔍 Advanced Filtering

**Complex Conditions:**
```sql
SELECT * FROM employees 
WHERE (department_id = 1 OR department_id = 2) 
  AND salary > 60000
  AND hire_date > '2020-01-01';
```

**Date Filtering:**
```sql
-- Exact date
SELECT * FROM employees WHERE hire_date = '2024-01-15';

-- Date range
SELECT * FROM employees 
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';

-- Current year
SELECT * FROM employees 
WHERE EXTRACT(YEAR FROM hire_date) = EXTRACT(YEAR FROM CURRENT_DATE);

-- Last 30 days
SELECT * FROM employees 
WHERE hire_date >= CURRENT_DATE - INTERVAL '30 days';

-- This month
SELECT * FROM employees 
WHERE DATE_TRUNC('month', hire_date) = DATE_TRUNC('month', CURRENT_DATE);
```

---

### 🔀 CASE Statement

**Simple CASE:**
```sql
SELECT 
    first_name,
    salary,
    CASE 
        WHEN salary < 50000 THEN '💰 Low'
        WHEN salary BETWEEN 50000 AND 70000 THEN '💵 Medium'
        WHEN salary > 70000 THEN '💎 High'
        ELSE '❓ Unknown'
    END AS salary_grade
FROM employees;
```

**Output:**
```
 first_name | salary  | salary_grade 
------------+---------+--------------
 John       | 60000.00| 💵 Medium
 Jane       | 75000.00| 💎 High
 Bob        | 45000.00| 💰 Low
```

**CASE in WHERE:**
```sql
SELECT * FROM employees
WHERE 
    CASE 
        WHEN department_id = 1 THEN salary > 50000
        WHEN department_id = 2 THEN salary > 60000
        ELSE salary > 40000
    END;
```

**CASE in ORDER BY:**
```sql
SELECT * FROM employees
ORDER BY 
    CASE 
        WHEN department_id = 1 THEN 1
        WHEN department_id = 2 THEN 2
        ELSE 3
    END,
    salary DESC;
```

---

## 🔗 Joins

> **Joins** combine rows from multiple tables.

### 🎯 INNER JOIN

**Returns only matching rows:**
```sql
SELECT 
    e.first_name,
    e.last_name,
    e.salary,
    d.name AS department
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;
```

**Multiple Joins:**
```sql
SELECT 
    e.first_name,
    d.name AS department,
    p.name AS project,
    l.city AS location
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
INNER JOIN projects p ON e.project_id = p.id
INNER JOIN locations l ON d.location_id = l.id;
```

**With WHERE:**
```sql
SELECT e.first_name, d.name AS department
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
WHERE e.salary > 60000 AND d.budget > 100000;
```

---

### ⬅️ LEFT JOIN (LEFT OUTER JOIN)

**Returns all rows from left table + matching from right:**
```sql
SELECT 
    e.first_name,
    e.last_name,
    d.name AS department
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;
```

**Find Employees Without Department:**
```sql
SELECT e.first_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id
WHERE d.id IS NULL;
```

---

### ➡️ RIGHT JOIN (RIGHT OUTER JOIN)

**Returns all rows from right table + matching from left:**
```sql
SELECT 
    e.first_name,
    d.name AS department
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;
```

**Find Departments Without Employees:**
```sql
SELECT d.name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id
WHERE e.id IS NULL;
```

---

### 🔄 FULL OUTER JOIN

**Returns all rows from both tables:**
```sql
SELECT 
    e.first_name,
    d.name AS department
FROM employees e
FULL OUTER JOIN departments d ON e.department_id = d.id;
```

**Find Unmatched Records:**
```sql
-- Employees without departments OR departments without employees
SELECT 
    e.first_name,
    d.name AS department
FROM employees e
FULL OUTER JOIN departments d ON e.department_id = d.id
WHERE e.id IS NULL OR d.id IS NULL;
```

---

### ✖️ CROSS JOIN

**Cartesian product (every combination):**
```sql
SELECT 
    e.first_name,
    d.name AS department
FROM employees e
CROSS JOIN departments d;
```

---

### 🔄 SELF JOIN

**Join table to itself:**
```sql
-- Find employees and their managers
SELECT 
    e.first_name AS employee,
    m.first_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;
```

---

### 🔗 NATURAL JOIN

**Automatic join on same column names:**
```sql
-- Joins on all columns with same name
SELECT * FROM employees NATURAL JOIN departments;
```

> **⚠️ Use with caution:** Can cause unexpected results if multiple columns match.

---

### 🎯 USING Clause

**Simplified ON when column names match:**
```sql
-- Instead of: ON e.department_id = d.department_id
SELECT * FROM employees e
JOIN departments d USING (department_id);
```

---

## 📈 Aggregate Functions

### 🧮 Basic Aggregates

**COUNT:**
```sql
-- Count all rows
SELECT COUNT(*) FROM employees;

-- Count non-null values
SELECT COUNT(department_id) FROM employees;

-- Count distinct
SELECT COUNT(DISTINCT department_id) FROM employees;
```

**SUM:**
```sql
-- Total payroll
SELECT SUM(salary) AS total_payroll FROM employees;
```

**AVG (Average):**
```sql
-- Average salary
SELECT AVG(salary) AS average_salary FROM employees;

-- Rounded average
SELECT ROUND(AVG(salary), 2) AS average_salary FROM employees;
```

**MIN and MAX:**
```sql
SELECT 
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary
FROM employees;
```

**Combined** ⭐:
```sql
SELECT 
    COUNT(*) AS total_employees,
    ROUND(AVG(salary), 2) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    SUM(salary) AS total_payroll
FROM employees;
```

**Output:**
```
 total_employees | avg_salary | min_salary | max_salary | total_payroll 
-----------------+------------+------------+------------+---------------
 50              | 62500.00   | 45000.00   | 95000.00   | 3125000.00
```

---

### 🔤 String Functions

**Concatenation:**
```sql
-- PostgreSQL specific
SELECT first_name || ' ' || last_name AS full_name FROM employees;

-- SQL standard
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees;

-- With NULL handling
SELECT CONCAT_WS(' ', first_name, middle_name, last_name) AS full_name 
FROM employees;
```

**Case Conversion:**
```sql
SELECT 
    UPPER(first_name) AS uppercase,
    LOWER(email) AS lowercase,
    INITCAP(first_name) AS capitalized  -- First letter uppercase
FROM employees;
```

**String Manipulation:**
```sql
SELECT 
    LENGTH(first_name) AS name_length,
    SUBSTRING(first_name FROM 1 FOR 3) AS first_3_chars,
    POSITION('@' IN email) AS at_position,
    LEFT(first_name, 3) AS left_3,
    RIGHT(first_name, 3) AS right_3,
    TRIM(BOTH ' ' FROM '  text  ') AS trimmed,
    REPLACE(email, '@old.com', '@new.com') AS new_email
FROM employees;
```

**String Split:**
```sql
-- Split email into parts
SELECT 
    SPLIT_PART(email, '@', 1) AS username,
    SPLIT_PART(email, '@', 2) AS domain
FROM employees;
```

**Pattern Matching:**
```sql
SELECT 
    first_name,
    CASE 
        WHEN first_name ~ '^[A-M]' THEN 'A-M'
        ELSE 'N-Z'
    END AS name_group
FROM employees;
```

---

### 🔢 Math Functions

**Rounding:**
```sql
SELECT 
    salary,
    ROUND(salary) AS rounded,
    CEIL(salary) AS ceiling,
    FLOOR(salary) AS floor,
    TRUNC(salary, -3) AS truncated_thousands
FROM employees;
```

**Mathematical Operations:**
```sql
SELECT 
    ABS(-100) AS absolute_value,
    MOD(salary, 1000) AS remainder,
    POWER(2, 3) AS power_result,  -- 2^3 = 8
    SQRT(16) AS square_root,      -- 4
    PI() AS pi_value,
    RANDOM() AS random_number     -- 0 to 1
FROM employees;
```

**Generate Series:**
```sql
-- Generate numbers 1 to 10
SELECT * FROM generate_series(1, 10);

-- Generate dates
SELECT * FROM generate_series(
    '2024-01-01'::date,
    '2024-01-31'::date,
    '1 day'::interval
);
```

---

### 📅 Date/Time Functions

**Current Date/Time:**
```sql
SELECT 
    CURRENT_DATE AS today,
    CURRENT_TIME AS now_time,
    CURRENT_TIMESTAMP AS now_timestamp,
    NOW() AS now_full,
    LOCALTIMESTAMP AS local_time;
```

**Extract Parts:**
```sql
SELECT 
    EXTRACT(YEAR FROM hire_date) AS year,
    EXTRACT(MONTH FROM hire_date) AS month,
    EXTRACT(DAY FROM hire_date) AS day,
    EXTRACT(DOW FROM hire_date) AS day_of_week,  -- 0=Sunday
    EXTRACT(QUARTER FROM hire_date) AS quarter
FROM employees;
```

**Date Arithmetic:**
```sql
SELECT 
    hire_date,
    hire_date + INTERVAL '1 year' AS one_year_later,
    hire_date - INTERVAL '30 days' AS 30_days_ago,
    CURRENT_DATE - hire_date AS days_employed,
    AGE(CURRENT_DATE, hire_date) AS employment_duration
FROM employees;
```

**Date Difference:**
```sql
SELECT 
    first_name,
    hire_date,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) AS years_employed,
    DATE_PART('day', CURRENT_DATE - hire_date) AS days_employed
FROM employees;
```

**Date Formatting:**
```sql
SELECT 
    TO_CHAR(hire_date, 'YYYY-MM-DD') AS iso_format,
    TO_CHAR(hire_date, 'Month DD, YYYY') AS readable,
    TO_CHAR(hire_date, 'DD/MM/YYYY') AS european,
    TO_CHAR(CURRENT_TIMESTAMP, 'HH24:MI:SS') AS time_24hr
FROM employees;
```

**Date Truncation:**
```sql
SELECT 
    DATE_TRUNC('year', hire_date) AS year_start,
    DATE_TRUNC('month', hire_date) AS month_start,
    DATE_TRUNC('day', hire_date) AS day_start
FROM employees;
```

---

## 📦 Grouping and Having

### 📊 GROUP BY

**Single Column:**
```sql
-- Count employees per department
SELECT 
    department_id,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;
```

**Output:**
```
 department_id | employee_count 
---------------+----------------
 1             | 15
 2             | 20
 3             | 10
```

**Multiple Columns:**
```sql
SELECT 
    department_id,
    EXTRACT(YEAR FROM hire_date) AS hire_year,
    COUNT(*) AS hires
FROM employees
GROUP BY department_id, EXTRACT(YEAR FROM hire_date)
ORDER BY department_id, hire_year;
```

**With Aggregates** ⭐:
```sql
SELECT 
    department_id,
    COUNT(*) AS total_employees,
    ROUND(AVG(salary), 2) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    SUM(salary) AS total_payroll
FROM employees
GROUP BY department_id
ORDER BY avg_salary DESC;
```

---

### 🎯 HAVING Clause

> **WHERE** filters rows before grouping  
> **HAVING** filters groups after aggregation

**Filter Groups:**
```sql
-- Departments with average salary > 60000
SELECT 
    department_id,
    ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 60000;
```

**Multiple Conditions:**
```sql
SELECT 
    department_id,
    COUNT(*) AS emp_count,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5 AND AVG(salary) > 60000;
```

**Combined WHERE and HAVING:**
```sql
SELECT 
    department_id,
    AVG(salary) AS avg_salary
FROM employees
WHERE hire_date > '2023-01-01'     -- Filter BEFORE grouping
GROUP BY department_id
HAVING AVG(salary) > 60000;         -- Filter AFTER grouping
```

---

### 📈 ROLLUP and CUBE

**ROLLUP** - Hierarchical subtotals:
```sql
SELECT 
    department_id,
    EXTRACT(YEAR FROM hire_date) AS year,
    COUNT(*) AS hires
FROM employees
GROUP BY ROLLUP(department_id, EXTRACT(YEAR FROM hire_date))
ORDER BY department_id, year;
```

**CUBE** - All possible combinations:
```sql
SELECT 
    department_id,
    EXTRACT(YEAR FROM hire_date) AS year,
    COUNT(*) AS hires
FROM employees
GROUP BY CUBE(department_id, EXTRACT(YEAR FROM hire_date));
```

**GROUPING SETS** - Custom grouping:
```sql
SELECT 
    department_id,
    EXTRACT(YEAR FROM hire_date) AS year,
    COUNT(*) AS total
FROM employees
GROUP BY GROUPING SETS (
    (department_id),
    (EXTRACT(YEAR FROM hire_date)),
    ()  -- Grand total
);
```

---

## 🎭 Subqueries

> A **subquery** is a query inside another query.

### 🎯 Subquery in WHERE

**Scalar Subquery:**
```sql
-- Find employees earning more than average
SELECT first_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

**IN Operator:**
```sql
-- Find employees in Sales or Marketing
SELECT first_name, last_name
FROM employees
WHERE department_id IN (
    SELECT id FROM departments 
    WHERE name IN ('Sales', 'Marketing')
);
```

**ALL Operator:**
```sql
-- Earning more than ANYONE in department 1
SELECT first_name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary FROM employees WHERE department_id = 1
);
```

**ANY/SOME Operator:**
```sql
-- Earning more than SOMEONE in department 1
SELECT first_name, salary
FROM employees
WHERE salary > ANY (
    SELECT salary FROM employees WHERE department_id = 1
);
```

---

### 📊 Subquery in FROM

**Derived Table:**
```sql
SELECT 
    dept_salary.department_id,
    dept_salary.avg_salary
FROM (
    SELECT 
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_salary
WHERE dept_salary.avg_salary > 60000;
```

---

### 📋 Subquery in SELECT

**Correlated Subquery:**
```sql
SELECT 
    first_name,
    salary,
    (SELECT AVG(salary) FROM employees) AS company_avg,
    salary - (SELECT AVG(salary) FROM employees) AS diff_from_avg
FROM employees;
```

---

### 🔍 EXISTS

**Check if Subquery Returns Rows:**
```sql
-- Departments with employees
SELECT d.name
FROM departments d
WHERE EXISTS (
    SELECT 1 FROM employees e 
    WHERE e.department_id = d.id
);
```

**NOT EXISTS:**
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

### 🎯 Correlated Subquery

**Subquery References Outer Query:**
```sql
-- Employees earning more than department average
SELECT e1.first_name, e1.salary, e1.department_id
FROM employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);
```

---

## 🔒 Constraints

### 🔑 Primary Key

**Single Column:**
```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- Or explicitly
CREATE TABLE employees (
    id SERIAL,
    name VARCHAR(100),
    PRIMARY KEY (id)
);
```

**Composite Primary Key:**
```sql
CREATE TABLE order_items (
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    PRIMARY KEY (order_id, product_id)
);
```

**Add Primary Key Later:**
```sql
ALTER TABLE employees ADD PRIMARY KEY (id);

-- Named constraint
ALTER TABLE employees 
ADD CONSTRAINT pk_employees PRIMARY KEY (id);
```

---

### 🔗 Foreign Key

**Basic Foreign Key:**
```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    department_id INTEGER REFERENCES departments(id)
);

-- Or explicitly
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    department_id INTEGER,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);
```

**With Actions:**
```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    department_id INTEGER,
    FOREIGN KEY (department_id) 
        REFERENCES departments(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
```

**Foreign Key Actions:**

| Action | Description |
|--------|-------------|
| `CASCADE` | Delete/update child rows |
| `SET NULL` | Set foreign key to NULL |
| `SET DEFAULT` | Set foreign key to default value |
| `RESTRICT` | Prevent deletion (default) |
| `NO ACTION` | Same as RESTRICT |

**Add Foreign Key Later:**
```sql
ALTER TABLE employees
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id) REFERENCES departments(id)
ON DELETE SET NULL;
```

---

### ✨ UNIQUE Constraint

**Single Column:**
```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(100) UNIQUE
);
```

**Multiple Columns:**
```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INTEGER,
    UNIQUE (first_name, last_name, department_id)
);
```

**Add Later:**
```sql
ALTER TABLE users ADD UNIQUE (email);

-- Named constraint
ALTER TABLE users 
ADD CONSTRAINT uq_users_email UNIQUE (email);
```

---

### ❗ NOT NULL Constraint

**During Creation:**
```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);
```

**Add Later:**
```sql
ALTER TABLE employees 
ALTER COLUMN email SET NOT NULL;

-- Remove NOT NULL
ALTER TABLE employees 
ALTER COLUMN phone DROP NOT NULL;
```

---

### ✅ CHECK Constraint

**Simple Check:**
```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    age INTEGER CHECK (age >= 18),
    salary NUMERIC(10,2) CHECK (salary > 0)
);
```

**Named Check:**
```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    age INTEGER,
    salary NUMERIC(10,2),
    CONSTRAINT chk_age CHECK (age >= 18 AND age <= 65),
    CONSTRAINT chk_salary CHECK (salary BETWEEN 0 AND 1000000)
);
```

**Add Later:**
```sql
ALTER TABLE employees 
ADD CONSTRAINT chk_salary_positive 
CHECK (salary > 0);

-- Drop check
ALTER TABLE employees 
DROP CONSTRAINT chk_salary_positive;
```

---

### 🎨 DEFAULT Constraint

**During Creation:**
```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    salary NUMERIC(10,2) DEFAULT 50000,
    is_active BOOLEAN DEFAULT true
);
```

**Add Later:**
```sql
ALTER TABLE employees 
ALTER COLUMN status SET DEFAULT 'active';

-- Remove default
ALTER TABLE employees 
ALTER COLUMN status DROP DEFAULT;
```

---

### 🔍 View Constraints

**CMD (psql):**
```sql
-- Meta command
\d employees

-- SQL query
SELECT 
    constraint_name,
    constraint_type
FROM information_schema.table_constraints
WHERE table_name = 'employees';
```

**pgAdmin:**
- Expand table → **Constraints** folder

---

## ⚡ Indexes

> **Indexes** speed up queries but slow down writes.

### ➕ Create Index

**Single Column:**
```sql
CREATE INDEX idx_employees_email ON employees(email);
```

**Multiple Columns (Composite):**
```sql
CREATE INDEX idx_employees_name_dept 
ON employees(last_name, department_id);
```

**Unique Index:**
```sql
CREATE UNIQUE INDEX idx_employees_email_unique 
ON employees(email);
```

**Partial Index** (PostgreSQL Feature):
```sql
-- Index only active employees
CREATE INDEX idx_active_employees 
ON employees(last_name) 
WHERE is_active = true;
```

**Expression Index:**
```sql
-- Index on lowercase email
CREATE INDEX idx_email_lower 
ON employees(LOWER(email));
```

**pgAdmin:**
1. Expand table → Right-click **Indexes** → Create → Index
2. Fill in name and columns
3. Click **Save**

---

### 🎯 Index Types

**B-tree (Default):**
```sql
CREATE INDEX idx_salary ON employees(salary);
```

**Hash:**
```sql
CREATE INDEX idx_email_hash ON employees USING HASH(email);
```

**GiST (Generalized Search Tree):**
```sql
CREATE INDEX idx_location ON places USING GIST(location);
```

**GIN (Generalized Inverted Index) - For arrays/JSONB:**
```sql
CREATE INDEX idx_tags_gin ON posts USING GIN(tags);
CREATE INDEX idx_data_gin ON products USING GIN(attributes);
```

---

### 👀 Show Indexes

**CMD (psql):**
```sql
-- Meta command
\di

-- SQL query
SELECT 
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'employees';
```

**pgAdmin:**
- Expand table → **Indexes** folder

---

### ❌ Drop Index

```sql
DROP INDEX idx_employees_email;

-- Drop if exists
DROP INDEX IF EXISTS idx_employees_email;

-- Drop with dependencies
DROP INDEX idx_employees_email CASCADE;
```

---

### 🔍 Analyze Query Performance

**EXPLAIN:**
```sql
EXPLAIN SELECT * FROM employees WHERE email = 'john@example.com';
```

**EXPLAIN ANALYZE** (Actually runs the query):
```sql
EXPLAIN ANALYZE 
SELECT * FROM employees WHERE salary > 60000;
```

**Output:**
```
Seq Scan on employees  (cost=0.00..15.50 rows=5 width=100)
  Filter: (salary > 60000)
Planning Time: 0.123 ms
Execution Time: 0.456 ms
```

---

### 🎯 Index Maintenance

```sql
-- Rebuild index
REINDEX INDEX idx_employees_email;

-- Rebuild all indexes on table
REINDEX TABLE employees;

-- Update statistics
ANALYZE employees;

-- Vacuum and analyze
VACUUM ANALYZE employees;
```

---

## 👁️ Views

> A **view** is a saved query that acts like a virtual table.

### ➕ Create View

**Simple View:**
```sql
CREATE VIEW employee_details AS
SELECT 
    e.first_name,
    e.last_name,
    e.email,
    e.salary,
    d.name AS department
FROM employees e
JOIN departments d ON e.department_id = d.id;
```

**With Filtering:**
```sql
CREATE VIEW high_earners AS
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary > 70000;
```

**With Aggregation:**
```sql
CREATE VIEW department_stats AS
SELECT 
    d.name AS department,
    COUNT(e.id) AS employee_count,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    SUM(e.salary) AS total_payroll
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.id, d.name;
```

**pgAdmin:**
1. Expand database → Schemas → public → Right-click **Views**
2. Create → View
3. Name: `employee_details`
4. Code tab: Enter SELECT statement
5. Click **Save**

---

### 🔍 Use View

**Query Like a Table:**
```sql
SELECT * FROM employee_details;

SELECT * FROM high_earners WHERE department_id = 1;

SELECT department, avg_salary FROM department_stats 
ORDER BY avg_salary DESC;
```

---

### 🔧 Modify View

**Replace View:**
```sql
CREATE OR REPLACE VIEW employee_details AS
SELECT 
    e.first_name,
    e.last_name,
    e.email,
    e.salary,
    e.hire_date,
    d.name AS department
FROM employees e
JOIN departments d ON e.department_id = d.id;
```

**Alter View:**
```sql
-- Rename view
ALTER VIEW employee_details RENAME TO emp_details;

-- Change owner
ALTER VIEW emp_details OWNER TO new_user;

-- Set schema
ALTER VIEW emp_details SET SCHEMA sales;
```

---

### 🔄 Materialized Views

**Create Materialized View** (Stores actual data):
```sql
CREATE MATERIALIZED VIEW employee_summary AS
SELECT 
    department_id,
    COUNT(*) AS emp_count,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

-- With data
CREATE MATERIALIZED VIEW employee_summary AS
SELECT * FROM employees
WITH DATA;

-- Without data (populated later)
CREATE MATERIALIZED VIEW employee_summary AS
SELECT * FROM employees
WITH NO DATA;
```

**Refresh Materialized View:**
```sql
-- Refresh (blocks reads during refresh)
REFRESH MATERIALIZED VIEW employee_summary;

-- Concurrent refresh (doesn't block reads)
REFRESH MATERIALIZED VIEW CONCURRENTLY employee_summary;
```

---

### ❌ Drop View

```sql
DROP VIEW employee_details;

-- Drop if exists
DROP VIEW IF EXISTS employee_details;

-- Drop with dependencies
DROP VIEW employee_details CASCADE;

-- Drop materialized view
DROP MATERIALIZED VIEW employee_summary;
```

---

### 👀 Show Views

**CMD (psql):**
```sql
-- Meta command
\dv

-- SQL query
SELECT 
    table_name,
    view_definition
FROM information_schema.views
WHERE table_schema = 'public';
```

**pgAdmin:**
- Expand Schemas → public → **Views** folder

---

## ⚙️ Functions

> **Functions** are reusable blocks of code.

### ➕ Create Function

**Simple Function:**
```sql
CREATE FUNCTION get_employee_count()
RETURNS INTEGER AS $
BEGIN
    RETURN (SELECT COUNT(*) FROM employees);
END;
$ LANGUAGE plpgsql;

-- Call function
SELECT get_employee_count();
```

**Function with Parameters:**
```sql
CREATE FUNCTION get_employee_by_id(emp_id INTEGER)
RETURNS TABLE(first_name VARCHAR, last_name VARCHAR, salary NUMERIC) AS $
BEGIN
    RETURN QUERY
    SELECT e.first_name, e.last_name, e.salary
    FROM employees e
    WHERE e.id = emp_id;
END;
$ LANGUAGE plpgsql;

-- Call function
SELECT * FROM get_employee_by_id(1);
```

**Function with Multiple Parameters:**
```sql
CREATE FUNCTION calculate_bonus(
    base_salary NUMERIC,
    performance_rating INTEGER
)
RETURNS NUMERIC AS $
DECLARE
    bonus NUMERIC;
BEGIN
    bonus := CASE
        WHEN performance_rating >= 9 THEN base_salary * 0.20
        WHEN performance_rating >= 7 THEN base_salary * 0.10
        WHEN performance_rating >= 5 THEN base_salary * 0.05
        ELSE 0
    END;
    RETURN bonus;
END;
$ LANGUAGE plpgsql;

-- Call function
SELECT calculate_bonus(50000, 8);
```

**Function that Modifies Data:**
```sql
CREATE FUNCTION increase_salary(
    emp_id INTEGER,
    percentage NUMERIC
)
RETURNS VOID AS $
BEGIN
    UPDATE employees
    SET salary = salary * (1 + percentage / 100)
    WHERE id = emp_id;
END;
$ LANGUAGE plpgsql;

-- Call function
SELECT increase_salary(1, 10);  -- 10% raise
```

**pgAdmin:**
1. Expand database → Schemas → public → Right-click **Functions**
2. Create → Function
3. Fill in name, parameters, return type, and code
4. Click **Save**

---

### 👀 Show Functions

**CMD (psql):**
```sql
-- Meta command
\df

-- SQL query
SELECT routine_name, routine_type
FROM information_schema.routines
WHERE routine_schema = 'public';
```

---

### ❌ Drop Function

```sql
DROP FUNCTION get_employee_count();

-- With parameters
DROP FUNCTION calculate_bonus(NUMERIC, INTEGER);

-- Drop if exists
DROP FUNCTION IF EXISTS get_employee_count();
```

---

## 🎬 Triggers

> **Triggers** automatically execute functions when certain events occur.

### ➕ Create Trigger

**BEFORE INSERT Trigger:**
```sql
-- Create function first
CREATE FUNCTION set_created_timestamp()
RETURNS TRIGGER AS $
BEGIN
    NEW.created_at := CURRENT_TIMESTAMP;
    NEW.updated_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$ LANGUAGE plpgsql;

-- Create trigger
CREATE TRIGGER trg_before_insert_employee
BEFORE INSERT ON employees
FOR EACH ROW
EXECUTE FUNCTION set_created_timestamp();
```

**AFTER INSERT Trigger (Audit Log):**
```sql
-- Create audit table
CREATE TABLE employee_audit (
    audit_id SERIAL PRIMARY KEY,
    employee_id INTEGER,
    action VARCHAR(10),
    action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create trigger function
CREATE FUNCTION log_employee_insert()
RETURNS TRIGGER AS $
BEGIN
    INSERT INTO employee_audit (employee_id, action)
    VALUES (NEW.id, 'INSERT');
    RETURN NEW;
END;
$ LANGUAGE plpgsql;

-- Create trigger
CREATE TRIGGER trg_after_insert_employee
AFTER INSERT ON employees
FOR EACH ROW
EXECUTE FUNCTION log_employee_insert();
```

**BEFORE UPDATE Trigger (Validation):**
```sql
CREATE FUNCTION check_salary_update()
RETURNS TRIGGER AS $
BEGIN
    IF NEW.salary < 0 THEN
        RAISE EXCEPTION 'Salary cannot be negative';
    END IF;
    
    IF NEW.salary < OLD.salary * 0.5 THEN
        RAISE EXCEPTION 'Salary cannot be decreased by more than 50%%';
    END IF;
    
    NEW.updated_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$ LANGUAGE plpgsql;

CREATE TRIGGER trg_before_update_employee
BEFORE UPDATE ON employees
FOR EACH ROW
EXECUTE FUNCTION check_salary_update();
```

**AFTER UPDATE Trigger (History Tracking):**
```sql
-- Create history table
CREATE TABLE salary_history (
    history_id SERIAL PRIMARY KEY,
    employee_id INTEGER,
    old_salary NUMERIC(10,2),
    new_salary NUMERIC(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create trigger function
CREATE FUNCTION track_salary_changes()
RETURNS TRIGGER AS $
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_history (employee_id, old_salary, new_salary)
        VALUES (NEW.id, OLD.salary, NEW.salary);
    END IF;
    RETURN NEW;
END;
$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_update_salary
AFTER UPDATE ON employees
FOR EACH ROW
WHEN (OLD.salary IS DISTINCT FROM NEW.salary)
EXECUTE FUNCTION track_salary_changes();
```

**BEFORE DELETE Trigger:**
```sql
CREATE FUNCTION archive_deleted_employee()
RETURNS TRIGGER AS $
BEGIN
    INSERT INTO deleted_employees SELECT OLD.*;
    RETURN OLD;
END;
$ LANGUAGE plpgsql;

CREATE TRIGGER trg_before_delete_employee
BEFORE DELETE ON employees
FOR EACH ROW
EXECUTE FUNCTION archive_deleted_employee();
```

**pgAdmin:**
1. Expand table → Right-click **Triggers** → Create → Trigger
2. Fill in name, timing (BEFORE/AFTER), events (INSERT/UPDATE/DELETE)
3. Select trigger function
4. Click **Save**

---

### 👀 Show Triggers

**CMD (psql):**
```sql
-- Meta command
\dy

-- SQL query
SELECT 
    trigger_name,
    event_manipulation,
    event_object_table
FROM information_schema.triggers
WHERE event_object_schema = 'public';
```

**pgAdmin:**
- Expand table → **Triggers** folder

---

### ❌ Drop Trigger

**CMD/pgAdmin:**
```sql
DROP TRIGGER trg_before_insert_employee ON employees;

-- Drop if exists
DROP TRIGGER IF EXISTS trg_before_insert_employee ON employees;
```

---

### 🔧 Enable/Disable Trigger

**CMD/pgAdmin:**
```sql
-- Disable trigger
ALTER TABLE employees DISABLE TRIGGER trg_before_insert_employee;

-- Enable trigger
ALTER TABLE employees ENABLE TRIGGER trg_before_insert_employee;

-- Disable all triggers on table
ALTER TABLE employees DISABLE TRIGGER ALL;

-- Enable all triggers
ALTER TABLE employees ENABLE TRIGGER ALL;
```

---

## 💰 Transactions

> **Transactions** ensure data integrity by grouping operations.

### 🔄 Basic Transaction

**CMD/pgAdmin:**
```sql
-- Start transaction
BEGIN;
-- or
START TRANSACTION;

-- Execute queries
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;

-- Save changes
COMMIT;

-- OR undo changes
-- ROLLBACK;
```

**Example with Error Handling:**
```sql
BEGIN;

-- Transfer money
UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;

-- Check if everything is OK, then commit
SELECT balance FROM accounts WHERE account_id = 1;

-- If balance is negative, rollback
-- Otherwise commit
COMMIT;
```

---

### 📌 Savepoints

**CMD/pgAdmin:**
```sql
BEGIN;

UPDATE accounts SET balance = balance - 100 WHERE id = 1;

-- Create savepoint
SAVEPOINT sp1;

UPDATE accounts SET balance = balance + 100 WHERE id = 2;

-- Another savepoint
SAVEPOINT sp2;

UPDATE accounts SET balance = balance - 50 WHERE id = 3;

-- Rollback to savepoint (undo last UPDATE)
ROLLBACK TO SAVEPOINT sp2;

-- Release savepoint
RELEASE SAVEPOINT sp1;

COMMIT;
```

---

### 🔒 Isolation Levels

**CMD/pgAdmin:**
```sql
-- Show current isolation level
SHOW transaction_isolation;

-- Set for current session
SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Set for next transaction only
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

**Isolation Levels:**

| Level | Dirty Read | Non-repeatable Read | Phantom Read |
|-------|------------|---------------------|--------------|
| `READ UNCOMMITTED` | ✅ Possible | ✅ Possible | ✅ Possible |
| `READ COMMITTED` | ❌ | ✅ Possible | ✅ Possible |
| `REPEATABLE READ` | ❌ | ❌ | ✅ Possible |
| `SERIALIZABLE` | ❌ | ❌ | ❌ |

**Example:**
```sql
-- Transaction 1
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT * FROM accounts WHERE id = 1 FOR UPDATE;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
COMMIT;
```

---

### 🔐 Row Locking

**CMD/pgAdmin:**
```sql
BEGIN;

-- Lock rows for update (exclusive lock)
SELECT * FROM accounts WHERE id = 1 FOR UPDATE;

-- Lock rows for reading (shared lock)
SELECT * FROM accounts WHERE id = 1 FOR SHARE;

-- Skip locked rows
SELECT * FROM accounts WHERE id = 1 FOR UPDATE SKIP LOCKED;

-- Wait for lock or throw error
SELECT * FROM accounts WHERE id = 1 FOR UPDATE NOWAIT;

COMMIT;
```

---

### ✅ Transaction Best Practices

**CMD/pgAdmin:**
```sql
DO $
DECLARE
    current_balance NUMERIC;
BEGIN
    -- Start transaction implicitly
    
    -- Lock row and get balance
    SELECT balance INTO current_balance
    FROM accounts
    WHERE account_id = 1
    FOR UPDATE;
    
    -- Check condition
    IF current_balance >= 100 THEN
        UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
        UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;
        RAISE NOTICE 'Transfer successful';
    ELSE
        RAISE EXCEPTION 'Insufficient balance';
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Transaction failed: %', SQLERRM;
        -- Automatic rollback on exception
END $;
```

---

## 👥 User Management & Roles

### ➕ Create User/Role

**CMD/pgAdmin:**
```sql
-- Create user
CREATE USER john WITH PASSWORD 'secure_password';

-- Create role (no login by default)
CREATE ROLE readonly;

-- Create user with options
CREATE USER jane WITH 
    PASSWORD 'password123'
    VALID UNTIL '2025-12-31'
    CONNECTION LIMIT 10;

-- Create superuser
CREATE USER admin WITH PASSWORD 'admin123' SUPERUSER;

-- Create user with specific privileges
CREATE USER developer WITH 
    PASSWORD 'dev123'
    CREATEDB
    CREATEROLE;
```

**pgAdmin:**
1. Right-click **Login/Group Roles** → Create → Login/Group Role
2. **General Tab:** Name: `john`
3. **Definition Tab:** Password: `secure_password`
4. **Privileges Tab:** Select privileges
5. Click **Save**

---

### 👀 List Users/Roles

**CMD (psql):**
```sql
-- Meta command
\du

-- SQL query
SELECT 
    rolname AS role_name,
    rolsuper AS is_superuser,
    rolcreatedb AS can_create_db,
    rolcreaterole AS can_create_role,
    rolcanlogin AS can_login
FROM pg_roles
ORDER BY rolname;
```

**pgAdmin:**
- Expand Server → **Login/Group Roles**

**Output:**
```
 role_name | is_superuser | can_create_db | can_create_role | can_login 
-----------+--------------+---------------+-----------------+-----------
 john      | f            | f             | f               | t
 postgres  | t            | t             | t               | t
 readonly  | f            | f             | f               | f
```

---

### 🔑 Grant Privileges

**Database Level:**
```sql
-- Grant connect privilege
GRANT CONNECT ON DATABASE company TO john;

-- Grant all privileges on database
GRANT ALL PRIVILEGES ON DATABASE company TO john;
```

**Schema Level:**
```sql
-- Grant usage on schema
GRANT USAGE ON SCHEMA public TO john;

-- Grant all on schema
GRANT ALL ON SCHEMA public TO john;
```

**Table Level:**
```sql
-- Grant SELECT on specific table
GRANT SELECT ON employees TO john;

-- Grant multiple privileges
GRANT SELECT, INSERT, UPDATE ON employees TO john;

-- Grant all privileges on table
GRANT ALL PRIVILEGES ON employees TO john;

-- Grant on all tables in schema
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;

-- Grant on future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO readonly;
```

**Sequence Level:**
```sql
-- Grant usage on sequence
GRANT USAGE ON SEQUENCE employees_id_seq TO john;

-- Grant on all sequences
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO john;
```

**Function Level:**
```sql
-- Grant execute on function
GRANT EXECUTE ON FUNCTION get_employee_count() TO john;

-- Grant on all functions
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO john;
```

**Column Level:**
```sql
-- Grant SELECT on specific columns
GRANT SELECT (first_name, last_name, email) ON employees TO john;
```

**pgAdmin:**
1. Right-click database/table → **Properties**
2. **Security Tab**
3. Click **+** to add privileges
4. Select user and privileges
5. Click **Save**

---

### 🔒 Revoke Privileges

**CMD/pgAdmin:**
```sql
-- Revoke specific privilege
REVOKE INSERT ON employees FROM john;

-- Revoke all privileges
REVOKE ALL PRIVILEGES ON employees FROM john;

-- Revoke on all tables
REVOKE SELECT ON ALL TABLES IN SCHEMA public FROM readonly;

-- Revoke from database
REVOKE CONNECT ON DATABASE company FROM john;
```

---

### 👁️ Show Privileges

**CMD/pgAdmin:**
```sql
-- Table privileges
SELECT 
    grantee,
    table_schema,
    table_name,
    privilege_type
FROM information_schema.table_privileges
WHERE grantee = 'john';

-- Database privileges
\l+ company

-- Table ACL (psql)
\dp employees
```

---

### 🔧 Modify User/Role

**CMD/pgAdmin:**
```sql
-- Change password
ALTER USER john WITH PASSWORD 'new_secure_password';

-- Add privileges
ALTER USER john WITH CREATEDB;

-- Remove privileges
ALTER USER john WITH NOCREATEDB;

-- Rename user
ALTER USER john RENAME TO john_smith;

-- Set connection limit
ALTER USER john CONNECTION LIMIT 5;

-- Set password expiry
ALTER USER john VALID UNTIL '2025-12-31';

-- Add user to role
GRANT readonly TO john;

-- Remove user from role
REVOKE readonly FROM john;
```

---

### ❌ Drop User/Role

**CMD/pgAdmin:**
```sql
-- Drop user
DROP USER john;

-- Drop if exists
DROP USER IF EXISTS john;

-- Drop role
DROP ROLE readonly;

-- Reassign ownership before dropping
REASSIGN OWNED BY john TO postgres;
DROP OWNED BY john;
DROP USER john;
```

---

### 🎯 Role Hierarchy

**CMD/pgAdmin:**
```sql
-- Create roles
CREATE ROLE readonly;
CREATE ROLE readwrite;
CREATE ROLE admin;

-- Grant privileges to roles
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO readwrite;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;

-- Create role hierarchy
GRANT readonly TO readwrite;
GRANT readwrite TO admin;

-- Assign role to user
GRANT readwrite TO john;

-- User can set role
SET ROLE readwrite;

-- Reset to login role
RESET ROLE;
```

---

## 🚀 Advanced PostgreSQL Features

### 🎯 Common Table Expressions (CTE)

**Simple CTE (CMD/pgAdmin):**
```sql
WITH high_earners AS (
    SELECT * FROM employees WHERE salary > 70000
)
SELECT * FROM high_earners WHERE department_id = 1;
```

**Multiple CTEs:**
```sql
WITH 
high_earners AS (
    SELECT * FROM employees WHERE salary > 70000
),
dept_summary AS (
    SELECT 
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT 
    h.first_name,
    h.salary,
    d.avg_salary
FROM high_earners h
JOIN dept_summary d ON h.department_id = d.department_id;
```

**Recursive CTE (Organizational Hierarchy):**
```sql
WITH RECURSIVE employee_hierarchy AS (
    -- Base case: top-level employees
    SELECT 
        id,
        first_name,
        last_name,
        manager_id,
        1 AS level,
        first_name::TEXT AS path
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case: employees with managers
    SELECT 
        e.id,
        e.first_name,
        e.last_name,
        e.manager_id,
        eh.level + 1,
        eh.path || ' > ' || e.first_name
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.id
)
SELECT 
    level,
    first_name,
    last_name,
    path
FROM employee_hierarchy
ORDER BY level, first_name;
```

**Recursive CTE (Generate Numbers):**
```sql
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 100
)
SELECT * FROM numbers;
```

---

### 📊 Window Functions

**ROW_NUMBER:**
```sql
SELECT 
    first_name,
    last_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;
```

**RANK and DENSE_RANK:**
```sql
SELECT 
    first_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM employees;
```

**Output:**
```
 first_name | salary  | rank | dense_rank 
------------+---------+------+------------
 Alice      | 90000   | 1    | 1
 Bob        | 80000   | 2    | 2
 Charlie    | 80000   | 2    | 2
 David      | 70000   | 4    | 3
```

**PARTITION BY:**
```sql
SELECT 
    first_name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id 
        ORDER BY salary DESC
    ) AS dept_rank
FROM employees;
```

**LAG and LEAD:**
```sql
SELECT 
    first_name,
    salary,
    LAG(salary) OVER (ORDER BY hire_date) AS previous_salary,
    LEAD(salary) OVER (ORDER BY hire_date) AS next_salary,
    salary - LAG(salary) OVER (ORDER BY hire_date) AS salary_diff
FROM employees;
```

**FIRST_VALUE and LAST_VALUE:**
```sql
SELECT 
    first_name,
    salary,
    FIRST_VALUE(salary) OVER (
        ORDER BY salary DESC
    ) AS highest_salary,
    LAST_VALUE(salary) OVER (
        ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS lowest_salary
FROM employees;
```

**NTILE (Divide into Groups):**
```sql
SELECT 
    first_name,
    salary,
    NTILE(4) OVER (ORDER BY salary) AS quartile
FROM employees;
```

**Running Total:**
```sql
SELECT 
    first_name,
    salary,
    SUM(salary) OVER (
        ORDER BY hire_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM employees;
```

**Moving Average:**
```sql
SELECT 
    first_name,
    hire_date,
    salary,
    AVG(salary) OVER (
        ORDER BY hire_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_3
FROM employees;
```

---

### 📦 JSONB Operations

**Create Table with JSONB (CMD/pgAdmin):**
```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    attributes JSONB
);
```

**Insert JSONB Data:**
```sql
INSERT INTO products (name, attributes) VALUES
('Laptop', '{"brand": "Dell", "ram": 16, "storage": 512, "ports": ["USB", "HDMI", "USB-C"]}'),
('Phone', '{"brand": "Apple", "model": "iPhone 14", "color": "black", "storage": 256}'),
('Camera', '{"brand": "Canon", "megapixels": 24, "lenses": ["50mm", "85mm"]}');
```

**Query JSONB:**
```sql
-- Extract value (returns JSON)
SELECT name, attributes->'brand' AS brand FROM products;

-- Extract as text
SELECT name, attributes->>'brand' AS brand FROM products;

-- Nested access
SELECT name, attributes->'specs'->>'processor' AS processor FROM products;

-- Array access
SELECT name, attributes->'ports'->0 AS first_port FROM products;

-- Check if key exists
SELECT * FROM products WHERE attributes ? 'ram';

-- Check if contains
SELECT * FROM products 
WHERE attributes @> '{"brand": "Dell"}';

-- Get all keys
SELECT name, jsonb_object_keys(attributes) AS keys FROM products;
```

**Modify JSONB:**
```sql
-- Update field
UPDATE products
SET attributes = jsonb_set(attributes, '{ram}', '32')
WHERE id = 1;

-- Add new field
UPDATE products
SET attributes = attributes || '{"warranty": "2 years"}'
WHERE id = 1;

-- Remove field
UPDATE products
SET attributes = attributes - 'color'
WHERE id = 2;

-- Update nested field
UPDATE products
SET attributes = jsonb_set(attributes, '{specs,processor}', '"Intel i9"')
WHERE id = 1;
```

**JSONB Aggregation:**
```sql
-- Aggregate to JSON array
SELECT jsonb_agg(name) AS product_names FROM products;

-- Aggregate to JSON object
SELECT jsonb_object_agg(id, name) AS product_map FROM products;

-- Build JSON object
SELECT 
    id,
    jsonb_build_object(
        'name', name,
        'brand', attributes->>'brand',
        'price', 999.99
    ) AS product_json
FROM products;
```

**JSONB Indexing:**
```sql
-- GIN index for fast JSONB queries
CREATE INDEX idx_products_attributes ON products USING GIN(attributes);

-- Index specific path
CREATE INDEX idx_products_brand ON products ((attributes->>'brand'));
```

---

### 🔢 Array Operations

**Create Table with Array (CMD/pgAdmin):**
```sql
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200),
    tags TEXT[],
    scores INTEGER[]
);
```

**Insert Array Data:**
```sql
INSERT INTO posts (title, tags, scores) VALUES
('PostgreSQL Guide', ARRAY['database', 'postgresql', 'sql'], ARRAY[9, 8, 10]),
('Python Tutorial', ARRAY['python', 'programming'], ARRAY[7, 8]),
('Web Development', ARRAY['html', 'css', 'javascript'], ARRAY[6, 7, 8]);
```

**Query Arrays:**
```sql
-- Access array element (1-indexed!)
SELECT title, tags[1] AS first_tag FROM posts;

-- Array length
SELECT title, array_length(tags, 1) AS tag_count FROM posts;

-- Check if array contains value
SELECT * FROM posts WHERE 'postgresql' = ANY(tags);

-- Check if all match
SELECT * FROM posts WHERE tags @> ARRAY['database', 'sql'];

-- Array overlap
SELECT * FROM posts WHERE tags && ARRAY['python', 'java'];

-- Unnest array to rows
SELECT title, unnest(tags) AS tag FROM posts;

-- Unnest with ordinality (index)
SELECT title, tag, position
FROM posts, unnest(tags) WITH ORDINALITY AS t(tag, position);
```

**Modify Arrays:**
```sql
-- Append to array
UPDATE posts
SET tags = array_append(tags, 'tutorial')
WHERE id = 1;

-- Prepend to array
UPDATE posts
SET tags = array_prepend('new', tags)
WHERE id = 1;

-- Remove from array
UPDATE posts
SET tags = array_remove(tags, 'sql')
WHERE id = 1;

-- Concatenate arrays
UPDATE posts
SET tags = tags || ARRAY['advanced', 'guide']
WHERE id = 1;
```

**Array Aggregation:**
```sql
-- Aggregate values into array
SELECT array_agg(title) AS all_titles FROM posts;

-- Aggregate distinct
SELECT array_agg(DISTINCT unnest(tags)) AS all_tags FROM posts;
```

---

### 🆔 UUID

**Enable UUID Extension (CMD/pgAdmin):**
```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
-- or for newer PostgreSQL
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
```

**Create Table with UUID:**
```sql
CREATE TABLE sessions (
    session_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**Insert with UUID:**
```sql
-- Auto-generated
INSERT INTO sessions (user_id) VALUES (1);

-- Manual UUID
INSERT INTO sessions (session_id, user_id) 
VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 2);

-- Generate UUID
SELECT gen_random_uuid();
```

---

### 🔍 Full-Text Search

**Create Table with tsvector (CMD/pgAdmin):**
```sql
CREATE TABLE articles (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200),
    content TEXT,
    search_vector tsvector
);
```

**Generate tsvector:**
```sql
-- Update search vector
UPDATE articles
SET search_vector = to_tsvector('english', title || ' ' || content);

-- Auto-generate with trigger
CREATE TRIGGER trg_articles_search_update
BEFORE INSERT OR UPDATE ON articles
FOR EACH ROW
EXECUTE FUNCTION 
    tsvector_update_trigger(search_vector, 'pg_catalog.english', title, content);
```

**Full-Text Search:**
```sql
-- Basic search
SELECT * FROM articles
WHERE search_vector @@ to_tsquery('english', 'postgresql');

-- Multiple words (AND)
SELECT * FROM articles
WHERE search_vector @@ to_tsquery('english', 'postgresql & database');

-- OR search
SELECT * FROM articles
WHERE search_vector @@ to_tsquery('english', 'postgresql | mysql');

-- NOT search
SELECT * FROM articles
WHERE search_vector @@ to_tsquery('english', 'postgresql & !oracle');

-- Phrase search
SELECT * FROM articles
WHERE search_vector @@ phraseto_tsquery('english', 'postgresql database');

-- With ranking
SELECT 
    title,
    ts_rank(search_vector, to_tsquery('english', 'postgresql')) AS rank
FROM articles
WHERE search_vector @@ to_tsquery('english', 'postgresql')
ORDER BY rank DESC;
```

**Create GIN Index:**
```sql
CREATE INDEX idx_articles_search ON articles USING GIN(search_vector);
```

---

### 📊 Table Partitioning

**Range Partitioning (CMD/pgAdmin):**
```sql
-- Create parent table
CREATE TABLE sales (
    id SERIAL,
    sale_date DATE NOT NULL,
    amount NUMERIC(10,2)
) PARTITION BY RANGE (sale_date);

-- Create partitions
CREATE TABLE sales_2023 PARTITION OF sales
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE sales_2024 PARTITION OF sales
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE sales_2025 PARTITION OF sales
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Insert data (automatically goes to correct partition)
INSERT INTO sales (sale_date, amount) VALUES
('2023-05-15', 1000.00),
('2024-03-20', 1500.00),
('2025-01-10', 2000.00);
```

**List Partitioning:**
```sql
CREATE TABLE employees_partitioned (
    id SERIAL,
    name VARCHAR(100),
    department VARCHAR(50)
) PARTITION BY LIST (department);

CREATE TABLE emp_sales PARTITION OF employees_partitioned
    FOR VALUES IN ('Sales', 'Marketing');

CREATE TABLE emp_tech PARTITION OF employees_partitioned
    FOR VALUES IN ('IT', 'Development');

CREATE TABLE emp_other PARTITION OF employees_partitioned
    DEFAULT;
```

**Hash Partitioning:**
```sql
CREATE TABLE logs (
    id SERIAL,
    log_message TEXT,
    created_at TIMESTAMP
) PARTITION BY HASH (id);

CREATE TABLE logs_p0 PARTITION OF logs
    FOR VALUES WITH (MODULUS 4, REMAINDER 0);

CREATE TABLE logs_p1 PARTITION OF logs
    FOR VALUES WITH (MODULUS 4, REMAINDER 1);

CREATE TABLE logs_p2 PARTITION OF logs
    FOR VALUES WITH (MODULUS 4, REMAINDER 2);

CREATE TABLE logs_p3 PARTITION OF logs
    FOR VALUES WITH (MODULUS 4, REMAINDER 3);
```

**View Partitions:**
```sql
-- List all partitions
SELECT 
    schemaname,
    tablename,
    partitionby
FROM pg_tables
WHERE schemaname = 'public';

-- Detailed partition info
SELECT 
    parent.relname AS parent_table,
    child.relname AS partition_name
FROM pg_inherits
JOIN pg_class parent ON pg_inherits.inhparent = parent.oid
JOIN pg_class child ON pg_inherits.inhrelid = child.oid;
```

---

### ⚡ Performance Tuning

**EXPLAIN ANALYZE (CMD/pgAdmin):**
```sql
EXPLAIN ANALYZE
SELECT * FROM employees WHERE salary > 60000;
```

**EXPLAIN Options:**
```sql
EXPLAIN (ANALYZE, BUFFERS, VERBOSE)
SELECT e.first_name, d.name
FROM employees e
JOIN departments d ON e.department_id = d.id;
```

**VACUUM:**
```sql
-- Vacuum table
VACUUM employees;

-- Vacuum and analyze
VACUUM ANALYZE employees;

-- Full vacuum (locks table)
VACUUM FULL employees;

-- Vacuum entire database
VACUUM;
```

**ANALYZE:**
```sql
-- Update statistics
ANALYZE employees;

-- Analyze specific columns
ANALYZE employees (salary, department_id);
```

**REINDEX:**
```sql
-- Rebuild index
REINDEX INDEX idx_employees_email;

-- Rebuild all indexes on table
REINDEX TABLE employees;

-- Rebuild all indexes in database
REINDEX DATABASE company;
```

**Auto-Vacuum Settings:**
```sql
-- Show auto-vacuum settings
SHOW autovacuum;

-- Set for specific table
ALTER TABLE employees SET (
    autovacuum_enabled = true,
    autovacuum_vacuum_threshold = 100,
    autovacuum_analyze_threshold = 50
);
```

---

### 📥 Import/Export Data

**COPY Command (CMD/pgAdmin):**

**Export to CSV:**
```sql
-- Export entire table
COPY employees TO '/tmp/employees.csv' WITH CSV HEADER;

-- Export specific columns
COPY (SELECT first_name, last_name, email FROM employees)
TO '/tmp/employees_subset.csv' WITH CSV HEADER;

-- Export with custom delimiter
COPY employees TO '/tmp/employees.txt' WITH DELIMITER '|';

-- Export query results
COPY (SELECT * FROM employees WHERE salary > 60000)
TO '/tmp/high_earners.csv' WITH CSV HEADER;
```

**Import from CSV:**
```sql
-- Import into table
COPY employees FROM '/tmp/employees.csv' WITH CSV HEADER;

-- Import specific columns
COPY employees (first_name, last_name, email)
FROM '/tmp/employees_subset.csv' WITH CSV HEADER;

-- Import with custom delimiter
COPY employees FROM '/tmp/employees.txt' WITH DELIMITER '|';
```

**pgAdmin Import/Export:**
1. Right-click table → **Import/Export Data**
2. **Options Tab:**
   - Format: CSV
   - Header: Yes
   - Delimiter: ,
3. **Filename:** Browse and select file
4. Click **OK**

---

**psql Command Line Import:**
```bash
# Import SQL file
psql -U postgres -d company -f backup.sql

# Import with variables
psql -U postgres -d company -v ON_ERROR_STOP=1 -f script.sql

# Import CSV using \copy (works in psql)
\copy employees FROM '/tmp/employees.csv' WITH CSV HEADER
```

---

### 💾 Backup and Restore

**pg_dump (CMD):**
```bash
# Backup entire database
pg_dump -U postgres company > company_backup.sql

# Backup with compression
pg_dump -U postgres -Fc company > company_backup.dump

# Backup specific tables
pg_dump -U postgres -t employees -t departments company > tables_backup.sql

# Backup only schema
pg_dump -U postgres --schema-only company > schema.sql

# Backup only data
pg_dump -U postgres --data-only company > data.sql

# Backup all databases
pg_dumpall -U postgres > all_databases.sql

# Backup only globals (roles, tablespaces)
pg_dumpall -U postgres --globals-only > globals.sql
```

**pg_restore (CMD):**
```bash
# Restore from custom format
pg_restore -U postgres -d company company_backup.dump

# Restore specific table
pg_restore -U postgres -d company -t employees company_backup.dump

# Restore with clean (drop existing objects)
pg_restore -U postgres -d company --clean company_backup.dump

# Restore with create database
pg_restore -U postgres -C -d postgres company_backup.dump

# Parallel restore (faster)
pg_restore -U postgres -d company -j 4 company_backup.dump
```

**psql Restore (CMD):**
```bash
# Restore plain SQL dump
psql -U postgres -d company < company_backup.sql

# Create database and restore
psql -U postgres -c "CREATE DATABASE company"
psql -U postgres -d company < company_backup.sql
```

**pgAdmin Backup/Restore:**

**Backup:**
1. Right-click database → **Backup**
2. **Filename:** Choose location
3. **Format:** Custom, Tar, Plain, or Directory
4. **Options:**
   - ✅ Include data
   - ✅ Include schema
   - ✅ Use INSERT commands (for portability)
5. Click **Backup**

**Restore:**
1. Right-click database → **Restore**
2. **Filename:** Select backup file
3. **Format:** Match backup format
4. **Options:**
   - Clean before restore
   - Create database
5. Click **Restore**

---

### 📊 System Information

**Database Size (CMD/pgAdmin):**
```sql
-- Current database size
SELECT pg_size_pretty(pg_database_size(current_database()));

-- All databases
SELECT 
    datname AS database_name,
    pg_size_pretty(pg_database_size(datname)) AS size
FROM pg_database
ORDER BY pg_database_size(datname) DESC;
```

**Table Size:**
```sql
-- Single table
SELECT pg_size_pretty(pg_total_relation_size('employees'));

-- All tables with details
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS total_size,
    pg_size_pretty(pg_relation_size(schemaname||'.'||tablename)) AS table_size,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename) - 
                   pg_relation_size(schemaname||'.'||tablename)) AS index_size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
```

**Active Connections:**
```sql
-- Current connections
SELECT 
    pid,
    usename,
    application_name,
    client_addr,
    state,
    query
FROM pg_stat_activity
WHERE datname = current_database();

-- Kill connection
SELECT pg_terminate_backend(pid) WHERE pid = 12345;