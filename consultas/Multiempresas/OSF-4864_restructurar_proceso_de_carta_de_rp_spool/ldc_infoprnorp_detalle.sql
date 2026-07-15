select s.inpnsesu,
       s.inpnsusc,
       s.inpnpefa,
       s.inpnmere,
       open.ldc_getedadrp(s.inpnsesu)edad,
       o.task_type_id,
       a.activity_id,
       t.description,
       s.inpnorim,
       o.order_status_id,
       o.operating_unit_id,
       au.asignado,
       au.asignacion,
       au.ordeobse,
       o.created_date,
       s.inpnorec,
       s.inpninco,
       s.inpnfein,
       a.address_id,
       a.subscriber_id,
       a.subscription_id,
       a.product_id,
       ss.sesuesco,
       p.product_status_id
  from ldc_infoprnorp s
  left join or_order  o on s.inpnorim = o.order_id
  left join  or_order_activity  a on  o.order_id = a.order_id
  left join  or_task_type  t on  t.task_type_id = o.task_type_id
  left join servsusc  ss  on ss.sesunuse = a.product_id
  left join pr_product  p  on p.product_id = ss.sesunuse
  left join ldc_order  au on au.order_id = o.order_id
 Where s.inpnpefa in (117837)
  and s.inpnsesu in (51477354,51476490,52112264,1150926,1055850,50063343)

 
--ldc_infoprnorp_espejo_qh_antes

