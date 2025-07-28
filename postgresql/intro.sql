

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


