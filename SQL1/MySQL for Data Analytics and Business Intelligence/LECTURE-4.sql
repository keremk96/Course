# The INSERT statement PART 1
# (ADDING values a table)

use employees;
SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

insert into employees
(
	emp_no,
    birth_date,
    first_name,
    last_name,
    gender,
    hire_date
) values
(
	999901,
    "1986-04-21",
    "John",
    "Smith",
    "M",
    "2021-01-01"
);

# The INSERT statement PART 2

insert into employees
(
    birth_date,
    emp_no,
    first_name,
    last_name,
    gender,
    hire_date
) values
(
    "1973-03-26",
    999902,
    "Patricia",
    "Lawrennce",
    "F",
    "2005-01-01"
);

insert into employees
VALUES
(
	999903,
    "1977-09-14",
    "Johnathan",
    "Creak",
    "M",
    "1999-01-01"
);

SELECT 
    *
FROM
    titles
ORDER BY emp_no DESC
LIMIT 10;

INSERT INTO titles
(
	emp_no,
    title,
    from_date
)
VALUES
(
	"999903",
    "Senior Engineer",
    "1997-10-01"
);

INSERT INTO dept_emp
VALUES
(
	999903,
	"d005",
    "1997-01-10",
    "9999-01-01"
);
 
SELECT 
    *
FROM
    dept_emp
ORDER BY emp_no DESC
LIMIT 10;

# Inserting data INTO a new table

SELECT 
    *
FROM
    departments
LIMIT 10;

CREATE TABLE departments_dup (
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

INSERT INTO departments_dup
(
	dept_no,
    dept_name
)
SELECT 
	*
FROM
	departments;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

INSERT INTO departments
VALUES
(
	"d010",
    "Business Analysis"
);

SELECT 
    *
FROM
    departments;


# The UPDATE Statement PART 1

UPDATE employees 
SET 
    first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE
    emp_no = 999901;
    
SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999901;
    
# The UPDATE Statement - Part 2

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

COMMIT;

UPDATE departments_dup 
SET 
    dept_no = 'd011',
    dept_name = 'Quality Control';

ROLLBACK;
COMMIT;

UPDATE departments 
SET 
    dept_name = 'Data Analysis'
WHERE
    dept_no = 'd010';

SELECT 
    *
FROM
    departments;


# The DELETE Statement - Part I

USE employees;
COMMIT;

SELECT 
    *
FROM
    titles
WHERE
    emp_no = '999903';

DELETE FROM employees 
WHERE
    emp_no = '999903';

ROLLBACK;

# The DELETE Statement - Part II

SELECT 
    *
FROM
    departments_dup;

DELETE FROM departments_dup;

ROLLBACK;

DELETE FROM departments 
WHERE
    dept_no = 'd010';

# DROP vs TRUNCATE vs DELETE


