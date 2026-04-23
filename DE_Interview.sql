create database Data;
use Data;

create table customers(
customer_id int primary key, 
name varchar(20)
);

insert into customers values
(1, 'Ravi'),
(2, 'Priya'),
(3, 'Arjun'),
(4, 'Neha');

create table orders(
order_id int primary key,
customer_id int,
amount int
);

insert into orders values
(101, 1, 5000),
(102, 1, 3000),
(103, 2, 4000),
(104, 2, 2000),
(105, 3, 1000),
(106, 3, 1000);

select * from customers;

select * from orders;

select customer_id, sum(amount) from orders
where amount is not null
group by customer_id;

SELECT customer_id, amount, order_id
FROM (
    SELECT customer_id, amount, order_id,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id, amount 
        ORDER BY order_id DESC
    ) AS rnk
    FROM orders
) t
WHERE rnk = 1;

select c.name,sum(o.amount) 
from customers c 
left join orders o 
on c.customer_id = o.customer_id 
group by c.name
having sum(o.amount) > 6000;

SELECT order_id, customer_id, amount, 
SUM(amount) OVER (
    PARTITION BY customer_id 
    ORDER BY order_id
) AS running_total
FROM orders;