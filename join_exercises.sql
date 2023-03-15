USE join_example_db;
SHOW TABLES;
-- Use the join_example_db. Select all the records from both the users and roles tables.
SELECT * FROM roles;
SELECT * FROM users;

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
-- Before you run each query, guess the expected number of results.
SELECT * FROM roles
	JOIN users ON roles.id = users.role_id;
SELECT * FROM roles
	LEFT JOIN users ON roles.id = users.role_id;
SELECT * FROM roles
	RIGHT JOIN users ON roles.id = users.role_id;
SELECT * FROM roles
	LEFT JOIN users ON roles.id = users.role_id
UNION 
SELECT * FROM roles
	RIGHT JOIN users ON roles.id = users.role_id;

/* Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
Hint: You will also need to use group by in the query. */

SELECT roles.name, COUNT(users.name) FROM roles -- need to explicitly state users.name otherwise it would count commenters as 1, since it counts the nulls (even though no users are commenters)
	LEFT JOIN users ON roles.id = users.role_id
    GROUP BY roles.name;

-- Use the employees database.

USE employees;

-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department
-- along with the name of the current manager for that department.

SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM dept_manager AS dm
	JOIN employees ON dm.emp_no = employees.emp_no
    JOIN departments ON dm.dept_no = departments.dept_no
	WHERE dm.to_date > NOW()
    ORDER BY dept_name;

-- Find the name of all departments currently managed by women.
SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM dept_manager AS dm
	JOIN employees ON dm.emp_no = employees.emp_no
    JOIN departments ON dm.dept_no = departments.dept_no
	WHERE dm.to_date > NOW() AND gender = 'F'
    ORDER BY dept_name;

-- Find the current titles of employees currently working in the Customer Service department.
SELECT title, COUNT(*) FROM titles AS t
    JOIN dept_emp AS de ON t.emp_no = de.emp_no
	JOIN departments AS d ON d.dept_no = de.dept_no
    WHERE t.to_date > NOW() AND de.to_date > NOW() AND d.dept_name = 'Customer Service'
    GROUP BY title
    ORDER BY title
;

-- Find the current salary of all current managers.
SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Name', salary AS 'Salary' FROM salaries AS s
	JOIN dept_emp AS de ON s.emp_no = de.emp_no
    JOIN dept_manager AS dm ON de.emp_no = dm.emp_no
    JOIN employees AS e ON dm.emp_no = e.emp_no
    JOIN departments AS d ON dm.dept_no = d.dept_no
	WHERE s.to_date > NOW() AND dm.to_date > NOW()
    ORDER BY dept_name
    ;

-- Find the number of current employees in each department.
SELECT de.dept_no, d.dept_name, COUNT(de.emp_no) AS num_employees FROM dept_emp AS de
	JOIN departments AS d ON de.dept_no = d.dept_no
	WHERE de.to_date > NOW()
    GROUP BY de.dept_no
    ORDER BY de.dept_no;

-- Which department has the highest average salary? Hint: Use current not historic information.
SELECT d.dept_name, ROUND(AVG(salary), 2) AS average_salary FROM salaries AS s
	JOIN dept_emp AS de ON s.emp_no = de.emp_no
    JOIN departments AS d ON de.dept_no = d.dept_no
	WHERE s.to_date > NOW() AND de.to_date > NOW()
    GROUP BY d.dept_name
    ORDER BY average_salary DESC
    LIMIT 1;

-- Who is the highest paid employee in the Marketing department?
SELECT first_name, last_name FROM employees AS e
	JOIN dept_emp AS de ON e.emp_no = de.emp_no
    JOIN departments AS d ON de.dept_no = d.dept_no
    JOIN salaries AS s ON e.emp_no = s.emp_no
	WHERE s.to_date > NOW() AND de.to_date > NOW() AND d.dept_name = 'Marketing'
    ORDER BY salary DESC
    LIMIT 1
    ;

-- Which current department manager has the highest salary?
SELECT e.first_name, e.last_name, s.salary, d.dept_name FROM employees AS e
	JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
    JOIN salaries AS s ON e.emp_no = s.emp_no
    JOIN departments AS d ON dm.dept_no = d.dept_no
    WHERE dm.to_date > NOW() AND s.to_date > NOW()
    ORDER BY s.salary DESC
    LIMIT 1
    ;

-- Determine the average salary for each department. Use all salary information and round your results.
SELECT dept_name, ROUND(AVG(salary), 0) AS average_salary FROM salaries AS s
	JOIN dept_emp AS de ON s.emp_no = de.emp_no
    JOIN departments AS d ON de.dept_no = d.dept_no
    GROUP BY dept_name
    ORDER BY average_salary DESC;

-- Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name', dept_name AS 'Department Name', 
CONCAT(e2.first_name, ' ', e2.last_name) AS 'Manager Name' 
	FROM employees AS e
    JOIN dept_emp AS de ON e.emp_no = de.emp_no
    JOIN departments AS d ON de.dept_no = d.dept_no
    JOIN dept_manager AS dm ON de.dept_no = dm.dept_no
    JOIN employees AS e2 ON dm.emp_no = e2.emp_no
    WHERE de.to_date > NOW() AND dm.to_date > NOW()
    ORDER BY dept_name, e.emp_no
    ;

-- Bonus Who is the highest paid employee within each department.

SELECT e.first_name, e.last_name, max_sal.dept_no, max_sal.max_salary FROM 
    (SELECT dept_no, de.to_date, MAX(salary) AS max_salary from employees AS e
	JOIN salaries AS s ON e.emp_no = s.emp_no
    JOIN dept_emp AS de ON e.emp_no = de.emp_no
    GROUP BY dept_no, de.to_date
    ORDER BY dept_no) AS max_sal
    LEFT JOIN salaries AS s ON max_sal.max_salary = s.salary
    LEFT JOIN employees AS e ON e.emp_no = s.emp_no
    WHERE s.to_date > NOW() and max_sal.to_date > NOW()
    ORDER BY max_sal.dept_no;