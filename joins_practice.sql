-- SQL Joins Learning File
-- This file covers all types of SQL joins with examples

-- Create sample tables for practice
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2)
);

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    emp_id INT,
    project_name VARCHAR(50)
);

-- Insert sample data
INSERT INTO employees VALUES (1, 'Alice', 10, 50000);
INSERT INTO employees VALUES (2, 'Bob', 20, 60000);
INSERT INTO employees VALUES (3, 'Charlie', 10, 55000);
INSERT INTO employees VALUES (4, 'David', NULL, 45000);
INSERT INTO employees VALUES (5, 'Eve', 30, 70000);

INSERT INTO departments VALUES (10, 'IT', 'New York');
INSERT INTO departments VALUES (20, 'HR', 'London');
INSERT INTO departments VALUES (40, 'Marketing', 'Paris');

INSERT INTO projects VALUES (1, 1, 'Project A');
INSERT INTO projects VALUES (2, 3, 'Project B');
INSERT INTO projects VALUES (3, 6, 'Project C');

-- ============================================
-- JOIN TYPES
-- ============================================

-- 1. INNER JOIN
-- Returns records that have matching values in both tables
SELECT e.emp_name, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- 2. LEFT JOIN (LEFT OUTER JOIN)
-- Returns all records from left table and matched records from right table
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- 3. RIGHT JOIN (RIGHT OUTER JOIN)
-- Returns all records from right table and matched records from left table
SELECT e.emp_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

-- 4. FULL OUTER JOIN
-- Returns all records when there is a match in either table
SELECT e.emp_name, d.dept_name
FROM employees e
FULL OUTER JOIN departments d ON e.dept_id = d.dept_id;

-- 5. CROSS JOIN
-- Returns Cartesian product of both tables
SELECT e.emp_name, d.dept_name
FROM employees e
CROSS JOIN departments d;

-- 6. SELF JOIN
-- Joins a table to itself
SELECT a.emp_name AS Employee, b.emp_name AS Manager
FROM employees a
LEFT JOIN employees b ON a.dept_id = b.dept_id AND a.emp_id != b.emp_id;

-- ============================================
-- PRACTICE QUERIES
-- ============================================

-- Query 1: Find employees with their department names
SELECT e.emp_name, e.salary, d.dept_name, d.location
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- Query 2: Find employees with their projects (multiple joins)
SELECT e.emp_name, d.dept_name, p.project_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN projects p ON e.emp_id = p.emp_id;

-- Query 3: Find employees without a department
SELECT emp_name, salary
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;

-- Query 4: Find departments without employees
SELECT d.dept_name, d.location
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;

-- Query 5: Find employees earning above average with department info
SELECT e.emp_name, e.salary, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary > (SELECT AVG(salary) FROM employees);

-- Query 6: Count employees per department
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- Query 7: Total salary by department
SELECT d.dept_name, SUM(e.salary) AS total_salary
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- Query 8: Find projects and their assigned employees
SELECT p.project_name, e.emp_name
FROM projects p
LEFT JOIN employees e ON p.emp_id = e.emp_id
ORDER BY p.project_name;
