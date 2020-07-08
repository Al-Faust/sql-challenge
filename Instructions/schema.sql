--primary key tables
CREATE TABLE "department" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_department" PRIMARY KEY (
        "dept_no"
     )
);

--check
select * from department;

CREATE TABLE "employee" (
    "emp_no" INT   NOT NULL,
    "emp_title" VARCHAR   NOT NULL,
    "birth_date" VARCHAR(10)   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" VARCHAR(10)   NOT NULL,
    CONSTRAINT "pk_employee" PRIMARY KEY (
        "emp_no"
     )
);

--check
select * from employee;

CREATE TABLE "title" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_title" PRIMARY KEY (
        "title_id"
     )
);

--check
select * from title;

--dependant tables
CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
	foreign key (emp_no) references employee(emp_no),
	foreign key (dept_no) references department(dept_no)
);

--check
select * from dept_emp;

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
	foreign key (emp_no) references employee(emp_no),
	foreign key (dept_no) references department(dept_no)
);

--check
select * from dept_manager;

CREATE TABLE "salary" (
    "emp_no" INT   NOT NULL,
    "salary" money   NOT NULL,
	foreign key (emp_no) references employee(emp_no)
);

--check
select * from salary;

--correct employee table
ALTER TABLE "employee" ADD CONSTRAINT "fk_employee_emp_title" FOREIGN KEY("emp_title")
REFERENCES "title" ("title_id");

--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employee.emp_no, employee.last_name, employee.first_name, employee.sex, salary.salary
FROM employee
JOIN salary AS salary
  ON employee.emp_no = salary.emp_no

--2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT employee.first_name, employee.last_name, employee.hire_date
FROM employee
WHERE employee.hire_date like '%/1986'
  
--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT department.dept_no, department.dept_name, employee.emp_no, employee.last_name, employee.first_name
FROM employee,
	dept_manager,
	department
WHERE employee.emp_no = dept_manager.emp_no
	and dept_manager.dept_no = department.dept_no

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employee.emp_no, employee.last_name, employee.first_name, department.dept_name
FROM employee,
	dept_emp,
	department
WHERE employee.emp_no = dept_emp.emp_no
	and dept_emp.dept_no = department.dept_no

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT employee.first_name, employee.last_name, employee.sex
FROM employee
WHERE employee.first_name = 'Hercules'
	and employee.last_name like 'B%'

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employee.emp_no, employee.last_name, employee.first_name, department.dept_name
FROM employee,
	dept_emp,
	department
WHERE employee.emp_no = dept_emp.emp_no
	and dept_emp.dept_no = department.dept_no
	and department.dept_name = 'Sales'

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employee.emp_no, employee.last_name, employee.first_name, department.dept_name
FROM employee,
	dept_emp,
	department
WHERE employee.emp_no = dept_emp.emp_no
	and dept_emp.dept_no = department.dept_no
	and (department.dept_name = 'Sales'
	or department.dept_name = 'Development')

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT employee.last_name, COUNT(employee.last_name) AS "employee count"
FROM employee
GROUP BY employee.last_name
ORDER BY "employee count" DESC


