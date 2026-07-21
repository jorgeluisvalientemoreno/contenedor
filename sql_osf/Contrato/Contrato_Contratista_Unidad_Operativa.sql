select g.id_contratista || ' - ' || c.nombre_contratista Contratista,
       u.operating_unit_id || ' - ' || u.name Unidad_Operativa,
       u.oper_unit_status_id || ' - ' || s.description Estado_Unidad,
       g.id_contrato Contrato,
       g.descripcion,
       g.id_tipo_contrato || ' - ' || gtc.descripcion Tipo_contrato,
       DECODE(g.status, 'AB', 'AB - Abierto', 'CE', 'CE - Cerrado', 'Otro') Estado_Contrato,
       g.fecha_inicial,
       g.fecha_final,
       ca.fecha_maxasig Fecha_Maxima_Asignacion,
       g.valor_total_contrato,
       g.valor_total_pagado
  from open.ge_contratista c
 inner join open.ge_contrato g
    on c.id_contratista = g.id_contratista
 inner join open.ldc_contfema ca --contrato por fecha maxima de asignacion
    on ca.id_contrato = g.id_contrato
 inner join open.or_operating_unit u
    on c.id_contratista = u.contractor_id
 inner join open.or_oper_unit_status s
    on u.oper_unit_status_id = s.oper_unit_status_id
 inner join OPEN.GE_TIPO_CONTRATO gtc
    on gtc.id_tipo_contrato = g.id_tipo_contrato
 where 1 = 1
   and g.status = 'AB'
      -- and operating_unit_id in (4274)
   and 1 = 1;
