select pr.product_id , sesucicl , sesucate , sesuesco , sesuesfn , pr.product_status_id, o.order_id , order_status_id,o.task_type_id , o.operating_unit_id ,o.causal_id , ge.class_causal_id,legalization_date
from or_order o
inner join or_order_activity a on  o.order_id = a.order_id
inner join servsusc s on sesunuse = a.product_Id and sesususc = a.subscription_id
inner join pr_product pr on sesunuse = pr.product_id
left join ge_causal ge on ge.causal_id= o.causal_id
where o.task_type_id in (10043) and order_status_id in (0,5 )and sesucicl = 4702-- and legalization_date >'23/02/2024'
