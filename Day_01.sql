CREATE DATABASE sql_practice;
USE sql_practice;

CREATE TABLE employees (
    id INT,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

INSERT INTO employees VALUES
(1,'Ravi','Sales',40000),
(2,'Priya','HR',35000),
(3,'Arjun','Sales',45000),
(4,'Neha','HR',50000),
(5,'Kiran','Sales',38000);

SELECT name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

select * from employees;

