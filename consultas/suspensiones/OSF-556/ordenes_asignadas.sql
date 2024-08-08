select a.product_id,
       a.subscription_id,
       p.product_status_id,
       ss.sesuesfn,
       o.task_type_id,
       t.description,
       p.suspen_ord_act_id  actividad_suspension,
       a.package_id,
       a.activity_id,
       a.package_id,
       o.order_id,
       o.order_status_id,
       o.operating_unit_id,
       o.created_date
  from open.or_order o
 inner join open.or_task_type t on t.task_type_id = o.task_type_id
 inner join open.or_order_activity a on a.order_id = o.order_id
 left join open.servsusc  ss on ss.sesunuse = a.product_id
 left join open.pr_product  p on p.product_id = a.product_id
 left join open.ps_product_status  ep on ep.product_status_id = p.product_status_id
 Where ss.sesuesfn = 'A'
    and o.task_type_id in (10835) -- reconexión RP
    and o.order_status_id in (5)
 order by o.created_date desc;

-- and o.task_type_id in (12527, 12530) -- reconexión cartera
-- and o.task_type_id in (11022,11029) -- autoreconectados RP
-- and o.task_type_id in (10450) -- suspensiones RP
-- and o.task_type_id in (12526, 10546, 12528) -- suspensiones cartera

