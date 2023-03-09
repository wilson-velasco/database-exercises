/* Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
In your comments, answer: What was the first and last name in the first row of the results? 
What was the first and last name of the last person in the table? */

SELECT * FROM employees WHERE first_name IN ('Irena','Vidya','Maya') 
ORDER BY first_name;
-- Irena Reutenauer and Vidya Simmen

/* Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. 
In your comments, answer: What was the first and last name in the first row of the results? 
What was the first and last name of the last person in the table? */

SELECT * FROM employees WHERE first_name IN ('Irena','Vidya','Maya') 
ORDER BY first_name, last_name;
-- Irena Acton and Vidya Zweizig

/* Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
In your comments, answer: What was the first and last name in the first row of the results? 
What was the first and last name of the last person in the table? */

SELECT * FROM employees WHERE first_name IN ('Irena','Vidya','Maya') 
ORDER BY last_name, first_name;
-- Irena Acton and Maya Zyda

/* Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. 
Enter a comment with the number of employees returned, the first employee number and their first and last name, 
and the last employee number with their first and last name. */

SELECT * FROM employees WHERE last_name LIKE 'e%e' ORDER BY emp_no;
SELECT MIN(emp_no), MAX(emp_no), COUNT(*) FROM employees WHERE last_name LIKE 'e%e' ORDER BY emp_no;
-- 899, 10021 - Ramzi Erde, 499648 - Tadahiro Erde

/* Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, 
so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, 
and the name of the oldest employee. */
SELECT * FROM employees WHERE last_name LIKE 'E%E' ORDER BY hire_date DESC;
SELECT COUNT(*) FROM employees WHERE last_name LIKE 'E%E' ORDER BY hire_date DESC;
-- 899, Teiji Eldridge (newest), Sergi Erde (oldest)

/* Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. 
Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, 
and the name of the youngest employee who was hired first.*/
SELECT * FROM employees WHERE hire_date 
BETWEEN '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25' 
ORDER BY birth_date ASC, hire_date DESC;
SELECT COUNT(*) FROM employees WHERE hire_date 
BETWEEN '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25';
-- 362, Khun Bernini (most recent hire of oldest age), Douadi Pettis (first hire of youngest age)