select a.product_id,
       a.subscription_id,
       p.product_status_id,
       o.order_id,
       o.task_type_id,
       t.description,
       a.activity_id,
       i.description,
       o.order_status_id,
       o.created_date,
       o.operating_unit_id
  from or_order o
 inner join or_order_activity  a  on a.order_id = o.order_id
 inner join ge_items  i  on i.items_id = a.activity_id
 inner join or_task_type  t  on t.task_type_id = o.task_type_id
 left join pr_product  p  on p.product_id = a.product_id
 where o.task_type_id in (10450)
   and o.order_status_id in (5)
   and exists            
   (select null
   from ldc_marcaprodrepa  dr where dr.producto_id = a.product_id and dr.bloqueo = 'Y')
   and exists
   (select null
   from ldc_marca_producto  mp where mp.id_producto = a.product_id and mp.suspension_type_id in (101,103))
    and  exists
   (select null
   from mo_motive  mo, mo_packages so where mo.subscription_id = a.subscription_id and so.package_id = mo.package_id and so.package_type_id in (100306) and so.motive_status_id = 13)
   order by o.created_date desc
