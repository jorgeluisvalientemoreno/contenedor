select a.product_id,
       a.subscription_id,
       o.task_type_id,
       t.description,
       a.package_id,
       a.activity_id,
       o.order_id,
       o.order_status_id,
       o.operating_unit_id,
       o.created_date
  from or_order o
 inner join or_task_type t on t.task_type_id = o.task_type_id
 inner join or_order_activity a on a.order_id = o.order_id
 inner join pr_product p  on p.product_id = a.product_id
 Where o.task_type_id in (5005)
   and o.order_status_id in (5)
   and rownum <= 8
 order by o.created_date desc;
