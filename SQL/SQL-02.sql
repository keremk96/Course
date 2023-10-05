# Select Statement

USE employees;

SELECT 
    first_name,last_name
FROM
    employees;

SELECT 
    *
FROM
    employees;

SELECT 
    dept_no
FROM
    departments;

# Where

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';

# AND 

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND gender = 'M';

# Or

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis'
        OR first_name = 'Elvis';

# And > Or

SELECT 
    *
FROM
    employees
WHERE
    last_name = 'Denis'
        AND (gender = 'M' OR gender = 'F');

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND (first_name = 'Kellie'
        OR first_name = 'Aruna');

# In - Not In

SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Cathie' , 'Mark', 'Nathan');

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('Cathie' , 'Mark', 'Nathan');

# Like - Not Like

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('ar%');

# ar% = start with ar
# %ar = end with ar 
# %ar% = anywhere ar

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mar_');

SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('%2000%');

SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');
    
# Between - And

SELECT 
    *
FROM
    employees
WHERE
    hire_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;

SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';

SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';

# Is Not Null - Is Null

SELECT 
    *
FROM
    employees
WHERE
    first_name IS NOT NULL;
    
SELECT 
    *
FROM
    employees
WHERE
    first_name IS NULL;

# Other Comparison Operators

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Mark';

SELECT 
    *
FROM
    employees
WHERE
    first_name <> 'Mark';

SELECT 
    *
FROM
    employees
WHERE
    hire_date <> '2000-01-01'
        AND gender = 'F';
	
# Select Distinct

SELECT 
    gender
FROM
    employees;

SELECT DISTINCT
    gender
FROM
    employees;

SELECT DISTINCT
    hire_date
FROM
    employees;

# Aggregate Functions

# Conut

SELECT 
    COUNT(emp_no)
FROM
    employees;

SELECT 
    COUNT(DISTINCT first_name)
FROM
    employees;

SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 10000;

SELECT 
    COUNT(*)
FROM
    dept_manager;

# Order By

SELECT 
    *
FROM
    employees
ORDER BY first_name ASC;

SELECT 
    *
FROM
    employees
ORDER BY first_name DESC;

SELECT 
    *
FROM
    employees
ORDER BY first_name , last_name ASC;

SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

# Group By

SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;

# Using Alliases (AS)

SELECT 
    first_name, COUNT(first_name) AS name_count
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;

SELECT 
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary;

# Having

SELECT 
    first_name, COUNT(first_name) AS count_name
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) > 250
ORDER BY first_name;

SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;

# Where vs Having

SELECT 
    first_name, COUNT(first_name) AS count_name
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC;

SELECT 
    emp_no
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

# Limit

SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

# Aggregate Function

# Count

SELECT 
    COUNT(salary)
FROM
    salaries;

SELECT 
    COUNT(DISTINCT from_date)
FROM
    salaries;

# Sum

SELECT 
    SUM(salary)
FROM
    salaries;

SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

# Min and Max

SELECT 
    MAX(salary)
FROM
    salaries;

SELECT 
    MIN(emp_no)
FROM
    employees;

# Avg

SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

# Round

SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

# Ifnull() and Coalesce()

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

INSERT INTO departments_dup
(
	dept_no
) VALUES
(
	"d010"
),
(	"d011"
);

ALTER TABLE employees.departments_dup
ADD COLUMN dept_maneger VARCHAR(255) NULL AFTER dept_name;

COMMIT;

SELECT 
    dept_no, 
    IFNULL(dept_name,
			'Departmen name not provided') AS dept_name
FROM
    departments_dup;
    
SELECT 
    dept_no, 
    COALESCE(dept_name,
			'Departmen name not provided') AS dept_name
FROM
    departments_dup;

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_maneger, dept_name, 'N/A') AS dept_maneger
FROM
    departments_dup
ORDER BY dept_no ASC;

SELECT 
    dept_no,
    dept_name,
    COALESCE(' deparment manager name ') AS fake_col
FROM
    departments_dup;

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    