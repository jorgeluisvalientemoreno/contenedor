select c.id_contratista,
       g.id_contratista,
       c.nombre_contratista,
       g.id_tipo_contrato,
       g.id_contrato,
       g.descripcion,
       g.status,
       g.fecha_inicial,
       g.fecha_final,
       ca.fecha_maxasig,
       g.valor_total_contrato,
       g.valor_total_pagado,
       u.operating_unit_id,
       u.name,
       u.oper_unit_status_id,
       s.description
  from open.ge_contratista c
 inner join open.ge_contrato g on c.id_contratista = g.id_contratista
 inner join ldc_contfema  ca  on ca.id_contrato = g.id_contrato
 inner join open.or_operating_unit  u on c.id_contratista = u.contractor_id
 inner join or_oper_unit_status  s on u.oper_unit_status_id = s.oper_unit_status_id
 where g.status = 'AB'
   and operating_unit_id in (4274)
