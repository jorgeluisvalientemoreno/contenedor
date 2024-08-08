select p.subscriber_id  Cliente, 
       p.package_id  Solicitud, 
       p.package_type_id || '-  ' || pt.description as Tipo_Solicitud,  
       p.motive_status_id || '-  ' || ms.description as Estado_Solicitud, 
       p.attention_date  Fecha_Atencion,
       o.order_id Orden, 
       o.order_status_id || ' - ' || os.description as Estado_Orden, 
       o.task_type_id || '-  ' || tt.description  Tipo_Trabajo, 
       o.created_date  Fecha_Creacion   
from open.mo_packages  p
inner join open.ps_package_type  pt on pt.package_type_id = p.package_type_id
inner join open.mo_motive  m on p.package_id = m.package_id
inner join open.ps_motive_status  ms on p.motive_status_id = ms.motive_status_id
inner join open.or_order_activity  a on p.package_id = a.package_id
inner join open.or_order  o on a.order_id = o.order_id 
inner join open.or_order_status  os on o.order_status_id = os.order_status_id
inner join open.or_task_type  tt on tt.task_type_id = o.task_type_id
where p.package_id = 186507925
and o.task_type_id = 12579