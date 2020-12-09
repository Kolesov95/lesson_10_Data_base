-- Задание № 1
-- Проверенно, все работает.
create table if not exists logs(
created_at datetime default now(),
table_name varchar(8),
operation_id int,
name varchar (255)
) engine = archive;

drop trigger if exists users_logs;

delimiter //
create trigger users_logs after insert on users
for each row
begin 
	insert into logs(table_name, operation_id, name) values
	('users', new.id, new.name);
end //
delimiter ;

delimiter //
create trigger catalogs_logs after insert on catalogs
for each row
begin 
	insert into logs(table_name, operation_id, name) values
	('catalogs', new.id, new.name);
end //
delimiter ;

delimiter //
create trigger products_logs after insert on products
for each row
begin 
	insert into logs(table_name, operation_id, name) values
	('products', new.id, new.name);
end //
delimiter ;

-- Задание № 2 
-- Создадим новую таблицу users_2
create table users_2(
	id serial primary key,
	firstname varchar(50),
	lastname varchar(50),
	email varchar(120),
	phone varchar(20),
	birtday date,
	hometown varchar(100),
	gender char(1),
	photo_id bigint unsigned,
	created_at datetime default now(),
	pass char(30));
	
drop procedure if exists million_users;
delimiter //
create procedure million_users()
begin
	declare i int default 1;
	while i <= 1000000 DO
		insert into users_2(firstname) values
		(concat('user ', i));
		set i = i + 1;
	end while;
end //
delimiter ;

call million_users() 
select count(*) from users_2;
