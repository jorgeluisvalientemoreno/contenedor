select  s.sesucicl,
        u.contractor_id,
        o.operating_unit_id, 
        count (t.description)
  from open.or_order o
 inner join open.or_task_type t on t.task_type_id = o.task_type_id
 inner join open.or_order_activity a on a.order_id = o.order_id
 left join  or_operating_unit  u on u.operating_unit_id = o.operating_unit_id
 left join  open.pr_product  p on p.product_id = a.product_id 
 left join  open.servsusc  s on s.sesunuse = a.product_id 
 left join  open.ge_items  i on i.items_id = a.activity_id
 Where o.task_type_id in (12617)
 and    o.order_status_id in (5)
 and    o.operating_unit_id = 4006
and    s.sesucicl = 1749
 group by s.sesucicl,
       u.contractor_id,
        o.operating_unit_id
 order by s.sesucicl desc;
