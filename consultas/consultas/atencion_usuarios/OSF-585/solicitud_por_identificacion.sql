select p.contact_id  "Solicitante", 
       p.package_id  "Solicitud", 
       p.package_type_id || '-  ' || pt.description as "Tipo de Solicitud",  
       p.motive_status_id || '-  ' || ms.description as "Estado de Solicitud", 
       p.request_date  "Fecha de Registro"
from open.mo_packages  p
inner join open.ps_package_type  pt on pt.package_type_id = p.package_type_id
inner join open.ps_motive_status  ms on p.motive_status_id = ms.motive_status_id
inner join open.ge_subscriber  ge on ge.subscriber_id = p.contact_id
where p.package_type_id in (100030)
and ge.identification = '1076380919'
order by request_date desc