select servsusc.sesususc , or_order_Activity.product_id , or_order.order_id , or_order.task_type_id ,  or_order.order_status_id , or_order.created_date , or_order.legalization_date 
from open.or_order 
inner join open.or_order_Activity  on or_order_Activity.order_id=or_order.order_id
inner join open.servsusc  on or_order_Activity.product_id = servsusc.sesunuse
where or_order.task_type_id in (12617)
and or_order.order_status_id in (0,5)
