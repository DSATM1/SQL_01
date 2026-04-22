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

-- 4. FULL OUTER JOIN (using UNION workaround for MySQL compatibility)
-- Returns all records when there is a match in either table
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
UNION
SELECT e.emp_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

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

-- ============================================
-- MORE INNER JOIN EXAMPLES
-- ============================================

-- Query 9: Get employee details with department and project info
SELECT 
    e.emp_name,
    d.dept_name,
    d.location,
    p.project_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
INNER JOIN projects p ON e.emp_id = p.emp_id;

-- Query 10: Find employees in 'IT' department earning above 50000
SELECT e.emp_name, e.salary, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'IT' AND e.salary > 50000;

-- Query 11: Get department-wise highest salary
SELECT d.dept_name, MAX(e.salary) AS highest_salary, e.emp_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name, e.emp_name
ORDER BY highest_salary DESC;

-- Query 12: Find employees and their project counts
SELECT 
    e.emp_name,
    COUNT(p.project_id) AS project_count
FROM employees e
INNER JOIN projects p ON e.emp_id = p.emp_id
GROUP BY e.emp_name
HAVING COUNT(p.project_id) > 0;

-- Query 13: Get average salary by department (INNER JOIN)
SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- Query 14: Find employees whose salary is between department average
SELECT e.emp_name, e.salary, d.dept_name, d_avg.avg_salary
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
INNER JOIN (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
) d_avg ON e.dept_id = d_avg.dept_id;

-- Query 15: List all departments with at least one employee
SELECT DISTINCT d.dept_name, d.location
FROM departments d
INNER JOIN employees e ON d.dept_id = e.dept_id;

-- ============================================
-- MORE LEFT JOIN EXAMPLES
-- ============================================

-- Query 16: Get all employees with optional project info
SELECT e.emp_name, e.salary, p.project_name
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
ORDER BY e.emp_name;

-- Query 17: Count projects per employee (including those with no projects)
SELECT 
    e.emp_name,
    COUNT(p.project_id) AS project_count
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
GROUP BY e.emp_name;

-- Query 18: Find employees without projects
SELECT e.emp_name, e.salary
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
WHERE p.project_id IS NULL;

-- Query 19: Get all departments with employee count (including empty depts)
SELECT d.dept_name, COUNT(e.emp_id) AS emp_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- Query 20: All employees with department (including those without dept)
SELECT e.emp_name, d.dept_name, d.location
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- Query 21: Find employees and total project budget (hypothetical)
SELECT 
    e.emp_name,
    COALESCE(p.project_name, 'No Project') AS project_status
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id;

-- Query 22: Get employees with salary details and department location
SELECT 
    e.emp_name,
    e.salary,
    d.dept_name,
    d.location,
    p.project_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN projects p ON e.emp_id = p.emp_id;

-- Query 23: List employees with salary rank within their department
SELECT 
    e.emp_name,
    e.salary,
    d.dept_name,
    RANK() OVER (PARTITION BY d.dept_name ORDER BY e.salary DESC) AS salary_rank
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- Query 24: Find departments where total salary exceeds threshold
SELECT d.dept_name, SUM(e.salary) AS total_salary
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING SUM(e.salary) > 50000;

-- Query 25: Get employee details with salary comparison to team average
SELECT 
    e.emp_name,
    e.salary,
    d.dept_name,
    team_avg.avg_salary,
    (e.salary - team_avg.avg_salary) AS diff_from_avg
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
INNER JOIN (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
) team_avg ON e.dept_id = team_avg.dept_id;
