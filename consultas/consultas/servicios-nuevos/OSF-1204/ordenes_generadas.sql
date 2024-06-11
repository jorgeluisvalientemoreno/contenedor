select a.product_id,
       a.subscription_id,
       p.product_status_id,
       o.task_type_id,
       t.description,
       a.package_id,
       a.activity_id,
       i.description,
       o.order_id,
       o.order_status_id,
       o.operating_unit_id,
       o.created_date
  from open.or_order o
 inner join open.or_task_type t on t.task_type_id = o.task_type_id
 inner join open.or_order_activity a on a.order_id = o.order_id
 left join  open.pr_product  p on p.product_id = a.product_id 
 left join  open.ge_items  i on i.items_id = a.activity_id
 Where a.product_id in (52521913)
order by o.created_date desc;
 
 
