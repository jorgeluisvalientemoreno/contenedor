select a.product_id,
       a.subscription_id,
       p.product_status_id,
       o.task_type_id,
       t.description,
       a.package_id,
       a.activity_id,
       o.order_id,
       o.order_status_id,
       o.operating_unit_id,
       o.created_date
  from open.or_order o
 inner join oopen.r_task_type t on t.task_type_id = o.task_type_id
 inner join open.or_order_activity a on a.order_id = o.order_id
 left join  open.pr_product  p on p.product_id = a.product_id and p.product_status_id = 1
 Where o.task_type_id in (12155)
   and a.activity_id in (4000056,100009095)
   and o.order_status_id in (0,5)
order by o.created_date desc;
 
 
