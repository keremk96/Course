# Common Table Expression

# Common Table Expressions - Introduction

WITH cte AS(
SELECT AVG(salary) AS avg_salary FROM salaries)
SELECT
SUM(CASE WHEN s.salary > c.avg_salary THEN 1 ELSE 0 END) AS no_f_salaries_above_avg,
COUNT(s.salary) AS total_no_of_contracts
FROM
	salaries s
		JOIN
	employees e on s.emp_no = e.emp_no AND e.gender = "F"
		CROSS JOIN
	cte c;

WITH cte AS(
SELECT AVG(salary) AS avg_salary FROM salaries)
SELECT 
	*
FROM
	salaries s
		JOIN
	cte c;

WITH cte AS(
SELECT AVG(salary) AS avg_salary FROM salaries)
SELECT 
	*
FROM
	salaries s
		JOIN
	employees e ON s.emp_no = e.emp_no AND e.gender = "F"
		JOIN
	cte c;

WITH cte AS(
SELECT AVG(salary) AS avg_salary FROM salaries)
SELECT 
	*
FROM
	salaries s
		JOIN
	employees e ON s.emp_no = e.emp_no AND e.gender = "F"
		CROSS JOIN
	cte c;
    
# Using Multiple Subclauses in a WITH Clause

WITH cte1 AS(
SELECT AVG(salary) AS avg_salary from salaries
),
cte2 AS(
SELECT s.emp_no, MAX(s.salary) AS f_highest_salary
FROM salaries s
JOIN employees e ON e.emp_no = s.emp_no AND e.gender = "F"
GROUP BY s.emp_no
)
SELECT
SUM(CASE WHEN c2.f_highest_salary > c1.avg_salary THEN 1 ELSE 0 END) AS f_highest_salaries_above_avg,
COUNT(e.emp_no) AS total_no_female_contracts
FROM employees e
JOIN cte2 c2 ON c2.emp_no = e.emp_no
CROSS JOIN cte1 c1;

WITH cte1 AS(
SELECT AVG(salary) AS avg_salary from salaries
),
cte2 AS(
SELECT s.emp_no, MAX(s.salary) AS f_highest_salary
FROM salaries s
JOIN employees e ON e.emp_no = s.emp_no AND e.gender = "F"
GROUP BY s.emp_no
)
SELECT
COUNT(CASE WHEN c2.f_highest_salary > c1.avg_salary THEN c2.f_highest_salary ELSE NULL END) AS f_highest_salaries_above_avg,
COUNT(e.emp_no) AS total_no_female_contracts
FROM employees e
JOIN cte2 c2 ON c2.emp_no = e.emp_no
CROSS JOIN cte1 c1;

# Using Multiple Subclauses in a WITH Clause

WITH cte_avg_salary AS(
SELECT AVG(salary) AS avg_salary from salaries
),
cte_f_highest_salary AS(
SELECT s.emp_no, MAX(s.salary) AS f_highest_salary
FROM salaries s
JOIN employees e ON e.emp_no = s.emp_no AND e.gender = "F"
GROUP BY s.emp_no
)
SELECT
SUM(CASE WHEN c2.f_highest_salary > c1.avg_salary THEN 1 ELSE 0 END) AS f_highest_salaries_above_avg,
COUNT(e.emp_no) AS total_no_female_contracts,
CONCAT(ROUND((SUM(CASE WHEN c2.f_highest_salary > c1.avg_salary THEN 1 ELSE 0 END ) / COUNT(e.emp_no)) * 100, 2), "% percentage") AS "% percentage"
FROM employees e
JOIN cte_f_highest_salary c2 ON c2.emp_no = e.emp_no
CROSS JOIN cte_avg_salary c1;

# Temporary Tables

# Temporary Tables in Action

CREATE TEMPORARY TABLE f_highest_salaries
SELECT
	s.emp_no, MAX(s.salary) AS f_highest_salary
FROM 
	salaries s
		JOIN
	employees e ON e.emp_no = s.emp_no AND e.gender = "F"
GROUP BY s.emp_no;

SELECT 
    *
FROM
    f_highest_salaries;
    
DROP TEMPORARY TABLE IF EXISTS f_highest_salaries;

# Other Features of MySQL Temporary Tables

CREATE TEMPORARY TABLE f_highest_salaries
SELECT
	s.emp_no, MAX(s.salary) AS f_highest_salary
FROM 
	salaries s
		JOIN
	employees e ON e.emp_no = s.emp_no AND e.gender = "F"
GROUP BY s.emp_no
LIMIT 10;

WITH cte AS (SELECT
	s.emp_no, MAX(s.salary) AS f_highest_salary
FROM 
	salaries s
		JOIN
	employees e ON e.emp_no = s.emp_no AND e.gender = "F"
GROUP BY s.emp_no
LIMIT 10)
SELECT * FROM f_highest_salaries f1 JOIN cte c;

WITH cte AS (SELECT
	s.emp_no, MAX(s.salary) AS f_highest_salary
FROM 
	salaries s
		JOIN
	employees e ON e.emp_no = s.emp_no AND e.gender = "F"
GROUP BY s.emp_no
LIMIT 10)
SELECT * FROM f_highest_salaries  UNION ALL SELECT * FROM cte;

CREATE TEMPORARY TABLE dates
SELECT 
	NOW() AS current_date_and_time,
    DATE_SUB(NOW(), INTERVAL 1 MONTH) AS a_month_earlier,
    DATE_SUB(NOW(), INTERVAL -1 YEAR) AS a_year_later;

SELECT 
    *
FROM
    dates;

WITH cte AS (SELECT 
	NOW() AS current_date_and_time,
    DATE_SUB(NOW(), INTERVAL 1 MONTH) AS a_month_earlier,
    DATE_SUB(NOW(), INTERVAL -1 YEAR) AS a_year_later)
SELECT * FROM dates d1 JOIN cte c1;

WITH cte AS (SELECT 
	NOW() AS current_date_and_time,
    DATE_SUB(NOW(), INTERVAL 1 MONTH) AS a_month_earlier,
    DATE_SUB(NOW(), INTERVAL -1 YEAR) AS a_year_later)
SELECT * FROM dates  UNION ALL SELECT * FROM cte;

DROP TABLE IF EXISTS f_highest_salaries;
DROP TEMPORARY TABLE IF EXISTS dates;













































