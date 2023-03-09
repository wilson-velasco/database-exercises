USE employees;
SELECT DATABASE();
SHOW TABLES;
SELECT * FROM employees;
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. What is the employee number 
-- of the top three results?
SELECT * FROM employees WHERE first_name IN ('Irena','Vidya','Maya') LIMIT 3;
-- First three emp numbers are 10200, 10397, 10610.

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. 
-- What is the employee number of the top three results? Does it match the previous question?\
SELECT * FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya' LIMIT 3;
-- First three emp numbers are 10200, 10397, 10610. They ARE the same numbers as Q1.

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. 
-- What is the employee number of the top three results.
SELECT * FROM employees WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender = 'M' LIMIT 3;
-- First three emp numbers are 10200, 10397, 10821.

-- Find all unique last names that start with 'E'.
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE 'E%';

-- Find all unique last names that start or end with 'E'.
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE 'E%' OR last_name LIKE '%e';

-- Find all unique last names that end with E, but does not start with E?
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE '%E' AND last_name NOT LIKE 'E%';

-- Find all unique last names that start and end with 'E'.
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE 'E%E';

-- Find all current or previous employees hired in the 90s. Enter a comment with top three employee numbers.
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' LIMIT 3;
-- Top three emp numbers are 10008, 10011, 10012.

-- Find all current or previous employees born on Christmas. Enter a comment with top three employee numbers.
SELECT * FROM employees WHERE birth_date LIKE '%-12-25' LIMIT 3;
-- Top three emp numbers are 10078, 10115, 10261.

-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with top three employee numbers.
SELECT * FROM employees WHERE 
(hire_date BETWEEN '1990-01-01' AND '1999-12-31') 
AND 
birth_date LIKE '%-12-25' LIMIT 3;
-- Top three emp numbers are 10261, 10438, 10681.

-- Find all unique last names that have a 'q' in their last name.
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE '%q%';

-- Find all unique last names that have a 'q' in their last name but not 'qu'.
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';