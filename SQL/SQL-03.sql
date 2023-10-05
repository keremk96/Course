
# Insert Statement

USE employees;

INSERT INTO employees
( 
	emp_no,
    birth_date,
    first_name,
    last_name,
    gender,
    hire_date
) VALUES 
( 
	999901, 
    "1986-04-21", 
    "John", 
    "Smith", 
    "M", 
    "2021-01-01"
);

INSERT INTO employees
(
	birth_date,
    emp_no,
    first_name,
    last_name,
    gender,
    hire_date
) VALUES
(
	"1973-03-26",
    999902,
    "Patricia",
    "Lawrennce",
    "F",
    "2005-01-01"
);

INSERT INTO employees
VALUES
(
	999903,
    "1977-09-14",
    "Johnathan",
    "Creak",
    "M",
    "1999-01-01"
);

INSERT INTO titles
(
	emp_no,
    title,
    from_date
) VALUES
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

# Inserting Data Into a New Table

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

INSERT INTO departments
VALUES
(
	"d010",
    "Business Analysis"
);

# The Update Statement

UPDATE employees 
SET 
    first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE
    emp_no = 999901;

COMMIT;

UPDATE departments_dup 
SET 
    dept_no = 'd011',
    dept_name = 'Quality Control';
    
ROLLBACK;

# The Delete Statement

COMMIT;

DELETE FROM employees 
WHERE
    emp_no = '999903';

ROLLBACK;

DELETE FROM departments_dup
WHERE
	dept_no = "d010";






	