-- Q1
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2) CHECK (salary > 20000),
    dept_id INT
);

-- Q2
ALTER TABLE employees
RENAME COLUMN emp_name TO full_name;

-- Q3
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    full_name VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT,
    CONSTRAINT chk_salary CHECK (salary > 20000)
);

ALTER TABLE employees
DROP CONSTRAINT chk_salary;
INSERT INTO employees (emp_id, full_name, salary, dept_id)
VALUES (1, 'Test Employee', 5000, 10);

-- Q4
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) UNIQUE
);

INSERT INTO departments (dept_id, dept_name) VALUES (10, 'HR');
INSERT INTO departments (dept_id, dept_name) VALUES (20, 'IT');
INSERT INTO departments (dept_id, dept_name) VALUES (30, 'Finance');

-- Q5
ALTER TABLE employees
ADD CONSTRAINT fk_dept
FOREIGN KEY (dept_id) REFERENCES departments(dept_id);

-- Q6
ALTER TABLE employees
ADD bonus DECIMAL(6,2) DEFAULT 1000;

-- Q7
ALTER TABLE employees
ADD city VARCHAR(20) DEFAULT 'Karachi',
ADD age INT CHECK (age > 18);

-- Q8
DELETE FROM employees
WHERE emp_id IN (1, 3);

-- Q9
ALTER TABLE employees
MODIFY full_name VARCHAR(20),
MODIFY city VARCHAR(20);

-- Q10
ALTER TABLE employees
ADD email VARCHAR(100) UNIQUE;

-- Q11
ALTER TABLE employees
ADD CONSTRAINT uq_bonus UNIQUE (bonus);

-- Q12
ALTER TABLE employees
ADD dob DATE
    CONSTRAINT chk_dob CHECK (dob <= ADD_MONTHS(SYSDATE, -12*18));

-- Q13
INSERT INTO employees (emp_id, full_name, salary, dept_id, dob, age)
VALUES (4, 'Charlie', 25000, 10, '2010-01-01', 13);

-- Q14
ALTER TABLE employees
DROP CONSTRAINT fk_dept;

INSERT INTO employees (emp_id, full_name, salary, dept_id, age)
VALUES (5, 'David', 28000, 99, 30); -- works now, but dept_id=99 not in departments

ALTER TABLE employees
ADD CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id);

-- Q15
ALTER TABLE employees
DROP COLUMN age,
DROP COLUMN city;

-- Q16
SELECT d.dept_id, d.dept_name, e.emp_id, e.full_name, e.salary
FROM departments d
LEFT JOIN employees e
  ON d.dept_id = e.dept_id;

-- Q17
ALTER TABLE employees
RENAME COLUMN salary TO monthly_salary;

-- Q18
SELECT d.dept_id, d.dept_name
FROM departments d
LEFT JOIN employees e
  ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;

-- Q19
TRUNCATE TABLE students;

-- Q20
SELECT department_id, COUNT(*) AS total_employees
FROM employees
GROUP BY department_id
ORDER BY total_employees DESC
FETCH FIRST 1 ROW ONLY;