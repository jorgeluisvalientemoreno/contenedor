select p.package_id solicitud,
       p.request_date Fecha_Creacion_Solicitud,
       p.motive_status_id estado_solicitud,
       p.package_type_id tipo_solicitud,
       ts.description  Desc_Tipo_Solicitud
from mo_packages p
left join open.ps_package_type ts on ts.package_type_id = p.package_type_id
where p.package_id = 201111752
