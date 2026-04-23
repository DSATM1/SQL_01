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

