-- HAVING  
--serve para filtrar linhas da selecao por uma coluna agupada 


-- selecao com filtro no having
-- calcule o numero de clientes por estado filtrando apenas estados 
--acima de 100 cliente 

select 
	state,
	count(*)
from sales.customers 
group by state
having count(* )> 100 and state <> 'MG'
