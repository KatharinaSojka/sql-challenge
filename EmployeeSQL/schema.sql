DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;

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
hire_date date
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
