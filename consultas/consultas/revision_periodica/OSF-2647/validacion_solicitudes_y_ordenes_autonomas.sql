--validacion_solicitudes_y_ordenes_autonomas
select p.package_id, 
       p.request_date,
       p.subscriber_id,
       p.address_id,
       a.address_id,
       m.subscription_id,
       m.product_id,
       a.order_id, 
       a.task_type_id,
       a.subscriber_id,
       a.subscription_id,
       a.product_id,
       a.register_date
from open.mo_packages  p
inner join open.mo_motive m on p.package_id=m.package_id
inner join open.or_order_activity a on a.subscriber_id=p.subscriber_id and a.subscription_id =m.subscription_id and a.product_id=m.product_id and a.task_type_id=11117
inner join mo_address  d  on d.package_id = p.package_id and d.parser_address_id = a.address_id
where p.package_type_id=100246
 and trunc(p.request_date)=trunc(a.register_date)
 and p.request_date >= '05/06/2024'
  and p.request_date <= '07/06/2024'
