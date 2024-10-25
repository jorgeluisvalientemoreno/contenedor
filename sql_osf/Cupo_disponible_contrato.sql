select gc.id_contrato,
       gc.valor_total_contrato,
       gc.valor_total_pagado,
       gc.valor_asignado,
       gc.valor_no_liquidado,
       gc.valor_liquidado,
       sum(gc.valor_asignado + gc.valor_no_liquidado + gc.valor_liquidado) valor_descontar_calculado_cupo,
       (gc.valor_total_pagado - sum(gc.valor_asignado + gc.valor_no_liquidado + gc.valor_liquidado)) cupo_disponible
  from open.ge_contrato gc
 where gc.id_contrato = 9303
 group by gc.id_contrato,
          gc.valor_total_contrato,
          gc.valor_total_pagado,
          gc.valor_asignado,
          gc.valor_no_liquidado,
          gc.valor_liquidado;
