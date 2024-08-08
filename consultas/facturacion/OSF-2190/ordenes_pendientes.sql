select sesunuse , sesususc , sesuserv , o.order_id , sesucicl , created_date   ,  o.task_type_id,o.order_status_id
from or_order o
inner join or_order_Activity a on a.order_id=o.order_id
inner join servsusc s on a.product_id = s.sesunuse
where o.task_type_id in (12617,10043) and sesunuse = 17241383 
  and o.order_status_id in (0,5) and sesucicl = 4761