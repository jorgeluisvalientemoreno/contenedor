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
  from or_order o
 inner join or_task_type t on t.task_type_id = o.task_type_id
 inner join or_order_activity a on a.order_id = o.order_id
 inner join pr_product  p  on p.product_id = a.product_id
 Where o.task_type_id = 11056
   and o.order_status_id in (5)
   and p.product_status_id = 2
   and exists
   (select null
   from pr_prod_suspension  sp
   where sp.product_id = a.product_id
   and sp.suspension_type_id != 106
   and sp.active = 'Y')
order by o.created_date desc;

