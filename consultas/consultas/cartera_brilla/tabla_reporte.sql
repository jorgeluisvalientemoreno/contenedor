select s.generation_date Fecha_Generacion, 
       ld.type_identification_dc || '-  ' || ti.type_identificacion_desc as Identicacion, 
       ld.identification_number  Numero_Identificacion, ld.full_name  Nombre_Completo, 
       ld.account_number  Producto, 
       tl.type_leader_desc  Tipo_Cliente, 
       ld.mora_age  Edad_Mora, 
       ld.debt_to_dc  Deuda
from open.ld_sample_detai  ld
inner join open.ld_type_identificat_dc  ti on ti.type_identificacion_id = ld.type_identification_dc
inner join open.ld_type_leader_dc  tl on tl.type_leader_id = ld.responsible_dc
inner join open.ld_sample  s on s.sample_id = ld.sample_id;