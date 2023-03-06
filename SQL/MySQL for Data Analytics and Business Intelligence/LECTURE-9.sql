# Stored Routines
USE employees;
#Stored Procedures

DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
SELECT * FROM employees
LIMIT 1000;
END$$

DELIMITER ;

call employees.select_employees();
call select_employees();

DELIMITER $$
CREATE PROCEDURE avg_salary()
BEGIN

select avg(salary) from salaries;

END$$
DELIMITER ;

call avg_salary;
call avg_salary();
call employees.avg_salary;
call employees.avg_salary();

# Srored Procedure with an input Parameter

DROP procedure IF EXISTS emp_salary;
DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
SELECT 
    e.first_name, e.last_name, s.salary, s.from_date, s.to_date
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
END$$

DELIMITER ;

DROP procedure IF EXISTS emp_avg_salary;
DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN
SELECT 
    e.first_name, e.last_name, AVG(s.salary)
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
END$$

DELIMITER ;

call emp_avg_salary(11300);

# Stored procedure with an output Parameter

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER,out p_avg_salary DECIMAL(10,2))
BEGIN
SELECT 
    AVG(s.salary)
INTO p_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
END$$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)
BEGIN

SELECT 
    e.emp_no
INTO p_emp_no FROM
    employees e
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;

END$$
DELIMITER ;

# Variables

SET @v_avg_salary = 0;
CALL employees.emp_avg_salary_out(11300,@v_avg_salary);
SELECT @v_avg_salary;

SET @v_emp_no=0;
CALL emp_info("Aruna","Journel",@v_emp_no);
SELECT @v_emp_no;

# User-Defined Functions

DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN

declare v_avg_salary decimal(10,2);

SELECT 
    AVG(s.salary)
INTO v_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;

RETURN v_avg_salary;
END$$

DELIMITER ;

SELECT f_emp_avg_salary(11300);

DELIMITER $$
CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN



                DECLARE v_max_from_date date;



    DECLARE v_salary decimal(10,2);



SELECT

    MAX(from_date)

INTO v_max_from_date FROM

    employees e

        JOIN

    salaries s ON e.emp_no = s.emp_no

WHERE

    e.first_name = p_first_name

        AND e.last_name = p_last_name;



SELECT

    s.salary

INTO v_salary FROM

    employees e

        JOIN

    salaries s ON e.emp_no = s.emp_no

WHERE

    e.first_name = p_first_name

        AND e.last_name = p_last_name

        AND s.from_date = v_max_from_date;

       

                RETURN v_salary;



END$$

DELIMITER ;

SELECT EMP_INFO('Aruna', 'Journel');




