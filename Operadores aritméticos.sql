-- Operadores aritméticos


-- TIPOS 
-- + - * / ^ %   ------ {|| juncao de tabelas }
-- (current_date) datade hoje 
-- as para renomear as colunas 

--	EXEMPLO 1
--crie uma coluna contendo a idade do cliente da tabela sales.customers

select *
from sales.customers
limit 10

select 		first_name,
			last_name, 
			birth_date,
		(current_date - birth_date) / 365 as "idade do cliente"
from sales.customers
limit 10


--ExEMPLO 2
-- LISTE OS 10 CLIENTES MAIS NOVOS DA TABELAS CUSTOMERS

select 		first_name,
			last_name, 
			birth_date,
		(current_date - birth_date) / 365 as "idade do cliente"
from sales.customers
order by "idade do cliente"

-- exemplo 3 criacao de coluna calculada com strings 
-- CRIE A COLUNA "NOME_COMPLETO" CONTENDO O NOME COMPLETO DO CLIENTE

select first_name || ' ' || last_name as NOME_COMPLETO
	
from sales.customers




