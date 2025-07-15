-- ORDER BY -- serve para ordenar
--a selecao de acordo com a regra definida pelo usuário
-- padrao crescente e para ordem decrecente usar desc
select * 
from sales.products

-- selecionar produtos da tabela products
--na ordem crescente com base no preco
select *
from sales.products
order by price desc

-- liste os estados distintos da tabela customers na ordem crescente
select *
from sales.customers 

select DISTINCT state
from sales.customers
order by  state 

