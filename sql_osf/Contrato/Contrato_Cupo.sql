select id_contrato,
       co.status,
       co.descripcion,
       id_tipo_contrato,
       co.fecha_inicial,
       co.fecha_final,
       (select c.fecha_maxasig
          from open.ldc_contfema c
         where c.id_contrato = co.id_contrato) fecha_max_asig,
       id_contratista,
       co.valor_asignado,
       co.valor_liquidado,
       co.valor_no_liquidado,
       co.valor_total_contrato,
       co.valor_total_pagado,
       co.valor_total_contrato - nvl(co.valor_asignado, 0) -
       nvl(co.valor_no_liquidado, 0) - nvl(co.valor_liquidado, 0) cupo
  from open.ge_contrato co
 where id_contrato = 5541
