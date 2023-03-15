USE pagel_2176;
SELECT DATABASE();
SHOW TABLES;

CREATE TEMPORARY TABLE my_numbers (n INT UNSIGNED NOT NULL, name VARCHAR(20) NOT NULL);
SELECT * FROM my_numbers;
USE employees;
CREATE TEMPORARY TABLE pagel_2176.employees_with_departments AS;
	SELECT first_name, last_name, dept_name FROM employees
		LEFT JOIN dept_emp USING (emp_no)
        LEFT JOIN departments USING (dept_no)
        WHERE to_date > NOW();

SELECT * FROM employees_with_departments;

USE pagel_2176;
SHOW TABLES;