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

