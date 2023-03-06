# Aggregate Function

# COUNT()
use employees;

SELECT 
    COUNT(salary)
FROM
    salaries;

SELECT 
    COUNT(DISTINCT from_date)
FROM
    salaries;

SELECT 
    COUNT(DISTINCT emp_no)
FROM
    dept_emp;
    
# SUM()

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

# MIN() and MAX()

SELECT 
    MAX(salary)
FROM
    salaries;

SELECT 
    MIN(salary)
FROM
    salaries;

SELECT 
    MIN(emp_no)
FROM
    employees;

SELECT 
    MAX(emp_no)
FROM
    employees;
# AVG()

SELECT 
    AVG(salary)
FROM
    salaries;

SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

# ROUND()

SELECT 
    ROUND(AVG(salary),2)
FROM
    salaries;

SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries
WHERE
	from_date > "1997-01-01";

# IFNNULL() and COALESCE()

SELECT 
    dept_no, IFNULL(dept_name, 'Deparment name not provided') as dept_name
FROM
    departments_dup;

SELECT 
    dept_no, COALESCE(dept_name, 'Deparment name not provided') as dept_name
FROM
    departments_dup;

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_manager, dept_name, 'N/A') AS dept_manager
FROM
    departments_dup
ORDER BY dept_no ASC;

SELECT 
    dept_no,
    dept_name,
    COALESCE("department manager name") AS fake_col
FROM
    departments_dup;

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no ASC;

SELECT 
    IFNULL(dept_no, 'N/A') AS dept_no,
    IFNULL(dept_name,
            'departmnet name not provided') AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no ASC;


    

