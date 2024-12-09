select a.product_id,
       p.product_status_id,
       o.order_id,
       o.task_type_id,
       t.description,
       a.activity_id,
       i.description,
       o.order_status_id,
       o.created_date,
       o.operating_unit_id,
       s.sesucicl,
       a.subscription_id,
       o.defined_contract_id
  from or_order o
 inner join or_order_activity  a  on a.order_id = o.order_id
 inner join or_task_type  t  on t.task_type_id = o.task_type_id
 inner join ge_items  i  on i.items_id = a.activity_id
 inner join pr_product  p  on p.product_id = a.product_id
 inner join servsusc  s  on s.sesunuse = a.product_id
 where o.task_type_id = 12155
   and o.order_status_id in (5)
   and not exists (select null
    from ldc_otlegalizar  l
     where l.order_id = o.order_id)
 /*   and exists
    (select null 
    from ge_item_warranty g
      where g.product_id = a.product_id
      and   g.final_warranty_date > sysdate) */
   order by o.created_date desc


  
--   and p.commercial_plan_id not in (4,36,41)

---   and o.order_id = 336813634
