select s.inpnsesu,
       s.inpnsusc,
       s.inpnpefa,
       s.inpnmere,
       open.ldc_getedadrp(s.inpnsesu)edad,
       o.task_type_id,
       t.description,
       s.inpnorim,
       o.order_status_id,
       o.operating_unit_id,
       a.activity_id,
       a.subscriber_id,
       a.subscription_id,
       a.product_id
  from ldc_infoprnorp s
  left join or_order  o on s.inpnorim = o.order_id
  left join  or_order_activity  a on  o.order_id = a.order_id
  left join  or_task_type  t on  t.task_type_id = o.task_type_id
 Where s.inpnpefa in (101942)
 and   s.inpnmere = 53
And   s.inpnfere >= '09/02/2023';
