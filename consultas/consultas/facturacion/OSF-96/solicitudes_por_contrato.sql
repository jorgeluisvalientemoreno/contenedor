select a.subscription_id  Contrato, 
       p.package_id  Solicitud, 
       p.package_type_id  Tipo_Solicitud, 
       p.motive_status_id || ' - ' || m.description as Estado_Solicitud,
       o.order_id  Orden, 
       o.order_status_id || ' - ' || os.description as Estado_Orden, 
       p.contact_id || ' - ' || s.subscriber_name || ' ' || s.subs_last_name as Solicitante, 
       s.identification  Identificacion, 
       o.created_date  Fecha_Creacion_Orden
from open.mo_packages p
inner join open.or_order_activity  a on p.package_id = a.package_id
inner join open.ps_motive_status  m on p.motive_status_id = m.motive_status_id
inner join open.or_order  o on a.order_id = o.order_id 
inner join open.or_order_status  os on o.order_status_id = os.order_status_id
inner join open.ge_subscriber  s on p.contact_id = s.subscriber_id 
where a.subscription_id = 48034152
and o.created_date >= '27/07/2022'
order by o.created_date desc;