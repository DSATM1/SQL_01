create database DE;
use  DE;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Ravi'),
(2, 'Priya'),
(3, 'Arjun'),
(4, 'Neha');

create table orders (
order_id int primary key,
customer_id int,
amount int 
);

insert into orders values
(101, 1, 5000),
(102, 1, 3000),
(103, 2, 4000),
(104, 2, 2000),
(105, 3, 1000);

select * from customers;

select * from orders;

select c.name, sum(o.amount), count(o.order_id) 
from customers c 
left join orders o 
on c.customer_id = o.customer_id 
group by c.name 
having sum(o.amount) > 5000; 

select customer_id, amount, order_id 
from (
	select customer_id, amount, order_id, 
    row_number() over (
		partition by customer_id, amount order by order_id desc
	) as rnk 
from orders 
) t
where rnk = 1;