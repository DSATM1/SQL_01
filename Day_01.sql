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

USE sql_practice;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO customers (customer_id, name) VALUES
(101, 'Sonu'),
(102, 'Manu'),
(103, 'Dinu'),
(104, 'Damu');

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    name VARCHAR(100),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


INSERT INTO orders (order_id, customer_id, name) VALUES
(1, 101, 'Laptop'),
(2, 102, 'Mobile'),
(3, 103, 'Tablet'),
(4, 101, 'Headphones'),
(5, 104, 'Keyboard'),
(6, 102, 'Mouse');

select * from customers;
select * from orders;

select customers.name, count(*) 
from customers 
left join orders 
on customers.customer_id = orders.customer_id 
group by customers.name
having count(*) > 1;

select department, avg(salary) from employees group by department having avg(salary) > (select avg(salary) from employees);