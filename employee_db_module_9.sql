CREATE TABLE titles (
    title_id VARCHAR   NOT NULL,
    title VARCHAR   NOT NULL,
    PRIMARY KEY (title_id)
);

SELECT *
FROM titles
;
___________________________________________

CREATE TABLE employees (
    emp_no INT   NOT NULL,
    emp_title_id VARCHAR NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES titles (title_id),
    PRIMARY KEY (emp_no)
);

SELECT *
FROM employees
;

___________________________________________

CREATE TABLE departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
    PRIMARY KEY (dept_no)
);

SELECT *
FROM departments
;
___________________________________________

CREATE TABLE dept_manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INT   NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (dept_no, emp_no)
);

SELECT *
FROM dept_manager
;
___________________________________________

CREATE TABLE dept_emp (
    emp_no INT   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

SELECT *
FROM dept_emp
;
___________________________________________

CREATE TABLE salaries (
    emp_no INT   NOT NULL,
    salary INT   NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

SELECT *
FROM salaries
;
___________________________________________

-- ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
-- REFERENCES "titles" ("title_id");

-- ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
-- REFERENCES "employees" ("emp_no");

-- ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
-- REFERENCES "departments" ("dept_no");

-- ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
-- REFERENCES "employees" ("emp_no");

-- ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
-- REFERENCES "employees" ("emp_no");

-- ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
-- REFERENCES "departments" ("dept_no");

__________________________________________
--List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT 
	employees.emp_no,
	employees.last_name,
	employees.first_name,
	employees.sex,
	salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no = salaries.emp_no

___________________________________________
-- List first name, last name, and hire date for employees who were hired in 1986.
SELECT
	employees.first_name,
	employees.last_name,
	employees.hire_date
FROM employees
WHERE Cast(employees.hire_date as Date) BETWEEN CAST('01/01/1986' as Date) AND CAST('12/31/1986' as Date)

___________________________________________
-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT
	dept_manager.emp_no,
	departments.dept_no,
	departments.dept_name,
	employees.last_name,
	employees.first_name
FROM dept_manager
INNER JOIN departments ON (dept_manager.dept_no = departments.dept_no)
INNER JOIN employees ON (dept_manager.emp_no = employees.emp_no)

___________________________________________
-- List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT
	employees.emp_no,
	employees.last_name,
	employees.first_name,
	dept_emp.dept_no,
	departments.dept_name
FROM employees
INNER JOIN dept_emp ON (employees.emp_no = dept_emp.emp_no)
INNER JOIN departments ON (dept_emp.dept_no = departments.dept_no)

___________________________________________
-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT 
	employees.first_name,
	employees.last_name,
	employees.sex
FROM employees
WHERE 
(
	(employees.first_name = 'Hercules')
AND
	(employees.last_name LIKE 'B%')
)

___________________________________________
-- List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT 
	employees.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM employees
INNER JOIN dept_emp ON (employees.emp_no = dept_emp.emp_no)
INNER JOIN departments ON (dept_emp.dept_no = departments.dept_no)
WHERE 
(
	(departments.dept_name = 'Sales')
)

___________________________________________
-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT 
	employees.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM employees
INNER JOIN dept_emp ON (employees.emp_no = dept_emp.emp_no)
INNER JOIN departments ON (dept_emp.dept_no = departments.dept_no)
WHERE 
(
	(departments.dept_name = 'Sales')
OR
	(departments.dept_name = 'Development')
)

___________________________________________
-- List the frequentcy of last names (i.e., how many employees share each last name) in descending order.

SELECT employees.last_name, COUNT(1)
FROM employees
GROUP BY employees.last_name
ORDER BY count(1) desc



