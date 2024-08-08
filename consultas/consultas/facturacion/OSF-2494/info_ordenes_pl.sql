select A.product_id , sesucicl , sesucate , sesuesco , sesuesfn , o.order_id ,a.order_activity_id,
 order_status_id,o.task_type_id , o.operating_unit_id ,o.causal_id ,legalization_date , o.execution_final_date, le.leemoble, le.leemleto 
from open.or_order o
inner join open.or_order_activity a on  o.order_id = a.order_id
inner join open.servsusc s on sesunuse = a.product_Id and sesususc = a.subscription_id
inner join open.pr_product pr on pr.product_id =  sesunuse
left join open.lectelme  le on sesunuse=  le.leemsesu  and le.leempecs= 111476 --Periodo a legalizar en QH
where o.task_type_id in (12617,10043) and order_status_id in (8)and sesucicl = 5474 and le.leemclec = 'F' and legalization_date between '28/04/2024 11:59:59' and '30/04/2024 11:59:59'
order by A.product_id
