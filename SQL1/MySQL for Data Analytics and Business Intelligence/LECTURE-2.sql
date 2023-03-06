# CONSTRAINT (rule or limit)
USE Sales;

## PRIMARY KEY constraint
CREATE TABLE sales (
    purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
PRIMARY KEY (purchase_number)
);
DROP TABLE customers;

CREATE TABLE customers (
    customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_adress VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id)
);

CREATE TABLE items (
    item_code VARCHAR(255),
    item VARCHAR(255),
    unit_price NUMERIC(10 , 2 ),
    company_id VARCHAR(255)
);

CREATE TABLE companies (
    company_id VARCHAR(255),
    company_name VARCHAR(255),
    headquarters_phone_number INT(12)
);

## FOREIGN KEY constraint (link two table)
# 1. WAY
DROP TABLE sales;
CREATE TABLE sales (
    purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
PRIMARY KEY (purchase_number),
FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE CASCADE
);
# ON DELETE CASCADE == if we remove a row from customer table,it is also be removed from sales table
# 2.WAY
DROP TABLE sales;
CREATE TABLE sales (
    purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
PRIMARY KEY (purchase_number)
);
ALTER TABLE sales
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;
#Deleting foreign key
ALTER TABLE sales
DROP FOREIGN KEY sales_ibfk_1;

DROP TABLE sales;
DROP TABLE customers;
DROP TABLE items;
DROP TABLE companies;

## UNIQUE Constraint
# in a column,variables do not take the same name;they must be unique
# 1. WAY
CREATE TABLE customers (
    customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_adress VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id),
UNIQUE KEY (email_adress)
);
# 2.WAY
DROP TABLE customers;
CREATE TABLE customers (
    customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_adress VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id)
);
ALTER TABLE customers
ADD UNIQUE KEY (email_adress);
# Deleting unique key
ALTER TABLE customers
DROP INDEX email_adress;

DROP TABLE customers;
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_adress VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id)
);
# Adding column to a table
ALTER TABLE customers
ADD COLUMN gender ENUM('M','F') AFTER last_name;
# Adding values to a table
INSERT INTO customers (first_name,last_name,gender,email_adress,number_of_complaints)
VALUES ("John","Mackinley","M","john.mckinley@365careers.com",0);

## DEFAULT Constraint
# changing column property
ALTER TABLE customers
CHANGE COLUMN number_of_complaints number_of_complaints INT DEFAULT 0;

INSERT INTO customers (first_name,last_name,gender)
VALUES ("Peter","Figaro","M");

SELECT * FROM customers;
# remove statement from a column
ALTER TABLE customers
ALTER COLUMN number_of_complaints DROP DEFAULT;

CREATE TABLE companies (
    company_id VARCHAR(255),
    company_name VARCHAR(255) DEFAULT 'X',
    headquarters_phone_number VARCHAR(255),
PRIMARY KEY (company_id),
UNIQUE KEY (headquarters_phone_number)
);
DROP TABLE companies;

## NOT NULL Constraint
CREATE TABLE companies (
    company_id INT AUTO_INCREMENT,
    headquarters_phone_number VARCHAR(255),
    company_name VARCHAR(255) NOT NULL,
PRIMARY KEY (company_id)
);
ALTER TABLE companies
MODIFY company_name VARCHAR(255) NULL;

ALTER TABLE companies
CHANGE COLUMN company_name company_name VARCHAR(255) NOT NULL;

INSERT INTO companies (headquarters_phone_number,company_name)
VALUES ("+1 (202) 555-0196","Company A");

SELECT * FROM companies;

ALTER TABLE companies
MODIFY headquarters_phone_number VARCHAR(255) NULL;

ALTER TABLE companies
CHANGE COLUMN headquarters_phone_number
headquarters_phone_number VARCHAR(255) NOT NULL;
