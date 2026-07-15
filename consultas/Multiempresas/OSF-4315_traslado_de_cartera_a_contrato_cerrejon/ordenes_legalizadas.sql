--ordenes_legalizadas
select oa.product_id,
       tt.task_type_id,
       tt.description,
       i.order_id,
       o.order_status_id,
       i.items_id,
       it.description,
       i.value,
       i.total_price,
       i.order_items_id,
       charge_status
  from or_order_items i
 inner join open.or_order  o on  o.order_id =i.order_id
inner join open.or_order_activity  oa on oa.order_id = o.order_id and o.task_type_id=  oa.task_type_id
inner join open.or_task_type tt on  tt.task_type_id = o.task_type_id
left join  ge_items  it  on  it.items_id = i.items_id 
 where i.order_id in (370578052, 370641331)
