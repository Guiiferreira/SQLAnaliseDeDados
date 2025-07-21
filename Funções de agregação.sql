--  Funções de agregação
-- execultar operacoes aritimeticas nos registros de uma coluna


--tipos count(), sum(), min(), max(), avg()

-- contagem de todas as linhas de uma tabela
--conte todas as visitas realizadas ao site da empreaa fictícia

select count(*) 
from sales.funnel

-- contagem das linhas de uma coluna 
-- conte todos os pagamentos registrados na tabela sales.funnel
select count(paid_date)
from sales.funnel
--conytagem distinta de uma coluna
--conte todos os produtos distintos visitados wm jan/21

select count( distinct product_id)
from sales.funnel
where visit_page_date between '2021-01-01' and '2021-01-31'

-- clacule o preco minimo, max e medio da tabela produts

select min(price), max(price), avg(price)
from sales.products 

-- informe qual é o veículo mais caro da tabela products
select *
from sales.products
where price = (select max(price)
from sales.products)
