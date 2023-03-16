USE pagel_2176;
SELECT DATABASE();
SHOW TABLES;
/* 1. Using the example from the lesson, create a temporary table called employees_with_departments 
that contains first_name, last_name, and dept_name for employees currently with that department. 
Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", 
it means that the query was attempting to write a new table to a database that you can only read. */

USE employees;

CREATE TEMPORARY TABLE pagel_2176.employees_with_departments AS
	SELECT first_name, last_name, dept_name FROM employees
		LEFT JOIN dept_emp USING (emp_no)
        LEFT JOIN departments USING (dept_no)
        WHERE to_date > NOW();

SELECT * FROM pagel_2176.employees_with_departments;

/* a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the 
lengths of the first name and last name columns. */

USE pagel_2176;
ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);
SELECT MAX(CHAR_LENGTH(first_name) + CHAR_LENGTH(last_name)) FROM employees_with_departments; -- To find value to put in VARCHAR (+1 for space)

-- b. Update the table so that the full_name column contains the correct data.

UPDATE employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);

SELECT * FROM pagel_2176.employees_with_departments;

-- c. Remove the first_name and last_name columns from the table.

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

SELECT * FROM employees_with_departments;

-- d. What is another way you could have ended up with this same table?
-- By having created the temporary table with that value in the first place prior to creating the temp table.
-- . I.e. instead of SELECT first_name, last_name, dept_no, I should have had SELECT CONCAT(first_name, ' ', last_name).

/* 2. Create a temporary table based on the payment table from the sakila database.

Write the SQL necessary to transform the amount column such that it is stored as an integer representing 
the number of cents of the payment. For example, 1.99 should become 199. */

USE sakila;
CREATE TEMPORARY TABLE pagel_2176.payment AS (
	SELECT payment_id, customer_id, staff_id, rental_id, REPLACE(amount, '.','') AS amount, payment_date, last_update FROM payment
    );
    
SELECT * FROM pagel_2176.payment;

/* 3. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. 
For this comparison, you will calculate the z-score for each salary. 
In terms of salary, what is the best department right now to work for? The worst? */

USE employees;
CREATE TEMPORARY TABLE pagel_2176.zscore AS (
SELECT emp_no, dept_name, 
        (salary - (SELECT AVG(salary) FROM salaries where to_date > now()))
        /
        (SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
    FROM salaries AS s
    LEFT JOIN dept_emp AS de USING (emp_no)
    LEFT JOIN departments USING (dept_no)
    WHERE s.to_date > NOW() AND de.to_date > NOW()
    );
    
SELECT dept_name, AVG(zscore) AS zscore FROM pagel_2176.zscore
	GROUP BY dept_name
    ORDER BY zscore DESC; -- BEST Sales, WORST Human Resources
    
SELECT * FROM employees.departments;
DROP TABLE pagel_2176.zscore;