-- joins 
-- left join -> tudo da esquerda + o que tiver na direita
--inner join ->  só traz o que bate nas duas tabelas
-- right join -> tudo da direita + o que tiver na esquerda
-- full join -> tudo de tudo, combinando o que for possível

-- utilize o LEFT JOIN para fazer o join entre as tabelas
-- temp_tables.tabela_1 e temp_tables.tabela_2

select * 
	from temp_tables.tabela_1
select * 
	from temp_tables.tabela_2

select t1.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1 left join  
temp_tables.tabela_2 as t2
on t1.cpf = t2.cpf


-- inner innerjoin 

select t1.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1 inner join  
temp_tables.tabela_2 as t2
on t1.cpf = t2.cpf

-- right join  
select t2.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1 right join  
temp_tables.tabela_2 as t2
on t1.cpf = t2.cpf


-- full join 
select t2.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1 full join  
temp_tables.tabela_2 as t2
on t1.cpf = t2.cpf



--- exercicios exemplos
--indentificar qual é o status profissional mais frequente
--nos clientes que compraram automoveias no site

select
	cus.professional_status,
	count(fun.paid_date) as pagamentos
	
from sales.funnel as fun
left join sales.customers as cus
	on fun.customer_id = cus.customer_id
group by cus.professional_status
order by pagamentos desc


-- identificar qual é o genero mais frequente nos clientes que compram 
-- autoóveis no site,. obs : utilizar a tabela temp_tables.ibge_genders

select *
from temp_tables.ibge_genders
limit 10 

select  		
	ibge.gender,
	count(fun.paid_date)
from sales.funnel as fun 
left join sales.customers as cus
	on fun.customer_id = cus.customer_id
left join temp_tables.ibge_genders as ibge
	on lower( cus.first_name) = ibge.first_name
group by gender




--indentifique de quais regioes sao os clientes que mais visitam 
--o site obs utilizar a tabela temp_tables.regions 


select * from sales.customers limit 10
select * from temp_tables.regions limit 10 

select 
	reg.region,
	count(fun.visit_page_date) as visitas
from sales.funnel as fun 
left join sales.customers as cus 
	on fun.customer_id = cus.customer_id
left join temp_tables.regions as reg
	on lower(cus.city) = lower(reg.city) -- lower deixa tudo em minusculo
	and lower(cus.state) = lower(reg.state)
group by reg.region
order by  visitas desc

-- joins 
-- Identifique quais as marcas de veículo mais visitada na tabela sales.funnel

select brand,
count(visit_page_date) as visitas
from sales.funnel as fun
left join sales.products as prod
	on fun.product_id = prod.product_id
group by brand
order by visitas desc

-- Identifique quais as lojas de veículo mais visitadas na tabela sales.funnel
select store_name as nome,
count(visit_page_date) as visitas
from sales.funnel as fun 
left join sales.stores as lojas
	on fun.store_id = lojas.store_id
group by nome
order by visitas desc


--Identifique quantos clientes moram em cada tamanho de cidade (o porte da cidade
-- consta na coluna "size" da tabela temp_tables.regions)

select 
reg.size,
count(*) as contagem 
from sales.customers as cus
left join temp_tables.regions as reg
	on lower(cus.city) = lower(reg.city)
	and lower(cus.state) = lower(reg.state)
group by reg.size
order by contagem desc



