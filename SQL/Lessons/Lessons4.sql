# Update
use employees;

SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999901;
  
  
UPDATE employees 
SET 
    first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE
    emp_no = 999901;

# Commit and Rollback
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
    
# Delete
SELECT 
    *
FROM
    titles
WHERE
    emp_no = 999903;

DELETE FROM employees 
WHERE
    emp_no = 999903;

ROLLBACK;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

DELETE FROM departments_dup;

ROLLBACK;

DELETE FROM departments
WHERE
    dept_no = 'd010';

ROLLBACK;