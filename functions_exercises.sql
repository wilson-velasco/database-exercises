USE employees;

/* Write a query to to find all employees whose last name starts and ends with 'E'. 
Use concat() to combine their first and last name together as a single column named full_name.*/
SELECT * FROM employees WHERE last_name LIKE 'E%E';
SELECT CONCAT(first_name, ' ', last_name) AS full_name
	FROM employees WHERE last_name LIKE 'E%E';


-- Convert the names produced in your last query to all uppercase.
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
	FROM employees WHERE last_name LIKE 'E%E';

-- Use a function to determine how many results were returned from your previous query.
SELECT COUNT(*) FROM employees WHERE last_name LIKE 'E%E';

/* Find all employees hired in the 90s and born on Christmas. 
Use datediff() function to find how many days they have been working at the company 
(Hint: You will also need to use NOW() or CURDATE()),*/
SELECT *, datediff(NOW(),hire_date) AS total_working_days FROM employees 
	WHERE hire_date LIKE '199%' 
	AND birth_date LIKE '%-12-25';


-- Find the smallest and largest current salary from the salaries table.
SELECT MAX(salary), MIN(salary) FROM salaries
	WHERE to_date > NOW();

-- (the below is to include names)

SELECT first_name, last_name, salary FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE salary IN (
 (SELECT MIN(salary) FROM salaries WHERE to_date > NOW()),
 (SELECT MAX(salary) FROM salaries WHERE to_date > NOW()));

/* Use your knowledge of built in SQL functions to generate a username for all of the employees. 
A username should be all lowercase, and consist of the first character of the employees first name, 
the first 4 characters of the employees last name, an underscore, the month the employee was born, 
and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like: */
SELECT CONCAT(
	LOWER(SUBSTR(first_name,1,1))
	, LOWER(SUBSTR(last_name,1,4))
    , '_' 
    , SUBSTR(birth_date,6,2)
    , SUBSTR(birth_date,3,2)
    ) AS emp_username
    FROM employees;