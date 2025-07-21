-- GROUP BY
-- serve para agrupar registros de uma coluna
-- normalmente utilizado em conjunto com as funcoes de agregacao


-- contagem agrupada de uma coluna
-- calcular o n de clientes da tabela customers por estado
select state,  count(*) as contagem 
from sales.customers
group by state
order by contagem desc

-- conatgem agrupada de varias colunas 
-- calcule o n de clientes por estado e status profissional 
select state, professional_status, count(*) as contagem 
from sales.customers
group by state, professional_status
order by state desc, contagem desc

--selecao de valores distintos
--selecionar os estados distintos na tabela customers utilizando 
--o group by
select distinct state
from sales.customers 

select state
from sales.customers
group by state