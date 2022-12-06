-- Database: assessmentdb

-- DROP DATABASE IF EXISTS assessmentdb;

CREATE DATABASE assessmentdb
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_Sweden.1252'
    LC_CTYPE = 'English_Sweden.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- 1.3 Assign appropriate data types to each column.
CREATE TABLE contacts (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    title VARCHAR(40),
    organization VARCHAR(40)
);
SELECT * FROM contacts;

CREATE TABLE contact_types (
    id SERIAL PRIMARY KEY,
    contact_type VARCHAR(30)
);
SELECT * FROM contact_types;

CREATE TABLE contact_category (
    id SERIAL PRIMARY KEY,
    contact_category VARCHAR(30)
);
SELECT * FROM contact_category;

CREATE TABLE items (
    contact VARCHAR(30),
    contact_id INT REFERENCES contacts (id),
    contact_type_id INT REFERENCES contact_types (id),
    contact_category_id INT REFERENCES contact_category(id)
);
SELECT * FROM items;

-- 1.4 Add data from the examples below.
-- Gällande tables contacts, contact_types och contact_category
-- så fyllde jag i raderna via View Data
SELECT * FROM contacts;
SELECT * FROM contact_types;
SELECT * FROM contact_category;

INSERT INTO items (contact, contact_id, contact_type_id, contact_category_id)
VALUES
('011-123345', 3, 2, 1),
('goran@infoab.se', 3, 1, 2),
('010-885544', 4, 2, 2),
('erik57@hotmail', 1, 1, 1),
('@annapanna99', 2, 4, 1),
('077-563578', 2, 2, 1),
('070-1562278', 3, 2, 2);
SELECT * FROM items;

-- 1.5 Add two more rows into the contact table, where one of them 
-- contains your own name.
INSERT INTO contacts (id, first_name, last_name, title, organization)
VALUES
(6, 'Annika', 'Davies', 'Friend', 'ADFriends AB'),
(7, 'Mai', 'Davies', 'Mother', 'ADFriends AB');
SELECT * FROM contacts;

-- 1.6 Create a query that lists if there are unused contact_types.
SELECT  i.contact, i.contact_type_id, ct.contact_type
FROM items i
FULL JOIN contact_types ct
ON i.contact_type_id = ct.id;

-- 1.7 Create a view view_contacts that lists the columns: 
-- first_name, last_name, contact, contact_type, contact_category.
CREATE VIEW view_contacts AS
SELECT c.first_name, c.last_name, i.contact, ct.contact_type, cc.contact_category
FROM contacts c
JOIN items i
ON c.id = i.contact_id
JOIN contact_types ct
ON ct.id = i.contact_type_id
JOIN contact_category cc
ON cc.id = i.contact_category_id;

-- 1.8 Create a query that lists all information from the database.
SELECT c.id, c.first_name, c.last_name, c.title, c.organization, 
i.contact, i.contact_id, i.contact_type_id, i.contact_category_id,
ct.id, ct.contact_type, 
cc.id, cc.contact_category
FROM contacts c
FULL JOIN items i
ON c.id = i.contact_id
FULL JOIN contact_types ct
ON ct.id = i.contact_type_id
FULL JOIN contact_category cc
ON cc.id = i.contact_category_id;

