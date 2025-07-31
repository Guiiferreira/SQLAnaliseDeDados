-- Receita, leads, conversao e ticket medio mes a mês
-- colunas : mes , leads (#), vendas (#), receita(k,R$),
--conversao (%), ticket médio(k, r$)

with
	leads as (
		select 
		date_trunc('month', visit_page_date):: date as visit_page_month,
		count(*) as visit_page_count
		
	from sales.funnel
	group by visit_page_month
	order by visit_page_month),

	payments as (
		select
			date_trunc('month', fun.paid_date):: date as paid_month,
			count(fun.paid_date) as paid_count,
			sum(pro.price * (1+fun.discount)) as receita
		from sales.funnel as fun
		left join sales.products as pro 
			on fun.product_id = pro.product_id
		where fun.paid_date is not null
		group by paid_month 
		order by paid_month 
		)
select
	leads.visit_page_month as "mes",
	leads.visit_page_count as  "leads (#)",
	payments.paid_count as "vendas (#)",
	(payments.receita/1000) as "recita(k, R$)",
	(payments.paid_count::float/leads.visit_page_count::float) as "CONVERSAO(%)",
	(payments.receita/payments.paid_count/1000) as "ticket médio(k, r$)"
from leads
left join payments
	on leads.visit_page_month = paid_month 



--Estados que mostram quem mais venderam 
-- colunas: pais, estado, vendas(#)

select 	

	'Brazil' as pais,
	cus.state as estado,
	count(fun.paid_date)as "vendas(#)"

from sales.funnel as fun
left join sales.customers as cus
	on fun.customer_id = cus.customer_id
where paid_date between '2021-08-01' and '2021-08-31'
group by pais, estado
order by "vendas(#)" desc 
limit 5


-- MARCAS QUE MAIS VENDERAM NO MES
-- COLUNAS: MARCA, VENDAS(#)
SELECT
	PROD.BRAND AS MARCA,
	COUNT(FUN.PAID_DATE) AS "VENDAS(#)"
FROM SALES.FUNNEL AS FUN 
LEFT JOIN SALES.PRODUCTS AS PROD
	ON FUN.PRODUCT_ID = PROD.PRODUCT_ID
WHERE PAID_DATE BETWEEN '2021-08-01' AND '2021-08-31'
GROUP BY MARCA
ORDER BY "VENDAS(#)" DESC
LIMIT 5

--5 LOJAS QUE MAIS VENDERAM 
-- COLUNAS : LOJA, VENDAS(#)
SELECT 
	LOJAS.STORE_NAME AS NOME_LOJA,
	COUNT(FUN.PAID_DATE) AS "VENDAS(#)"
FROM SALES.FUNNEL AS FUN 
LEFT JOIN SALES.STORES AS LOJAS
	ON FUN.STORE_ID = LOJAS.STORE_ID
WHERE PAID_DATE BETWEEN '2021-08-01' AND '2021-08-31'
GROUP BY NOME_LOJA
ORDER BY "VENDAS(#)" DESC
LIMIT 5

-- DIAS DA SEMANA COM MAIOR NUMERO DE VISTAS AO SITE
--COLUNAS : DIA_SEMANA, DIA DA SEMANA, VISITAS(#)

SELECT 
	EXTRACT('DOW' FROM VISIT_PAGE_DATE) AS DIA_SEMANA,
	CASE 
	WHEN EXTRACT('DOW' FROM VISIT_PAGE_DATE) = 0 THEN 'DOMINGO'
	WHEN EXTRACT('DOW' FROM VISIT_PAGE_DATE) = 1 THEN 'SEGUNDA'
	WHEN EXTRACT('DOW' FROM VISIT_PAGE_DATE) = 2 THEN 'TERCA'
	WHEN EXTRACT('DOW' FROM VISIT_PAGE_DATE) = 3 THEN 'QUARTA'
	WHEN EXTRACT('DOW' FROM VISIT_PAGE_DATE) = 4 THEN 'QUINTA'
	WHEN EXTRACT('DOW' FROM VISIT_PAGE_DATE) = 5 THEN 'SEXTA'
	WHEN EXTRACT('DOW' FROM VISIT_PAGE_DATE) = 6 THEN 'SABADO'
	ELSE NULL END AS "DIA DA SEMANA",
	COUNT(*) AS "VISITAS(#)"
FROM SALES.FUNNEL
WHERE VISIT_PAGE_DATE BETWEEN '2021-08-01' AND '2021-08-31'
GROUP BY DIA_SEMANA
ORDER BY DIA_SEMANA 

