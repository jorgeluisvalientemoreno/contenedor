select a.product_id,
       o.order_id,
       o.task_type_id,
       t.description,
       a.activity_id,
       i.description,
       o.order_status_id,
       o.created_date
  From open.or_order o
 inner join open.or_order_activity  a on a.order_id = o.order_id 
 inner join or_task_type t on t.task_type_id = o.task_type_id
 inner join ge_items i on i.items_id = a.activity_id
 where a.product_id in (40000007)
   and o.order_status_id in (0, 5)
   order by o.created_date desc
