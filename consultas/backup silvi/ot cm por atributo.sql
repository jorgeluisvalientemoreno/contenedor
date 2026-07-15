select oa.product_id ,o.order_id ,  o.order_status_id , o.task_type_id , o.created_date , o.legalization_date , o.operating_unit_id
from or_order_activity oa 
left join or_order o on oa.order_id = o.order_id 
where o.task_type_id in ( select ti.task_type_id
                              from or_task_types_items ti, ge_items_attributes ia, ge_items i
                              where ia.items_id = ti.items_id
                              and ti.items_id = i.items_id
                              and attribute_1_id = 400022
                              and attribute_2_id = 400021)
and oa.product_id = 52204051
and o.order_status_id in (0,5) 
                              
                              
