- EXERCÍCIOS ######################################################################

-- (Exercício 1) Selecione os nomes de cidade distintas que existem no estado de
-- Minas Gerais em ordem alfabética (dados da tabela sales.customers)


select distinct state, city
from sales.customers
where state = 'MG'
order by city

-- (Exercício 2) Selecione o visit_id das 10 compras mais recentes efetuadas
-- (dados da tabela sales.funnel)


select visit_id
from sales.funnel
where paid_date is not null
order by paid_date desc
limit 10 

-- (Exercício 3) Selecione todos os dados dos 10 clientes com maior score nascidos
-- após 01/01/2000 (dados da tabela sales.customers)


select first_name, score,birth_date
from sales.customers
where birth_date > '20000101'
limit 10;



select visit_id, product_id, discount 
from sales.funnel

select distinct product_id
from sales.funnel

select visit_id, discount 
from  sales.funnel
where   discount > 0

select product_id
from sales.funnel
where product_id = 'produto005'

select product_id, visit_page_date
from sales.funnel
where visit_page_date is not null
order by visit_page_date desc
limit 10 

select  distinct visit_page_date, visit_id, product_id
from sales.funnel
where visit_page_date BETWEEN '20210701' and '20210731'

select discount, product_id 
from  sales.funnel
where   discount < '0' 
order by discount 
limit 3 

select *
from sales.funnel
where paid_date is not null


select distinct store_id 
from sales.funnel
