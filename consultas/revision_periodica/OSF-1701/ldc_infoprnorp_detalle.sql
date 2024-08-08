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
 Where s.inpnpefa in (111230)
and a.product_id in (51864372,51864534,51911053,51864371,51934320,51864380,51864405,51864505,51864497,51864530,51864365,51864522,51836924,51718876,51718913)
 
  
 --o.created_date >= '12/04/2024'
 
