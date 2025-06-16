

\list -- to list down the databases
\l

CREATE DATABASE testDB; -- to create DB;
\c testDB;  -- to connect to the specific db;

drop database testDB;  -- drop database;

-- CRUD
INSERT INTO person(id,name,city) VALUES (101,'Venue','Hyderabad');