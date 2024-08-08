select a.product_id,
       a.subscription_id,
       o.task_type_id,
       t.description,
       a.package_id,
       mo.motive_status_id,
       sm.description,
       a.activity_id,
       o.order_id,
       o.order_status_id,
       o.operating_unit_id,
       o.causal_id,
       c.description,
       c.class_causal_id,
       o.legalization_date,
       o.created_date,
       co.order_comment
  from or_order o
 inner join or_task_type t on t.task_type_id = o.task_type_id
  inner join or_order_activity a on a.order_id = o.order_id
 inner join pr_product p  on p.product_id = a.product_id
 left join or_order_comment  co on co.order_id = o.order_id
 left join open.mo_packages  mo on mo.package_id = a.package_id
 left join ps_motive_status sm on sm.motive_status_id = mo.motive_status_id
 left join ge_causal c on c.causal_id = o.causal_id
 Where o.task_type_id in (5005)
   and o.order_id in (242387588,242387594,242387566,242387571,242387581,242387576,242387554,242387557)
   order by o.created_date desc;
