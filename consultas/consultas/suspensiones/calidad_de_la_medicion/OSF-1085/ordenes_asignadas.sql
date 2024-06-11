select a.product_id,
       p.product_status_id,
       o.order_id,
       o.task_type_id,
       t.description,
       o.order_status_id,
       o.created_date,
       o.operating_unit_id
  from or_order o
 left join or_order_activity  a  on a.order_id = o.order_id
 left join or_task_type  t  on t.task_type_id = o.task_type_id
 left join pr_product  p  on p.product_id = a.product_id
 where o.task_type_id = 11233
   and o.order_status_id in (5)
  --and a.product_id = 50364318
   order by o.created_date desc
