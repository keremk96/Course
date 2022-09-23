# Using of SELECT ( * means select all column)
SELECT 
    first_name, last_name
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
    
SELECT 
    *
FROM
    departments;

# Using of WHERE
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';
    
# Usnig of AND
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND gender = 'M';

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' AND gender = 'F';

# Using of OR
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis'
        OR first_name = 'Elvis';
        
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie'
        OR first_name = 'Aruna';

# Operator Precendence (AND > OR)
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

# Using of IN - NOT IN
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

SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis' , 'Elvis');

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');
    
# Using of Like - Not Like
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%ar%');
    
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
    first_name NOT LIKE ('%Mar%');

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

# Wildcard Characters % , _ , *

#Using of BETWEEN.. AND..

SELECT 
    *
FROM
    employees
WHERE
    hire_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT 
    *
FROM
    employees
WHERE
    hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';

SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN '66000' AND '70000';

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
    
# Using of IS NOT NULL - IS NULL
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

SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no IS NOT NULL;

# Other Comparison operators
SELECT 
    *
FROM
    employees
WHERE
    first_name != 'mark';

SELECT 
    *
FROM
    employees
WHERE
    hire_date >= "2000-01-01";

# Select Distinct

SELECT DISTINCT
    gender
FROM
    employees;

#Aggregate Functions (sum-max-min-count-avg)
SELECT 
    COUNT(emp_no)
FROM
    employees;

SELECT 
    COUNT(DISTINCT first_name)
FROM
    employees;

#Order By
SELECT 
    *
FROM
    employees
ORDER BY first_name DESC;

SELECT 
    *
FROM
    employees
ORDER BY first_name,last_name ASC;

#Group By
SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY first_name ;

#Using of Aliases(AS)
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
ORDER BY first_name;

#Having
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) > 200
ORDER BY first_name;

#Where vs Having
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC;

#Limit
SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

# Correct Order
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC
LIMIT 100;







    






