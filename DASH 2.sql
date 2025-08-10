-- (Query 1) Gênero dos leads
-- Colunas: gênero, leads(#)

SELECT 
	CASE
		WHEN IBGE.GENDER = 'male' THEN 'HOMENS'
		WHEN IBGE.GENDER = 'female' THEN 'MULHERES'
		END AS "GÊNERO",
		COUNT(*) AS "LEADS(#)"
FROM SALES.CUSTOMERS AS CUS
LEFT JOIN TEMP_TABLES.IBGE_GENDERS AS IBGE
	ON LOWER(CUS.FIRST_NAME) = LOWER(IBGE.FIRST_NAME)
GROUP BY IBGE.GENDER



-- (Query 2) Status profissional dos leads
-- Colunas: status profissional, leads (%)

SELECT
	CASE
		WHEN PROFESSIONAL_STATUS = 'freelancer' THEN 'freelancer'
		WHEN PROFESSIONAL_STATUS = 'retired' THEN 'APOSENTADO(A)'
		WHEN PROFESSIONAL_STATUS = 'clt' THEN 'CLT'
		WHEN PROFESSIONAL_STATUS = 'self_employed' THEN 'AUTONOMO(A)'
		WHEN PROFESSIONAL_STATUS = 'other' THEN 'OUTRO'
		WHEN PROFESSIONAL_STATUS = 'businessman' THEN 'EMPRÉSARIOP(A) '
		WHEN PROFESSIONAL_STATUS = 'civil_servant' THEN 'FUNCIONÁRIO(A) PÚBLICO(A)'
		WHEN PROFESSIONAL_STATUS = 'student' THEN 'ESTUDANTE'
		END AS "STATUS PROFISSIONAL",
		(COUNT(*)::FLOAT)/(SELECT COUNT(*) FROM SALES.CUSTOMERS) AS "LEADS (%)"



FROM SALES.CUSTOMERS
GROUP BY PROFESSIONAL_STATUS
ORDER BY "LEADS (%)"




-- (Query 3) Faixa etária dos leads
-- Colunas: faixa etária, leads (%)

select 
	case 
		when (current_date - birth_date)/ 365 <20 then '0-20'
		when (current_date - birth_date)/ 365 <40 then '20-40'
		when (current_date - birth_date)/ 365 <60 then '40-60'
		when (current_date - birth_date)/ 365 <80 then '60-80'
		else '80+' end "faixa etária",
		count(*)::float / (select count(*) from sales.customers) as "leads (%)"
		
from sales.customers
group by "faixa etária"
order by "faixa etária" asc



-- (Query 4) Faixa salarial dos leads
-- Colunas: faixa salarial, leads (%), ordem

select 
	case 
		when income <5000 then '0-5000'
		when  income <10000 then '5000-10000'
		when  income <15000 then '10000-15000'
		when income < 20000 then '15000-20000'
		else '20000+' end "faixa salarail",
		count(*)::float / (select count(*) from sales.customers) as "leads (%)",
	case 
		when income <5000 then '1'
		when  income <10000 then '2'
		when  income <15000 then '3'
		when income < 20000 then '4'
		else '5' end "ordem"
		
from sales.customers
group by "faixa salarail","ordem"
order by "ordem" desc





-- (Query 5) Classificação dos veículos visitados
-- Colunas: classificação do veículo, veículos visitados (#)
-- Regra de negócio: Veículos novos tem até 2 anos e seminovos acima de 2 anos

with 
	classificacao_veiculos as (

		select 
			fun.visit_page_date,
			pro.model_year,
			extract('year' from visit_page_date) - pro.model_year::int as idade_veiculo,
			case
				when (extract('year' from visit_page_date) - pro.model_year::int) <=2 then 'novo'
				else 'seminovo'
				end as "classificaçao do veiculo"
	from sales.funnel as fun
	left join sales.products as pro
		on fun.product_id = pro.product_id
	)

select
	 "classificaçao do veiculo",
	 count(*) as "veículos visitados (#)"
from classificacao_veiculos
group by "classificaçao do veiculo"
	

-- (Query 6) Idade dos veículos visitados
-- Colunas: Idade do veículo, veículos visitados (%), ordem
with 
	faixa_de_idade_dos_veiculos as (

		select 
			fun.visit_page_date,
			pro.model_year,
			extract('year' from visit_page_date) - pro.model_year::int as idade_veiculo,
			case
				when (extract('year' from visit_page_date) - pro.model_year::int) <=2 then 'até 2 anos'
				when (extract('year' from visit_page_date) - pro.model_year::int) <=4 then 'de 2 à 4 anos'
				when (extract('year' from visit_page_date) - pro.model_year::int) <=6 then 'de 4 à 6 anos'
				when (extract('year' from visit_page_date) - pro.model_year::int) <=8 then 'de 6 à 8 anos'
				when (extract('year' from visit_page_date) - pro.model_year::int) <=10 then 'de 8 a 10 anos'
				else'acima de 10 anos'
				end as "idade do veículo",
			case
				when (extract('year' from visit_page_date) - pro.model_year::int) <=2 then 1
				when (extract('year' from visit_page_date) - pro.model_year::int) <=4 then 2
				when (extract('year' from visit_page_date) - pro.model_year::int) <=6 then 3
				when (extract('year' from visit_page_date) - pro.model_year::int) <=8 then 4
				when (extract('year' from visit_page_date) - pro.model_year::int) <=10 then 5
				else 6
				end as "ordem"


				
	from sales.funnel as fun
	left join sales.products as pro
		on fun.product_id = pro.product_id
	)

select
	 "idade do veículo",
	 count(*)::float/(select count(*) from sales.funnel) as "veículos visitados (%)",
	 ordem 
from faixa_de_idade_dos_veiculos
group by "idade do veículo", ordem 
order by ordem 


-- (Query 7) Veículos mais visitados por marca
-- Colunas: brand, model, visitas (#)
select 	
	pro.brand,
	pro.model,
	count(*) as "visitas (#)"
from sales.funnel as fun 
left join sales.products as pro
	on fun.product_id = pro.product_id
group by pro.brand, pro.model
order by pro.brand, pro.model, "visitas (#)"

