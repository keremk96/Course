# MySQL Window Functions
USE employees;
# The ROW_NUMBER() Ranking Window Function

SELECT 
    emp_no, 
    salary,
    ROW_NUMBER() OVER() AS row_num
FROM
    salaries;
    
SELECT 
    emp_no, 
    salary,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num
FROM
    salaries;
    
SELECT
    emp_no,
    dept_no,
    ROW_NUMBER() OVER (ORDER BY emp_no) AS row_num
FROM
	dept_manager;

SELECT
	emp_no,
	first_name,
	last_name,
	ROW_NUMBER() OVER (PARTITION BY first_name ORDER BY last_name) AS row_num
FROM
	employees;

# Using Several Window Functions in a Query

select 
	emp_no,
    salary,
	row_number() over () as row_num1,
	row_number() over (partition by emp_no) as row_num2,
	row_number() over (partition by emp_no order by salary desc) as row_num3,
	row_number() over (order by salary desc) as row_num4
 from salaries
 ORDER BY emp_no,salary;
 

select 
	emp_no,
    salary,
	row_number() over (partition by emp_no) as row_num2,
	row_number() over (partition by emp_no order by salary desc) as row_num3
 from salaries;
 

SELECT
	dm.emp_no,
    salary,
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary ASC) AS row_num1,
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num2   
FROM
dept_manager dm
    JOIN 
    salaries s ON dm.emp_no = s.emp_no;

SELECT
	dm.emp_no,
    salary,
    ROW_NUMBER() OVER () AS row_num1,
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num2
FROM
dept_manager dm
    JOIN 
    salaries s ON dm.emp_no = s.emp_no
ORDER BY row_num1, emp_no, salary ASC;

# Window Functions Syntax

SELECT 
    emp_no, 
    salary,
    ROW_NUMBER() OVER w  AS row_num
FROM
    salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

SELECT
	emp_no,
	first_name,
	ROW_NUMBER() OVER w AS row_num
FROM
	employees
WINDOW w AS (PARTITION BY first_name ORDER BY emp_no);

# The PARTITION BY Clause VS the GROUP BY Clause

SELECT a.emp_no,

       MIN(salary) AS min_salary FROM (

SELECT

emp_no, salary, ROW_NUMBER() OVER w AS row_num

FROM

salaries

WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a

GROUP BY emp_no;


SELECT a.emp_no,

       MIN(salary) AS min_salary FROM (

SELECT

emp_no, salary, ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary) AS row_num

FROM

salaries) a

GROUP BY emp_no;

SELECT

    a.emp_no, MIN(salary) AS min_salary

FROM

    (SELECT

        emp_no, salary

    FROM

        salaries) a

GROUP BY emp_no;

SELECT a.emp_no,

a.salary as min_salary FROM (

SELECT

emp_no, salary, ROW_NUMBER() OVER w AS row_num

FROM

salaries

WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a

WHERE a.row_num=1;


SELECT a.emp_no,

a.salary as min_salary FROM (

SELECT

emp_no, salary, ROW_NUMBER() OVER w AS row_num

FROM

salaries

WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a

WHERE a.row_num=2;

# RANK() and DENSE_RANK() Window Functions

select 
	emp_no,salary,rank() over w as rank_num
from  
	salaries 
where emp_no = 11839
window w as (partition by emp_no order by salary desc);

select 
	emp_no,salary,dense_rank() over w as rank_num
from  
	salaries 
where emp_no = 11839
window w as (partition by emp_no order by salary desc);

SELECT

emp_no,

salary,

ROW_NUMBER() OVER w AS row_num

FROM

salaries

WHERE emp_no = 10560

WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);


SELECT

    dm.emp_no, (COUNT(salary)) AS no_of_salary_contracts

FROM

    dept_manager dm

        JOIN

    salaries s ON dm.emp_no = s.emp_no

GROUP BY emp_no

ORDER BY emp_no;



SELECT

emp_no,

salary,

RANK() OVER w AS rank_num

FROM

salaries

WHERE emp_no = 10560

WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);



SELECT

emp_no,

salary,

DENSE_RANK() OVER w AS rank_num

FROM

salaries

WHERE emp_no = 10560

WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

# Working with MySQL Ranking Window Functions and Joins Together

USE employees;

SELECT
	d.dept_no,
    d.dept_name,
    dm.emp_no,
    RANK() OVER w AS department_salary_ranking,
    s.salary,
    s.from_date AS salary_from_date,
    s.to_date AS salary_to_date,
    dm.from_date AS dept_managet_from_date,
    dm.to_date AS ept_managet_to_date
FROM 
	dept_manager dm
		JOIN
	salaries s ON s.emp_no = dm.emp_no
		AND s.from_date BETWEEN dm.from_date AND dm.to_date
        AND s.to_date BETWEEN dm.from_date AND dm.to_date
		JOIN
	departments d ON d.dept_no = dm.dept_no 
WINDOW w AS (PARTITION BY dm.dept_no ORDER BY s.salary DESC);

SELECT

    e.emp_no,

    RANK() OVER w as employee_salary_ranking,

    s.salary

FROM

employees e

JOIN

    salaries s ON s.emp_no = e.emp_no

WHERE e.emp_no BETWEEN 10500 AND 10600

WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);


SELECT

    e.emp_no,

    DENSE_RANK() OVER w as employee_salary_ranking,

    s.salary,

    e.hire_date,

    s.from_date,

    (YEAR(s.from_date) - YEAR(e.hire_date)) AS years_from_start

FROM

employees e

JOIN

    salaries s ON s.emp_no = e.emp_no

    AND YEAR(s.from_date) - YEAR(e.hire_date) >= 5

WHERE e.emp_no BETWEEN 10500 AND 10600

WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);

# The LAG() and LEAD() Value Window Functions

SELECT
		
        emp_no,
        salary,
        LAG(salary) OVER w AS previous_salary,
		lEAD(salary) OVER w AS next_salary,
        salary - LAG(salary) OVER w AS diff_salary_current_previous,
        lEAD(salary) OVER w - salary AS diff_salary_next_current
FROM 
		
        salaries
WHERE emp_no = 10001
WINDOW w AS 	(ORDER BY salary);

SELECT

emp_no,

    salary,

    LAG(salary) OVER w AS previous_salary,

    LEAD(salary) OVER w AS next_salary,

    salary - LAG(salary) OVER w AS diff_salary_current_previous,

LEAD(salary) OVER w - salary AS diff_salary_next_current

FROM

salaries

    WHERE salary > 80000 AND emp_no BETWEEN 10500 AND 10600

WINDOW w AS (PARTITION BY emp_no ORDER BY salary);


SELECT

emp_no,

    salary,

    LAG(salary) OVER w AS previous_salary,

LAG(salary, 2) OVER w AS 1_before_previous_salary,

LEAD(salary) OVER w AS next_salary,

    LEAD(salary, 2) OVER w AS 1_after_next_salary

FROM

salaries

WINDOW w AS (PARTITION BY emp_no ORDER BY salary)

LIMIT 1000;

        
		
