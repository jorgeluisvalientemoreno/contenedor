select p.package_id  Solicitud, 
       p.package_type_id || '-  ' || pt.description  Tipo_Solicitud,  
       o.order_id Orden, 
       o.order_status_id || ' - ' || os.description  Estado_Orden, 
       o.task_type_id || '-  ' || tt.description  Tipo_Trabajo, 
       o.causal_id || ' - ' || c.description  Causal, 
       o.legalization_date  Fecha_Legalizacion  
from open.mo_packages  p
inner join open.ps_package_type  pt on pt.package_type_id = p.package_type_id
inner join open.mo_motive  m on p.package_id = m.package_id
inner join open.ps_motive_status  ms on p.motive_status_id = ms.motive_status_id
inner join open.or_order_activity  a on p.package_id = a.package_id
inner join open.or_order  o on a.order_id = o.order_id 
inner join open.or_order_status  os on o.order_status_id = os.order_status_id
inner join open.or_task_type  tt on tt.task_type_id = o.task_type_id
inner join open.ge_causal  c on c.causal_id = o.causal_id
where o.order_id = 246621831