/* Creating Database */
CREATE DATABASE IF NOT EXISTS Sales;
/* Operating Database */
USE SALES;
/* Creating Table */
CREATE TABLE sales
(
	purchase_number INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date_of_purchase DATE NOT NULL,
    customer_id INT,
    item_code VARCHAR(10) NOT NULL
);

CREATE TABLE customers
(
	customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints int
);
/* Reading inside of Table */
SELECT * FROM customers;
SELECT * FROM sales.customers;
/* Deleting Table */
DROP TABLE sales;
/* Creating Primary Key */
CREATE TABLE sales
(
	purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE, 
    customer_id INT,
    item_code VARCHAR(10),
PRIMARY KEY (purchase_number)
);

DROP TABLE customers;
CREATE TABLE customers
(
	customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints int,
PRIMARY KEY (customer_id)
);

CREATE TABLE items
(
	item_code VARCHAR(255),
    item VARCHAR(255),
    unit_price NUMERIC(10,2),
    company_id VARCHAR(255),
PRIMARY KEY (item_code)
);
/* Adding Foreign Key */
ALTER TABLE sales
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;
/* Deleting Foreign Key (to find name "sales_ibfk_1" , look DDL) */
ALTER TABLE sales
DROP FOREIGN KEY sales_ibfk_1;

DROP TABLE sales;
DROP TABLE customers;
DROP TABLE items;
/* Unique Constraint */
/* Creating Unique Key */
CREATE TABLE customers
(	
	customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id),
UNIQUE KEY (email_address)
);

DROP TABLE customers;
CREATE TABLE customers
(
	customer_id VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
PRIMARY KEY (customer_id)
);

ALTER TABLE customers
ADD UNIQUE KEY (email_address);
/* Deleting Unique Key */
ALTER TABLE customers
DROP INDEX email_address;

DROP TABLE customers;
CREATE TABLE customers
(
	customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id)
);

ALTER TABLE customers
/* Adding Column */
ADD COLUMN gender ENUM('M','F') AFTER last_name;
/* Adding Data */
INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)
VALUES('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0)
;

/* Default Constraint */
/* Changing column */
ALTER TABLE customers
CHANGE COLUMN number_of_complaints number_of_complaints  INT DEFAULT 0;

INSERT INTO customers (first_name,last_name,gender)
VALUES ("Peter","Figaro","M")
;

SELECT * FROM customers;

ALTER TABLE customers
ALTER COLUMN number_of_complaints DROP DEFAULT;

CREATE TABLE companies
(
	company_id VARCHAR(255),
    company_name VARCHAR(255) DEFAULT "X",
    headquaters_phone_number VARCHAR(255) ,
UNIQUE KEY (headquaters_phone_number)
);
DROP TABLE companies;

/* Not Null Constraint */

CREATE TABLE companies
(
	company_id INT AUTO_INCREMENT,
    headquaters_phone_number VARCHAR(255),
    company_name VARCHAR(255) NOT NULL,
PRIMARY KEY (company_id)
);

ALTER TABLE companies
MODIFY company_name VARCHAR(255) NULL;

ALTER TABLE companies
CHANGE COLUMN company_name company_name VARCHAR(255) NOT NULL;

INSERT INTO companies (headquaters_phone_number,company_name)
VALUES ("12323434","Company A");

select * from companies;

ALTER TABLE companies
MODIFY headquarters_phone_number VARCHAR(255) NULL;

ALTER TABLE companies
CHANGE COLUMN headquarters_phone_number headquarters_phone_number VARCHAR(255) NOT NULL;


