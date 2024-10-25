with contratos_abiertos as
 (select gc.id_contrato,
         gc.descripcion,
         gc.id_tipo_contrato,
         (select tc.descripcion
            from open.ge_tipo_contrato tc
           where tc.id_tipo_contrato = gc.id_tipo_contrato) desc_tipo_contrato,
         gc.id_contratista,
         (select co.nombre_contratista
            from open.ge_contratista co
           where co.id_contratista = gc.id_contratista) nombre_contratista,
         gc.fecha_inicial,
         gc.fecha_final,
         gc.valor_total_contrato,
         gc.valor_total_pagado,
         gc.valor_liquidado,
         (select sum(valor_liquidado)
            from open.ge_acta a
           where a.id_contrato = gc.id_contrato
             and a.id_tipo_acta = 1
             and a.estado = 'C') valor_pagado_calc,
         (select sum(valor_liquidado)
            from open.ge_acta a
           where a.id_contrato = gc.id_contrato
             and a.id_tipo_acta = 1) valor_liquid_calc
    from open.ge_contrato gc
   where gc.status = 'AB'
     and fecha_inicial >= '01/01/2017'
     and valor_total_pagado is not null
     and gc.id_contrato in (9303, 9321, 9324))
select contratos_abiertos.*,
       valor_total_pagado - valor_pagado_calc diferencia_valor_pagado,
       valor_liquidado - valor_liquid_calc diferencia_valor_liquidado
  from contratos_abiertos
