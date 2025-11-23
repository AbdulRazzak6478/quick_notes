

\list -- to list down the databases
\l

CREATE DATABASE testDB; -- to create DB;
\c testDB;  -- to connect to the specific db;

drop database testDB;  -- drop database;

-- CRUD
INSERT INTO person(id,name,city) VALUES (101,'Venue','Hyderabad');



select * from disputes limit 3 offset 20;
select business_id from disputes;


-- SELECT AND COUNT AND SUM


select COUNT('id') as totalDisputes from disputes;
select COUNT('gateway') as gateways from disputes;
SELECT SUM(CASE WHEN LOWER(state) = 'won' THEN 1 ELSE 0 END) FROM disputes;
SELECT COUNT(CASE WHEN LOWER(state) = 'won' THEN 1 ELSE 0 END) FROM disputes; -- COUNT ZERO ALSO
SELECT COUNT(CASE WHEN LOWER(gateway) = 'razorpay' THEN 1 ELSE NULL END) FROM disputes;
SELECT COUNT(gateway)as razorpay from disputes where gateway='razorpay';

select SUM(CASE WHEN LOWER(state) = 'won' THEN 1 ELSE 0 END) as wonDisputes from disputes;
SELECT COUNT(id) as totalDisputes, SUM(case when amount < 8000 then amount else 0 end) as totalAmount from disputes where business_id ='6a0e2a6c-3b37-40a4-b564-ed54d42efd9e';
SELECT COUNT(id) as totalDisputes, SUM(case when lower(state) = 'won' then 1 else 0 end) as wonDisputes from disputes where business_id ='6a0e2a6c-3b37-40a4-b564-ed54d42efd9e';
SELECT COUNT(id) as totalDisputes, SUM(case when lower(state) = 'lost' then 1 else 0 end) as wonDisputes from disputes where business_id ='6a0e2a6c-3b37-40a4-b564-ed54d42efd9e';
EXPLAIN ANALYZE SELECT COUNT(id) as totalDisputes, SUM(case when lower(state) = 'won' then 1 else 0 end) as wonDisputes from disputes where business_id ='6a0e2a6c-3b37-40a4-b564-ed54d42efd9e';

EXPLAIN ANALYZE SELECT COUNT(*) FROM disputes WHERE business_id = '6a0e2a6c-3b37-40a4-b564-ed54d42efd9e';


select count(case when analyst_id is null then 1 else null end) from disputes;
select custom_id,analyst_id from disputes where analyst_id is null;
select count(case when analyst_id is not null then 1 else null end) from disputes;
select * from disputes limit 30 offset 40;

ANALYZE disputes;
select * from dispute_logs;


SET enable_seqscan = ON; -- for sequence scan , if table large then go to index planner

EXPLAIN ANALYZE 
SELECT COUNT(id), SUM(CASE WHEN LOWER(state) = 'won' THEN 1 ELSE 0 END)
FROM disputes 
WHERE business_id = '6a0e2a6c-3b37-40a4-b564-ed54d42efd9e';
d disputes;
EXPLAIN ANALYZE SELECT * FROM disputes WHERE LOWER(state) = 'won';

SELECT 
  column_name, 
  data_type, 
  is_nullable, 
  column_default
FROM information_schema.columns
WHERE table_name = 'disputes';

SELECT * FROM information_schema.columns
WHERE table_name = 'disputes';

SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'disputes';
SELECT * FROM pg_indexes WHERE tablename = 'disputes';

UPDATE disputes SET reason = INITCAP(REPLACE(reason, '_', ' ')) where gateway='cashfree';


update disputes set created_at = '2025-06-25' where id in ( select id from  disputes where gateway='cashfree' order by created_at asc limit 600 offset 6000 );

    id UUID PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,

    merchant_id UUID NOT NULL REFERENCES merchants(id) ON UPDATE CASCADE,
    business_id UUID NOT NULL REFERENCES businesses(id) ON UPDATE CASCADE ON DELETE CASCADE,
    analyst_id UUID REFERENCES analysts(id) ON UPDATE CASCADE ON DELETE SET NULL,
    manager_id UUID REFERENCES managers(id) ON UPDATE CASCADE ON DELETE SET NULL,

-- Indexes
CREATE INDEX idx_disputes_merchant_id ON disputes(merchant_id);
CREATE INDEX idx_disputes_business_id ON disputes(business_id);

ALTER TABLE IF EXISTS public.analysts
    ADD CONSTRAINT analysts_merchant_id_fkey FOREIGN KEY (merchant_id)
    REFERENCES public.merchants (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;
CREATE INDEX IF NOT EXISTS analysts_merchant_id
    ON public.analysts(merchant_id);

SELECT *
FROM disputes
WHERE ($1::timestamptz IS NULL OR (created_at, id) < ($1::timestamptz, $2::uuid))
ORDER BY created_at DESC, id DESC
LIMIT $3;

SELECT COUNT(*)::bigint AS total
FROM disputes
WHERE ($1::uuid IS NULL OR merchant_id = $1)
  AND ($2::text IS NULL OR state = $2)
  AND ($3::text IS NULL OR workflow_stage = $3);

ALTER TABLE IF EXISTS businesses ADD CONSTRAINT unique_business_merchant 
FOREIGN KEY (merchant_id) REFERENCES TO merchants (id) SIMPLE MATCH

CREATE INDEX idx_business_merchant_id ON merchants(id);

select count(*)::bigint as total from disputes;


-- PostgreSQL
-- 0.
-- For UUIDs
CREATE EXTENSION IF NOT EXISTS pgcrypto;     -- gen_random_uuid()
-- For case-insensitive email/username
CREATE EXTENSION IF NOT EXISTS citext;


CREATE TABLE users (
  id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  org_id            uuid NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
  role_id           uuid NOT NULL REFERENCES roles(id) ON DELETE RESTRICT,
  -- citext makes comparisons case-insensitive; great for unique email constraints
  email             citext NOT NULL,
  username          citext,
  password_hash     text,                       -- store only hashes, never plaintext
  full_name         text NOT NULL,
  date_of_birth     date,
  phone             text,
  status            user_status NOT NULL DEFAULT 'INVITED',
  preferences       jsonb NOT NULL DEFAULT '{}'::jsonb,  -- arbitrary per-user settings
  deleted_at        timestamptz,               -- soft-delete marker
  created_at        timestamptz NOT NULL DEFAULT now(),
  updated_at        timestamptz NOT NULL DEFAULT now(),

  -- Example CHECKs
  CONSTRAINT chk_dob_adult
    CHECK (date_of_birth IS NULL OR date_of_birth <= (CURRENT_DATE - INTERVAL '18 years')),

  -- Optional, ensure reasonable hash length (tweak as needed)
  CONSTRAINT chk_password_hash_len
    CHECK (password_hash IS NULL OR length(password_hash) >= 50)
);

-- Enforce unique email per org for non-deleted rows (partial unique index)
CREATE UNIQUE INDEX ux_users_org_email_active
  ON users (org_id, email)
  WHERE deleted_at IS NULL;

-- Optional: ensure username unique per org (also ignoring soft-deleted)
CREATE UNIQUE INDEX ux_users_org_username_active
  ON users (org_id, username)
  WHERE deleted_at IS NULL;

-- Useful indexes
CREATE INDEX ix_users_org ON users(org_id);
CREATE INDEX ix_users_role ON users(role_id);
CREATE INDEX ix_users_status ON users(status);
CREATE INDEX ix_users_prefs_gin ON users USING GIN (preferences);


-- Seed an org
INSERT INTO organizations (name) VALUES ('Acme Corp')
RETURNING id;

CREATE TYPE <name> AS ENUM (str1,str2...);
CREATE TYPE stages AS ENUM ('PENDING','SUBMITTED','ACCEPTED','REJECTED','RESUBMITTED');

-- DOMAIN for simple email validation (keep it pragmatic)
CREATE DOMAIN email_addr AS TEXT CHECK (VALUE ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$');

for constraints , 
alter

for Update Fields
update


-- Add NOT NULL
ALTER TABLE product
ALTER COLUMN name SET NOT NULL;

-- Add UNIQUE
ALTER TABLE product
ADD CONSTRAINT unique_sku UNIQUE (sku);

-- Add CHECK
ALTER TABLE product
ADD CONSTRAINT positive_price CHECK (price > 0);

-- Add FOREIGN KEY
ALTER TABLE product
ADD CONSTRAINT fk_product_business
FOREIGN KEY (business_id) REFERENCES business(id)
ON UPDATE CASCADE ON DELETE CASCADE;

-- Add PRIMARY KEY (if none exists yet)
ALTER TABLE product
ADD CONSTRAINT pk_product PRIMARY KEY (id);


-- Add a column with datatype
ALTER TABLE product
ADD COLUMN discount NUMERIC(5,2) DEFAULT 0 CHECK (discount >= 0);

-- Add multiple columns at once
ALTER TABLE product
ADD COLUMN color TEXT,
ADD COLUMN size TEXT;


-- Change column name
ALTER TABLE product
RENAME COLUMN discount TO discount_percent;

-- Change data type (if safe)
ALTER TABLE product
ALTER COLUMN discount_percent TYPE INTEGER;

-- Add/remove NOT NULL
ALTER TABLE product
ALTER COLUMN name SET NOT NULL;
ALTER TABLE product
ALTER COLUMN name DROP NOT NULL;

-- Change default value
ALTER TABLE product
ALTER COLUMN discount_percent SET DEFAULT 5;
ALTER TABLE product
ALTER COLUMN discount_percent DROP DEFAULT;


-- Describe table structure
\d product;             -- works in psql
-- or in pgAdmin: right-click table → Properties → Columns

-- Query system catalog
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'product';

SELECT o.id AS order_id, u.email, b.name AS business_name, o.total_amount
FROM "order" o
INNER JOIN app_user u ON o.user_id = u.id
INNER JOIN business b ON o.business_id = b.id;

SELECT u.id AS user_id, u.email, o.id AS order_id, o.total_amount
FROM app_user u
LEFT JOIN "order" o ON u.id = o.user_id;


UPDATE tweets
SET content = 'New content', author = 'new_author'
WHERE id = 2;

UPDATE tweets
SET author = 'anonymous'
WHERE author = 'old_author';

UPDATE disputes SET workflow_stage = 'SUBMITTED' WHERE custom_id = 'DSP9876123456789';


// Examples of ALTER TABLE operations in SQL using Node.js (with a generic DB client like mysql2 or pg)

const alterExamples = [
  // 1. Add column
  {
    description: "Add a column",
    sql: `ALTER TABLE tweets ADD COLUMN likes INT DEFAULT 0;`
  },
  // 2. Modify column (MySQL syntax)
  {
    description: "Modify a column (MySQL)",
    sql: `ALTER TABLE tweets MODIFY COLUMN content VARCHAR(500);`
  },
  // 2b. Modify column (PostgreSQL syntax)
  {
    description: "Modify a column (PostgreSQL)",
    sql: `ALTER TABLE tweets ALTER COLUMN content TYPE VARCHAR(500);`
  },
  // 3. Drop column
  {
    description: "Drop a column",
    sql: `ALTER TABLE tweets DROP COLUMN likes;`
  },
  // 4. Rename column (PostgreSQL >= 9.1)
  {
    description: "Rename a column (PostgreSQL/MySQL 8+)",
    sql: `ALTER TABLE tweets RENAME COLUMN author TO username;`
  },
  // 4b. Rename column (MySQL <= 5.7)
  {
    description: "Rename a column (MySQL <= 5.7)",
    sql: `ALTER TABLE tweets CHANGE author username VARCHAR(255);`
  },
  // 5. Rename table
  {
    description: "Rename a table",
    sql: `ALTER TABLE tweets RENAME TO micro_posts;`
  },
  // 6. Add constraint (unique)
  {
    description: "Add a unique constraint",
    sql: `ALTER TABLE tweets ADD CONSTRAINT unique_content UNIQUE (content);`
  },
  // 6b. Add constraint (foreign key)
  {
    description: "Add a foreign key constraint",
    sql: `ALTER TABLE tweets ADD CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES users(id);`
  },
  // 7. Drop constraint (PostgreSQL)
  {
    description: "Drop a constraint (PostgreSQL)",
    sql: `ALTER TABLE tweets DROP CONSTRAINT unique_content;`
  },
  // 7b. Drop constraint (MySQL unique index)
  {
    description: "Drop a unique constraint (MySQL)",
    sql: `ALTER TABLE tweets DROP INDEX unique_content;`
  }
];

// Example: Executing these queries (using async/await and a database client)
// This is pseudo-code; adapt for your DB client (e.g., mysql2, pg, etc.)

async function runAlterExamples(dbClient) {
  for (const ex of alterExamples) {
    try {
      console.log(`Running: ${ex.description}`);
      await dbClient.query(ex.sql);
      console.log("Success");
    } catch (err) {
      console.error(`Error running: ${ex.description}\n`, err.message);
    }
  }
}

// Export for use elsewhere
module.exports = { alterExamples, runAlterExamples };