select m.subscription_id contrato,
       m.product_id producto,
       p.package_id solicitud,
       p.request_date Fecha_Creacion_Solicitud,
       p.motive_status_id estado_solicitud,
       p.package_type_id tipo_solicitud,
       ts.description  Desc_Tipo_Solicitud,
       m.motive_id,
       m.motive_status_id 
from mo_packages p
left join mo_motive m on p.package_id = m.package_id
left join open.ps_package_type ts on ts.package_type_id = p.package_type_id
where subscription_id = 66776783
and p.package_type_id = 100347