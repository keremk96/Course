# MySQL Window Functions

# The ROW_NUMBER() Ranking Window Function and the Relevant MySQL Syntax

SELECT
	emp_no, 
    salary, 
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num
FROM
	salaries;

SELECT
	emp_no, 
    salary, 

    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num 
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

# A Note on Using Several Window Functions in a Query

SELECT

	emp_no,
    salary,
    ROW_NUMBER() OVER() AS row_num1,
    ROW_NUMBER() OVER(PARTITION BY emp_no) AS row_num2,
    ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num3,
    ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num4
    
FROM	
	salaries
ORDER BY emp_no, salary;

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

# MySQL Window Functions Syntax

SELECT
	emp_no, 
    salary, 
    ROW_NUMBER() OVER w AS row_num
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

# The MySQL RANK() and DENSE_RANK() Window Functions

SELECT
	emp_no, salary,ROW_NUMBER() OVER w AS row_num
FROM  
	salaries 
WHERE emp_no = 11839 
WINDOW W AS (PARTITION BY emp_no ORDER BY salary DESC);

SELECT
	emp_no, salary,RANK() OVER w AS rank_num
FROM  
	salaries 
WHERE emp_no = 11839 
	WINDOW W AS (PARTITION BY emp_no ORDER BY salary DESC);

SELECT
	emp_no, salary,DENSE_RANK() OVER w AS row_num
FROM  
	salaries 
WHERE emp_no = 11839 
WINDOW W AS (PARTITION BY emp_no ORDER BY salary DESC);

# Working with MySQL Ranking Window Functions and Joins Together

SELECT
	d.dept_no,
    d.dept_name,
    dm.emp_no,
    RANK() OVER w AS department_salary_ranking,
    s.salary,
    s.from_date AS salary_from_date,
    s.to_date AS salary_to_date,
    dm.from_date AS dept_manager_from_date,
    dm.to_date AS dept_manager_to_date
FROM 
	dept_manager dm
		JOIN
	salaries s ON s.emp_no = dm.emp_no
		AND s.from_date BETWEEN dm.from_date AND dm.to_date
        AND s.to_date BETWEEN dm.from_date AND dm.to_date
		JOIN
	departments d ON d.dept_no = dm.dept_no
WINDOW w AS (PARTITION BY dm.dept_no ORDER BY s.salary DESC);

#  The LAG() and LEAD() Value Window Functions

SELECT
	emp_no,
    salary,
    LAG(salary) OVER w AS previous_salary,
    LEAD(salary) OVER w AS next_salary,
    salary - LAG(salary) OVER w AS diff_salary_current_previous,
    LEAD(salary) OVER w - salary AS diff_salary_next_current
FROM
	salaries
WHERE emp_no = 10001
WINDOW w AS (ORDER BY salary);

# Aggregate Functions in the Context of Window Functions

SELECT SYSDATE();

SELECT
	s1.emp_no, s.salary, s.from_date, s.to_date
FROM
	salaries s
		JOIN
	(SELECT
		emp_no, MAX(from_date) AS from_date
	FROM
		salaries
	GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
	s.to_date > SYSDATE()
		AND s.from_date = s1.from_date;

SELECT
	de.emp_no, de.dept_no, de.from_date, de.to_date
FROM
	dept_emp de
		JOIN
	(SELECT
		emp_no, MAX(from_date) AS from_date
	FROM
		dept_emp
	GROUP BY emp_no) de1 ON de1.emp_no = de.emp_no
WHERE
	de.to_date > SYSDATE()
			AND de.from_date = de1.from_date;

SELECT
	de2.emp_no, d.dept_name, s2.salary, AVG(s2.salary) OVER w AS average_salary_per_department
FROM
	(SELECT
	de.emp_no, de.dept_no, de.from_date, de.to_date
FROM
	dept_emp de
		JOIN
	(SELECT
		emp_no, MAX(from_date) AS from_date
	FROM
		dept_emp
	GROUP BY emp_no) de1 ON de1.emp_no = de.emp_no
WHERE
	de.to_date > SYSDATE()
			AND de.from_date = de1.from_date) de2
			JOIN
		(SELECT
	s1.emp_no, s.salary, s.from_date, s.to_date
FROM
	salaries s
		JOIN
	(SELECT
		emp_no, MAX(from_date) AS from_date
	FROM
		salaries
	GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
	s.to_date > SYSDATE()
		AND s.from_date = s1.from_date) s2 ON s2.emp_no = de2.emp_no
			JOIN
		departments d ON d.dept_no = de2.dept_no
	GROUP BY de2.emp_no, d.dept_name
    WINDOW w AS (PARTITION BY de2.dept_no)
    ORDER BY de2.emp_no;



























