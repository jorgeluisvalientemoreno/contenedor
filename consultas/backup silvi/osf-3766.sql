select subscription_id, product_id ,a.package_id, o.order_id  ,  o.task_type_id , order_status_id ,created_date
from open.or_order_activity a 
inner join open.or_order o on a.order_id = o.order_id 
where o.task_type_id in (12149, 12150 , 12162 )
and order_status_id in (5) 
order by created_date desc 
