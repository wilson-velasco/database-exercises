-- Find all the current employees with the same hire date as employee 101010 using a subquery.

SELECT emp_no, first_name, last_name FROM employees 
	WHERE hire_date = (
		SELECT hire_date FROM employees
		WHERE emp_no = 101010)
	AND emp_no IN (SELECT emp_no FROM dept_emp WHERE to_date > NOW())
    ORDER BY emp_no;

-- Find all the titles ever held by all current employees with the first name Aamod.

-- (using JOIN)
SELECT t.title FROM titles AS t
	LEFT JOIN employees AS e USING (emp_no)
    LEFT JOIN dept_emp AS de USING (emp_no)
    WHERE e.first_name = 'Aamod' AND de.to_date > NOW()
    GROUP BY t.title;

-- (using subqueries)
SELECT title FROM titles
	WHERE emp_no IN (SELECT emp_no FROM employees WHERE first_name = 'Aamod')
    AND
    emp_no IN (SELECT emp_no FROM dept_emp WHERE to_date > NOW())
    GROUP BY title;

-- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

SELECT * FROM employees
	WHERE emp_no NOT IN 
    (SELECT emp_no FROM dept_emp WHERE to_date > NOW());
    -- 85108, you were supposed to have NOT IN and WHERE to_date > NOW() for an answer of 59900
    -- Eg emp_no 10010 was moved from one department to another in 1999, but his instance prior to 1999 would have been counted
SELECT * FROM dept_emp;


-- Find all the current department managers that are female. List their names in a comment in your code.

SELECT first_name, last_name FROM employees
	WHERE emp_no 
    IN (SELECT emp_no FROM dept_manager WHERE to_date > NOW()) 
    AND gender = 'F';
    -- Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil

-- Find all the employees who currently have a higher salary than the companies overall, historical average salary.

SELECT e.first_name, e.last_name FROM salaries
	RIGHT JOIN employees AS e USING (emp_no)
	WHERE salary > (SELECT AVG(salary) FROM salaries)
    AND to_date > NOW();
    -- COUNT is 154543

/* How many current salaries are within 1 standard deviation of the current highest salary? 
(Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

Hint You will likely use multiple subqueries in a variety of ways
Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. 
You will use this number (or the query that produced it) in other, larger queries. */

SELECT COUNT(*) FROM salaries
	WHERE salary > (SELECT (MAX(salary) - STDDEV(salary)) FROM salaries WHERE to_date > NOW())
    AND to_date > NOW();
    -- 83

SELECT 100*(
	(SELECT COUNT(*) FROM salaries
	WHERE salary > (SELECT (MAX(salary) - STDDEV(salary)) FROM salaries WHERE to_date > NOW())
    AND to_date > NOW())
	/COUNT(salary)) AS percent_1std_from_max 
    FROM salaries WHERE to_date > NOW();
	-- 0.0346%

-- BONUS

-- Find all the department names that currently have female managers.
SELECT dept_name FROM departments
	WHERE dept_no IN 
    (SELECT dept_no FROM dept_manager 
		WHERE emp_no IN 
			(SELECT emp_no FROM employees WHERE gender = 'F') 
		AND to_date > NOW()
	)
    ORDER BY dept_name;

-- Find the first and last name of the employee with the highest salary.
SELECT first_name, last_name FROM employees AS e
	LEFT JOIN salaries AS s USING (emp_no)
	WHERE s.salary = (SELECT MAX(salary) FROM salaries)
    AND s.to_date > NOW()
    AND emp_no IN (SELECT emp_no FROM dept_emp WHERE to_date > NOW());

-- Find the department name that the employee with the highest salary works in.
SELECT dept_name FROM departments
	WHERE dept_no = (SELECT dept_no FROM dept_emp WHERE emp_no = (SELECT emp_no FROM salaries WHERE salary = (SELECT MAX(salary) from salaries) AND to_date > NOW()) AND to_date > NOW());

-- Who is the highest paid employee within each department.

SELECT e.first_name, e.last_name, max_sal.dept_no, max_sal.max_salary FROM -- This one is wrong because it shows Luigi Renear as being in Dept 4. He is in Dept 7.
    (SELECT dept_no, de.to_date, MAX(salary) AS max_salary from employees AS e
	JOIN salaries AS s ON e.emp_no = s.emp_no
    JOIN dept_emp AS de ON e.emp_no = de.emp_no
    GROUP BY dept_no, de.to_date
    ORDER BY dept_no) AS max_sal
    LEFT JOIN salaries AS s ON max_sal.max_salary = s.salary -- This is probably where switching Luigi happened
    LEFT JOIN employees AS e ON e.emp_no = s.emp_no
    WHERE s.to_date > NOW() and max_sal.to_date > NOW()
    ORDER BY max_sal.dept_no;

SELECT e.first_name, e.last_name, s.salary, de.dept_no FROM employees AS e -- This one is right.
	LEFT JOIN salaries AS s USING (emp_no)
    LEFT JOIN dept_emp AS de USING (emp_no)
    WHERE (de.dept_no, s.salary) IN (
		SELECT de.dept_no, MAX(s.salary) AS highest_salary FROM salaries AS s
		JOIN dept_emp AS de USING (emp_no)
        WHERE s.to_date > NOW() AND de.to_date > NOW()
		GROUP BY dept_no)
	ORDER BY dept_no
	;