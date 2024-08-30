--VAlor contrato 
select gc.id_contrato,
       gc.valor_total_contrato,
       gc.valor_total_pagado,
       gc.valor_asignado,
       gc.valor_no_liquidado,
       gc.valor_liquidado
  from open.ge_contrato gc
 where gc.id_contrato = 9321
union all
--ValorAsignado
select 9321,
       0,
       0,
       (SELECT SUM(nvl(oo.estimated_cost, 0)) VALOR_ASIGNADO
          from open.or_order oo
         where oo.order_status_id in (5, 6, 7)
           and oo.defined_contract_id = 9321 --, 9321 y 9321
        ) --;
      ,
       --Valor_No_Liquidado
       (SELECT sum(nvl(estimated_cost, 0)) VALOR_NO_LIQUIDADO
          FROM open.or_order o
         inner join open.ge_causal gc
            on gc.causal_id = o.causal_id
           and class_causal_id = 1
         WHERE o.order_status_id = 8
           AND o.defined_contract_id = 9321
           AND o.IS_PENDING_LIQ is not null),
       
       --Valor_Liquidado
       (SELECT sum(nvl(gda.valor_total, 0)) VALOR_LIQUIDADO
          FROM open.ge_detalle_acta gda, open.ge_acta ga
         WHERE ga.id_contrato = 9321 --, 9321 y 9321
           and ga.id_tipo_acta = 1
           and gda.id_acta = ga.id_acta
           AND gda.affect_contract_val = 'Y')
  from dual;

select sum(ga.valor_liquidado)
  from open.ge_acta ga
 where ga.id_contrato = 9321
   and ga.estado IN ('C', 'A')
   AND GA.ID_TIPO_ACTA = 1;

select GDA.DESCRIPCION_ITEMS, GDA.AFFECT_CONTRACT_VAL, SUM(GDA.VALOR_TOTAL)
  from open.ge_detalle_acta gda, OPEN.GE_ACTA GA
 where gda.Id_Acta = GA.ID_ACTA
   AND GA.ID_CONTRATO = 9321
 GROUP BY GDA.DESCRIPCION_ITEMS, GDA.AFFECT_CONTRACT_VAL;
