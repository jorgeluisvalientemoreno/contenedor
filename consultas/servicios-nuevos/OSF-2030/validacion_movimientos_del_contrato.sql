--validacion_movimientos_del_contrato
select co.id_contratista,
       co.id_contrato,
       co.descripcion desc_contrato,
       co.id_tipo_contrato tipo_contrato,
       tc.descripcion  desc_tipo_contrato,
       (select fm.fecha_maxasig from open.ldc_contfema fm where fm.id_contrato=co.id_contrato) f_max_asignacion,
       co.fecha_final   f_max_legalizacion,
       co.valor_total_contrato valor_contratado,
       co.valor_asignado valor_asignado,
       co.valor_no_liquidado valor_no_liquidado,
       co.valor_liquidado valor_liquidado,
       co.valor_total_pagado valor_pagado,
       co.valor_total_contrato - nvl(co.valor_asignado,0) - nvl(co.valor_no_liquidado,0) - nvl(co.valor_liquidado, 0) cupo,
       co.status
from open.ge_contrato co
inner join open.ge_tipo_contrato tc on tc.id_tipo_contrato=co.id_tipo_contrato
where co.id_contrato in (9441)
