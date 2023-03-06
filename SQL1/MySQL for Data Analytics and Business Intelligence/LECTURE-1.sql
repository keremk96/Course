#Creating Database
CREATE DATABASE IF NOT EXISTS Sales; # DATABASE == SCHEMA
USE Sales;
#Creating Table
CREATE TABLE sales
(
	purchase_number INT NOT NULL PRIMARY KEY AUTO_INCREMENT,  # AUTO_INCREMENT == (1,2,3,4,..,n)
    date_of_purchase DATE NOT NULL,
    customer_id INT,
    item_code VARCHAR(10) NOT NULL
);

CREATE TABLE customers (
    customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_adress VARCHAR(255),
    number_of_complaints INT
);

# Using databases and tables
SELECT * FROM customers;
SELECT * FROM sales.customers;
SELECT * FROM sales;
SELECT * FROM sales.sales;

DROP TABLE sales; # deleting table
