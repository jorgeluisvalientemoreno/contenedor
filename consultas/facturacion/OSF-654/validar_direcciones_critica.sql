select or_order_activity.product_id,
       or_order_activity.subscription_id,
       or_order.task_type_id,
       or_task_type.description,
       or_order.order_id,
       or_order.order_status_id estado,
       or_order.created_date,
       ab_address.address direccion, 
       or_order.external_address_id  , 
       or_order_activity.address_id , 
       or_extern_systems_id.address_id  
from or_order 
left join or_task_type  on or_task_type.task_type_id = or_order .task_type_id
left join or_order_activity  on or_order_activity.order_id = or_order .order_id
left join or_extern_systems_id  on or_extern_systems_id .order_id =  or_order .order_id
left join ab_address  on or_order_activity.address_id = ab_address.address_id 
where or_order.task_type_id in (12619)          
and  or_order.order_status_id in (0,5)
and or_order_activity.product_id =1030826
order by or_order .created_date desc;