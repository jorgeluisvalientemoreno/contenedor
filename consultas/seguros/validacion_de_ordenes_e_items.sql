select product_id, i.order_id , i.items_id , i.value,i.total_price ,i.order_items_id ,or_task_type.task_type_id , charge_status
from or_order_items i 
inner join open.or_order on  or_order.order_id =i.order_id
inner join open.or_order_activity on or_order_activity.order_id = or_order.order_id and or_order.task_type_id=  or_order_activity.task_type_id
inner join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
where i.order_id in (337120323)
and or_task_type.task_type_id in (10210,10211);
