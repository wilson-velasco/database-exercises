USE employees;
SHOW TABLES;

/* In your script, use DISTINCT to find the unique titles in the titles table. 
How many unique titles have there ever been? Answer that in a comment in your SQL file.*/
SELECT * FROM titles;
SELECT DISTINCT title FROM titles;
SELECT COUNT(DISTINCT title) FROM titles; -- 7 unique titles

-- Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT last_name FROM employees
	WHERE last_name LIKE 'E%E'
    GROUP BY last_name
    ;

-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
USE employees;
SELECT first_name, last_name FROM employees
	WHERE last_name LIKE 'E%E'
    GROUP BY first_name, last_name
    ORDER BY last_name, first_name
    ;

-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT last_name FROM employees
	WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
    GROUP BY last_name
    ;
	-- Chleq, Lindqvist, Qiwen

-- Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
SELECT last_name, COUNT(*) FROM employees
	WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
    GROUP BY last_name
    ;
    -- Chleq (189), Lindqvist (190), Qiwen (168)

/* Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. 
Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.*/

SELECT first_name, gender, COUNT(*) FROM employees
	WHERE first_name IN ('Irena','Vidya','Maya')
    GROUP BY first_name, gender
    ORDER BY first_name
    ;

-- Using your query that generates a username for all of the employees, generate a count employees for each unique username.
SELECT CONCAT(
	LOWER(SUBSTR(first_name,1,1))
	, LOWER(SUBSTR(last_name,1,4))
    , '_' 
    , SUBSTR(birth_date,6,2)
    , SUBSTR(birth_date,3,2)
    ) AS emp_username, COUNT(*)
    FROM employees
    GROUP BY emp_username
    ;

/* From your previous query, are there any duplicate usernames? What is the higest number of times a username shows up? 
Bonus: How many duplicate usernames are there from your previous query?*/
-- SELECT COUNT(*) FROM (    -- uncomment this line and line 73 to get answer to the bonus question.
SELECT CONCAT(
	LOWER(SUBSTR(first_name,1,1))
	, LOWER(SUBSTR(last_name,1,4))
    , '_' 
    , SUBSTR(birth_date,6,2)
    , SUBSTR(birth_date,3,2)
    ) AS emp_username, COUNT(*)
    FROM employees AS username
    GROUP BY emp_username
    HAVING COUNT(*) >1
    ORDER BY COUNT(*) DESC
--     ) AS dup_username_count
    ;
    -- Highest number is 6, total number of usernames that have duplicates: 13,251
    
-- BONUS QUESTIONS -- 

/* Determine the historic average salary for each employee. 
When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column. */
SELECT emp_no, ROUND(AVG(salary),0) AS avg_salary FROM salaries
	GROUP BY emp_no
    ;

/* Using the dept_emp table, count how many current employees work in each department. 
The query result should show 9 rows, one for each department and the employee count. */
SELECT dept_no, COUNT(*) AS total_curr_employees FROM dept_emp
	WHERE to_date >= NOW()
    GROUP BY dept_no
    ;

-- Determine how many different salaries each employee has had. This includes both historic and current.
SELECT emp_no, COUNT(*) AS num_salaries FROM salaries
	GROUP BY emp_no
	;

-- Find the maximum salary for each employee.
SELECT emp_no, MAX(salary) AS max_salary FROM salaries
	GROUP BY emp_no
    ;

-- Find the minimum salary for each employee.
SELECT emp_no, MIN(salary) AS min_salary FROM salaries
	GROUP BY emp_no
    ;

-- Find the standard deviation of salaries for each employee.
SELECT emp_no, STDDEV(salary) std_salary FROM salaries
	GROUP BY emp_no;

-- Now find the max salary for each employee where that max salary is greater than $150,000.
SELECT emp_no, MAX(salary) AS max_salary FROM salaries
	GROUP BY emp_no
    HAVING max_salary > 150000
    ORDER BY max_salary DESC
    ;

-- Find the average salary for each employee where that average salary is between $80k and $90k.
SELECT emp_no, AVG(salary) AS avg_salary FROM salaries
	GROUP BY emp_no
    HAVING avg_salary BETWEEN 80000 AND 90000
    ORDER BY avg_salary DESC
    ;