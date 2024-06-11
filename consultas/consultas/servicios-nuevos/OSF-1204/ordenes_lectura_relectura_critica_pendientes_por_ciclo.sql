select  o.task_type_id, 
      o.order_status_id,
      count (a.product_id)  productos
  from open.or_order o
 inner join open.or_task_type t on t.task_type_id = o.task_type_id
 inner join open.or_order_activity a on a.order_id = o.order_id
 left join  open.pr_product  p on p.product_id = a.product_id 
 left join  open.servsusc  s on s.sesunuse = a.product_id 
 left join  open.ge_items  i on i.items_id = a.activity_id
 Where o.task_type_id in (12617, 10043, 12619)
 and    o.order_status_id in (5,0)
 and    s.sesucicl = 208
 group by o.task_type_id, o.order_status_id;
