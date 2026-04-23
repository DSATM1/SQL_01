create database Data;
use Data;

create table customers(
customer_id int primary key, 
name varchar(20)
);

create table orders(
order_id int primary key,
customer_id int,
amount int
);

