select or_order_activity.product_id,
       or_order.order_id,
       or_order.task_type_id,
       or_task_type.description desc_tipo_trab,
       or_order.order_status_id,
       or_order.created_date
  from open.or_order
  left join open.or_order_activity  on or_order_activity.order_id = or_order.order_id
  left join open.or_task_type  on  or_task_type.task_type_id = or_order.task_type_id
 where or_order_activity.product_id = 1022572
   and or_order.created_date >= '24/10/2022'
