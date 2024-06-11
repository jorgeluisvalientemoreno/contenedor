select a.product_id,
       o.order_id,
       o.task_type_id,
       a.activity_id,
       t.description,
       o.order_status_id,
       o.created_date,
       o.operating_unit_id
  from or_order o
 inner join or_order_activity  a  on a.order_id = o.order_id
 inner join or_task_type  t  on t.task_type_id = o.task_type_id
 where a.product_id = 6626652
and   o.created_date >= '03/11/2023'
 order by o.created_date desc
