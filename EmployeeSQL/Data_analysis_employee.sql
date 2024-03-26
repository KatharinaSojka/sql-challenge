--checking if tables exist
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;

--create all relevant tables
CREATE TABLE department (
	dept_no varchar(4) PRIMARY KEY NOT NULL,
	dept_name varchar(30) NOT NULL
);

CREATE TABLE titles (
	title_id varchar(5) PRIMARY KEY NOT NULL,
	title varchar(30) NOT NULL
);

CREATE TABLE employees (
emp_no INT PRIMARY KEY NOT NULL,
emp_title_id varchar(5) NOT NULL,
FOREIGN KEY (emp_title_id) references titles(title_id),
birth_date date,
first_name varchar(30) NOT NULL,
last_name varchar(30) NOT NULL,
sex varchar(1) NOT NULL,
hire_date date,
bdate varchar(10), -- auxiliary birth_date column, to import data as text
hdate varchar(10)  -- auxiliary hire_date column, to import data as text

);

CREATE TABLE salaries (
emp_no INT PRIMARY KEY NOT NULL,
FOREIGN KEY (emp_no) references employees(emp_no),
salary int
);

CREATE TABLE dept_emp (
emp_no int NOT NULL,
FOREIGN KEY (emp_no) references employees(emp_no),
dept_no varchar(4) NOT NULL,
FOREIGN KEY (dept_no) references department(dept_no),
PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_manager (
dept_no varchar(4) NOT NULL,
FOREIGN KEY (dept_no) references department(dept_no),
emp_no INT NOT NULL,
FOREIGN KEY (emp_no) references employees(emp_no),
PRIMARY KEY (dept_no, emp_no)
);

--checking results of importation

select * from titles
select * from department
select * from employees
select * from salaries
select * from dept_manager
select * from dept_emp



--converting from text to date format using auxiliary columns(columns: bdate, hdate created directly in postgres, type varchar(10), csv file was imported again, using those columns)
update employees set birth_date=to_date(bdate,'MM/DD/YYYY')

update employees set hire_date=to_date(hdate,'MM/DD/YYYY')

--deleteing auxliary columns from employee tabel
alter table employees
drop column bdate,
drop column hdate;

--1. List the employee number, last name, first name, sex, and salary of each employee. 

select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
from employees 
join salaries on employees.emp_no = salaries.emp_no
order by employees.last_name;


--2. List the first name, last name, and hire date for the employees who were hired in 1986.
select first_name, last_name, hire_date from employees where extract(year from hire_date)=1986


--3.List the manager of each department along with their department number, department name, employee number, last name, and first name.
select department.dept_name, dept_manager.dept_no, dept_manager.emp_no, employees.first_name, employees.last_name
from department
join dept_manager on department.dept_no = dept_manager.dept_no 
join employees on employees.emp_no = dept_manager.emp_no

--4.List the department number for each employee along with that employee’s employee number, last name, first name, and department name

select department.dept_no, employees.emp_no, employees.last_name, employees.first_name, department.dept_name
from department
join dept_emp on department.dept_no = dept_emp.dept_no
join employees on employees.emp_no = dept_emp.emp_no;

--5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

select first_name, last_name, sex
from employees
where first_name = 'Hercules' and last_name like 'B%';

--6. List each employee in the Sales department, including their employee number, last name, and first name
select employees.emp_no, employees.last_name, employees.first_name
from employees
join dept_emp on employees.emp_no = dept_emp.emp_no
join department on department.dept_no = dept_emp.dept_no
where department.dept_name = 'Sales'
;

-- alternative method
select emp_no, last_name, first_name
from employees
where emp_no in
	(select emp_no from dept_emp
	where dept_no =
		(select dept_no from department
		where dept_name = 'Sales')
	)
order by emp_no
;

--7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select employees.emp_no, employees.last_name, employees.first_name, department.dept_name
from employees
join dept_emp on employees.emp_no = dept_emp.emp_no
join department on department.dept_no = dept_emp.dept_no
where department.dept_name in ('Sales','Development')
;

--8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

select last_name, count(last_name) as Frequency
from employees
group by last_name 
order by frequency desc
;
