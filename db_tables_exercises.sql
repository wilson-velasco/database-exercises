-- Question 3
SHOW DATABASES;

-- Question 4
USE albums_db;

-- Question 5
SELECT DATABASE();

-- Question 6
SHOW TABLES;

-- Question 7
USE employees;

-- Question 8
SELECT DATABASE();

-- Question 9
SHOW TABLES;

-- Question 10
SELECT * FROM employees;
/* Question 11: Which table(s) do you think contain a numeric type column?

Technically, all tables would contain numeric type columns
since a PRIMARY KEY is necessary and contains auto-incremented integers, but the ones that
would contain numeric columns outside of those PRIMARY KEYS would be
EMPLOYEES, containing emp id numbers, maybe dept numbers, and SALARIES, containing
annual_salary probably.*/

/* Question 12: Which table(s) do you think contain a string type column? 

All tables with the exception of perhaps salaries would contain
string-type columns, since datatype TEXT is necessary for names, titles, dept names
etc. SALARIES table may be the only one that only contains maybe a numeric emp_id column and
a (numeric) salary column.*/

/* Question 13: Which table(s) do you think contain a date type column? 
Only because I already looked, but EMPLOYEES would contain a date
type column for birthdates and hiredates. Maybe SALARIES might have a date type column to show
effective date of a salary change.*/

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM dept_emp;
/* Question 14: What is the relationship between the employees and the departments tables?
There is no inherent column within EMPLOYEES or DEPARTMENTS that 
connect the two tables, but there is a separate table, DEPT_EMP, that does combine
elements from both tables, associating EMP_NO with DEPT_NO.*/

SHOW CREATE TABLE dept_manager;
/* Question 15: Show the SQL that created the dept_manager table.
CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1
*/
