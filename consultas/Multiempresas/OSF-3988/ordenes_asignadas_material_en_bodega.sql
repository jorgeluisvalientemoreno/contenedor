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
 where 1 = 1
   and o.order_id = 356961510
   and o.task_type_id not in (10044)
   --and o.order_status_id in (5)
    and exists 
    (select null
      from or_ope_uni_item_bala  mb
       where mb.operating_unit_id = o.operating_unit_id and mb.balance > 0)
