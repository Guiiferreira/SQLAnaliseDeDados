--Colunas - Inserção, atualização e deleção


--inserção de colunas
--insira uma coluna na tabela salescustomers com a idade do cliente


alter table sales.customers
add customer_age int 

select * from sales.customers limit 10

update sales.customers
set customer_age = (CURRENT_DATE - BIRTH_DATE)/365 
where true


--alteracao do tipo da coluna
--altere o tipo da coluna customer_age de inteiro para varchar

alter table sales.customers
alter column customer_age type varchar 

ALTER TABLE sales.customers
ALTER COLUMN age TYPE integer USING age::integer;
-- alteracao do nome da coluna
--renomie o nome da coluna "customer_age" para "" age""

alter table sales.customers
rename column customer_age to age 
select * from sales.customers limit 10


--delete a coluna age

alter table sales.customers
drop column age 