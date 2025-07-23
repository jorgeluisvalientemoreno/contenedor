select o.order_id , subscription_id , product_id , o.task_type_id , order_status_id , o.operating_unit_id , created_date , package_id 
from or_order o
inner join or_order_activity a on a.order_id=o.order_id
where o.task_type_id=12134 
and order_status_id= 5
order by  created_date desc ;