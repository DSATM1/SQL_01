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
    name VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Ravi'),
(2, 'Priya'),
(3, 'Arjun'),
(4, 'Neha');

drop table customers;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount INT
);

INSERT INTO orders VALUES
(101, 1, 5000),
(102, 1, 3000),
(103, 2, 4000),
(104, 2, 2000),
(105, 3, 1000);



drop table orders;


select * from customers;
select * from orders;

select customers.name, count(*) 
from customers 
left join orders 
on customers.customer_id = orders.customer_id 
group by customers.name
having count(*) = 1;

select department, avg(salary) 
from employees 
group by department 
having avg(salary) > (
	select avg(salary) 
	from employees
);

SELECT department, salary
FROM employees e1
WHERE salary < (
    SELECT AVG(salary)
    FROM employees e2
    WHERE e2.department = e1.department
);

select name from customers c 
where exists (
select 1
from orders o 
where o.customer_id = c.customer_id
);

select name, department, salary, 
row_number() over (order by salary desc) Salary_Rank 
from employees; -- Descending 

select name, department, salary, 
row_number() over (order by salary ) Salary_Rank 
from employees; -- Ascending

select name, salary, department, 
Row_Number() over (partition by department order by salary ) as Dept_Rank 
from employees;

select name, salary, department, 
rank() over (order by salary desc) as Rnk 
from employees;

select name, salary, 
row_number() over (order by salary desc) Salary_Rank 
from employees;

select department, name, salary, 
rank() over (order by salary desc) as rnk 
from employees;

select name, salary, department 
from (
select name, salary, department, 
row_number() over (partition by department order by salary desc ) as rnk 
from employees
) t 
where rnk = 3;

select name, salary 
from (
select name, salary, 
dense_rank() over (order by salary desc) as dens_rnk
 from employees) t
 where dens_rnk <=2;
 
 select name, salary 
from ( 
select salary, name, row_number() over (order by salary desc) as rnk 
from employees 
) r 
where rnk = 3;

select department, total_salary 
from ( SELECT department, sum(salary) as total_salary,
RANK() OVER (ORDER BY sum(salary) DESC) AS rnk
FROM employees 
group by department
) t 
where 
rnk = 1;

select customers.name, coalesce(sum(orders.amount),0) 
from customers 
left join orders 
on customers.customer_id = orders.customer_id 
group by customers.name;

select customers.name, count(orders.order_id)
from customers 
left join orders 
on customers.customer_id = orders.customer_id 
group by customers.name
having count(orders.order_id) = 2;


select customers.name, coalesce(sum(orders.amount),0), count(orders.order_id) 
from customers 
inner join orders 
on customers.customer_id = orders.customer_id 
group by customers.name;


SELECT name, total_amount,
RANK() OVER (ORDER BY total_amount DESC) AS rnk
FROM (
    SELECT customers.name, 
    COALESCE(SUM(orders.amount), 0) AS total_amount
    FROM customers
    LEFT JOIN orders
    ON customers.customer_id = orders.customer_id
    GROUP BY customers.name
) t;

select customers.name, coalesce(sum(orders.amount),0) 
from customers 
left join orders 
on customers.customer_id = orders.customer_id 
group by customers.name 
having sum(orders.amount)>5000;

select name, department, salary, 
row_number() over (partition by department order by salary desc) as rnk 
from employees;


-- Find 3rd highest salary
-- Find employees earning more than their manager 
-- Find department with highest total salary
-- Find employees with same salary
-- Find running total of salary

-- Show top 2 highest salary employees
-- Show employees with salary greater than department average
-- Show department-wise total salary
-- Show customers who never ordered
-- Show 2nd highest salary employee

-- Find employee with 2nd highest salary
-- Find department with lowest average salary
-- Find customers whose total order > 5000
-- Find employees earning above department average
-- Rank employees within department by salary

select c.name, sum(o.amount) 
from customers c 
left join orders o 
on c.customer_id = o.customer_id 
group by c.name 
having sum(o.amount) > 7000;

select name, salary 
from employees 
where salary > (
	select avg(salary) 
	from employees 
);

select c.name, count(o.order_id) 
from customers c 
left join orders o 
on c.customer_id = o.customer_id 
group by c.name;

select name, salary ,
row_number() over (order by salary desc) as rnk 
from employees;

select name,department,salary 
from employees e1 
where salary > (
	select avg(salary) 
    from employees e2 
    where e1.department=e2.department
);

select name, salary  
from ( 
select name, salary, 
row_number() over (order by salary desc) as rnk 
from employees 
) t 
where rnk <=2;

select c.name, sum(o.amount) as total 
from customers c 
left join orders o 
on c.customer_id = o.customer_id 
group by c.name 
having total > 7000;

select name, salary 
from employees 
where salary = (
	select max(salary) 
    from employees 
    where salary < (
		select max(salary) 
        from employees 
	) 
);


-- window function  
SELECT name, salary
FROM (
    SELECT name, salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 2;

SELECT name, department, salary
FROM employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees e2
    WHERE e2.department = e1.department
);

select name, department, salary , 
row_number() over (partition by department order by salary desc) as rnk 
from ( 
	select department, name, salary
	from employees e1 
	where salary > (
	select avg(salary) 
    from employees e2 
    where e2.department = e1.department 
    )
)t;

select * from (
select name, department, salary , 
row_number() over (partition by department order by salary desc) as rnk 
from ( 
	select department, name, salary
	from employees e1 
	where salary > (
		select avg(salary) 
		from employees e2 
		where e2.department = e1.department 
		)
	)t 
)x 
where rnk <=2;

select * from employees 
where salary between 40000 and 50000;

select c.name, coalesce(sum(o.amount),0) 
from customers c 
left join orders o 
on c.customer_id = o.customer_id 
group by c.name;


select name, salary 
from employees 
where salary = (
	select max(salary) 
    from employees 
);

select c.name 
from customers c 
left join orders o 
on c.customer_id = o.order_id 
where o.customer_id IS NULL;


-- Alternative (Using COUNT) 
SELECT c.name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COUNT(o.customer_id) = 0;

select name, department, salary, 
row_number() over (partition by department order by salary desc) as rnk 
from employees; 

select distinct c.name, count(o.order_id) 
from customers c 
inner join orders o 
on c.customer_id=o.customer_id 
group by c.name 
having count(o.order_id) = 1;

SELECT name, salary,
DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
FROM employees;

SELECT name, salary 
FROM employees 
WHERE salary < (SELECT AVG(salary) FROM employees);

SELECT c.name, COUNT(o.order_id)
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COUNT(o.order_id) > 2;

SELECT c.name, COALESCE(SUM(o.amount),0)
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING SUM(o.amount) >= 6000;


select c.name, coalesce(sum(o.amount),0) from customers c 
inner join orders o 
on c.customer_id = o.customer_id 
group by c.name
having sum(o.amount) between 4000 and 9000;

select salary, name
from employees 
where salary > (
select min(salary) 
from employees
);


select * from employees; 

select c.name, count(o.order_id) 
from customers c 
left join orders o 
on c.customer_id = o.customer_id 
group by c.name
having count(o.order_id) = 2;


select name, salary 
from (
select name, salary , 
row_number() over (order by salary desc) as rnk 
from employees )t
where rnk <=3;


select department, avg(salary) 
from employees 
group by department 
having avg(salary) > (
select avg(salary) 
from employees );