select p.subscriber_id  Cliente, 
       p.package_id  Solicitud, 
       p.package_type_id || '-  ' || pt.description as Tipo_Solicitud,  
       p.motive_status_id || '-  ' || ms.description as Estado_Solicitud, 
       p.request_date  Fecha_Registro, 
       p.reception_type_id  Medio_Recepcion,
       o.order_id Orden, 
       o.order_status_id || ' - ' || os.description as Estado_Orden, 
       o.created_date  Fecha_Creacion 
from open.mo_packages  p
inner join open.ps_package_type  pt on pt.package_type_id = p.package_type_id
inner join open.mo_motive  m on p.package_id = m.package_id
inner join open.ps_motive_status  ms on p.motive_status_id = ms.motive_status_id
inner join open.or_order_activity  a on p.package_id = a.package_id
inner join open.or_order  o on a.order_id = o.order_id 
inner join open.or_order_status  os on o.order_status_id = os.order_status_id
where p.package_type_id = 545
and p.motive_status_id in (13)
and p.request_date >= '29/07/2022' 
and p.reception_type_id = 4
and m.causal_id = 4
order by p.request_date asc