select pr.product_id , sesucicl , sesucate , sesuesco , sesuesfn ,
 pr.product_status_id, o.order_id , order_status_id,a.value1,
  a.value2,o.task_type_id , o.legalization_date
from or_order o
inner join or_order_activity a on  o.order_id = a.order_id
inner join servsusc s on sesunuse = a.product_Id and sesususc = a.subscription_id
inner join pr_product pr on sesunuse = pr.product_id
where o.task_type_id in (10043,12617) and order_status_id in (8) 
--and o.legalization_date >'15/01/2024' 
and sesucate = 1 --and value1= 'READING>>>>' 
and o.created_date = (select max(o1.created_date ) from or_order o1  where o1.order_id = o.order_id  and o1.task_type_id in (10043,12617) )
and rownum <= 25 
order by product_id 
 --and sesucicl = 4702
