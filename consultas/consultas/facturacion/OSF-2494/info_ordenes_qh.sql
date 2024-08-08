select A.product_id , sesucicl , sesucate , sesuesco , sesuesfn , o.order_id ,a.order_activity_id,
 order_status_id,o.task_type_id , o.operating_unit_id ,o.causal_id ,legalization_date , le.leemoble, le.leemleto
from open.or_order o
inner join open.or_order_activity a on  o.order_id = a.order_id
inner join open.servsusc s on sesunuse = a.product_Id and sesususc = a.subscription_id
inner join open.pr_product pr on pr.product_id =  sesunuse
left join open.lectelme  le on sesunuse=  le.leemsesu  and le.leempecs= 111476 --PERIODO ANTERIOR DE CONSUMO
where o.task_type_id in (12617,10043) and order_status_id in (0,5 )and sesucicl = 1327 and le.leemclec = 'F'
order by A.product_id