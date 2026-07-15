select A.product_id , sesucicl , sesucate , sesuesco , sesuesfn , o.order_id ,a.order_activity_id,
 order_status_id,o.task_type_id , o.operating_unit_id ,o.causal_id ,legalization_date , le.leemoble, le.leemleto
from open.or_order o
inner join open.or_order_activity a on  o.order_id = a.order_id
inner join open.servsusc s on sesunuse = a.product_Id and sesususc = a.subscription_id
inner join open.pr_product pr on pr.product_id =  sesunuse
inner join open.hicoprpm  on  hcppsesu = sesunuse and hcpppeco  = 110818 --periodo anterior
left join open.lectelme  le on sesunuse=  le.leemsesu  and le.leempecs= 111236 --periodo actual
where o.task_type_id in (10043,12617) and order_status_id in (8)and sesucicl = 1003 and le.leemclec = 'F'  and legalization_date between '23/04/2024' and '25/04/2024'
