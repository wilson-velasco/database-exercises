USE employees;
/* 
1. Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' 
that is a 1 if the employee is still with the company and 0 if not.
*/

-- Using CASE 

SELECT emp_no, dept_no, hire_date, to_date, 
	CASE to_date
		WHEN '9999-01-01' THEN 'Yes' 
        ELSE 'No'
	END AS 'is_current_employee'
    FROM dept_emp
		JOIN employees USING (emp_no)
    WHERE (emp_no, to_date) IN (SELECT emp_no, MAX(to_date) FROM dept_emp GROUP BY emp_no) -- This needs to be run to remove dups where employee was moved to a diff dept
    ;
    
-- Using IF

SELECT emp_no, dept_no, hire_date, to_date, 
	to_date > NOW() AS 'is_current_employee'
    FROM dept_emp
		JOIN employees USING (emp_no)
	WHERE (emp_no, to_date) IN (SELECT emp_no, MAX(to_date) FROM dept_emp GROUP BY emp_no)
    ;
    
/* Employee counts are below depending whether the additional WHERE statement was run:
                        WHERE exists      WHERE removed
is_current_emp YES       240124				240124
is_current_emp NO		 91479 (wrong)		59900 (correct)
*/ 
	
SELECT emp_no, MAX(to_date) FROM dept_emp GROUP BY emp_no;

-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT first_name, last_name, 
	CASE
		WHEN LEFT(last_name, 1) BETWEEN 'A' AND 'H' THEN 'A-H'
        WHEN LEFT(last_name, 1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
        WHEN LEFT(last_name, 1) BETWEEN 'R' AND 'Z' THEN 'R-Z'
		ELSE 'NA'
        END AS 'alpha_group'
        FROM employees;
        -- COUNT(*) is 300024, which corroborates notes in #1.
        
-- 3. How many employees (current or previous) were born in each decade?

SELECT MIN(birth_date), MAX(birth_date) FROM employees;
    
SELECT
	CASE 
    WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31' THEN '50s'
    WHEN birth_date BETWEEN '1960-01-01' AND '1969-12-31' THEN '60s'
    ELSE 'NA'
    END AS decade_born, COUNT(*) AS num_employees -- Remember you can run aggregate functions on tables where CASE statements are made. 
    FROM employees
    GROUP BY decade_born;

-- 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
USE employees;
SELECT
	CASE 
		WHEN dept_name = 'Research' OR dept_name = 'Development' THEN 'R&D'
        WHEN dept_name = 'Sales' OR dept_name = 'Marketing' THEN 'Sales & Marketing'
        WHEN dept_name = 'Production' OR dept_name = 'Quality Management' THEN 'Prod & QM'
        WHEN dept_name = 'Finance' OR dept_name = 'Human Resources' THEN 'Finance & HR'
        WHEN dept_name = 'Customer Service' THEN 'Customer Service'
        END AS dept_group, AVG(salary)
			FROM salaries AS s
			LEFT JOIN dept_emp AS de USING (emp_no)
			LEFT JOIN departments AS d USING (dept_no)
				WHERE s.to_date > NOW() AND de.to_date > NOW()
			GROUP BY dept_group;
            