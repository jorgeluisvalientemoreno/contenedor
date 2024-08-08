select gc.id_contrato,
       gc.descripcion,
       gc.fecha_inicial,
       gc.fecha_final,
       gc.valor_liquidado,
       gc.valor_asignado,
       gc.valor_no_liquidado
  from open.ge_contrato gc
 where gc.id_contrato = 6341
union all
SELECT 6341 id_contrato,
       'VALOR_ASIGNADO_REAL_ORDENES' descripcion,
       null fecha_inicial,
       null fecha_final,
       null valor_liquidado,
       nvl(SUM(nvl(oo.estimated_cost, 0)),0) valor_asignado,
       null valor_no_liquidado
  from open.or_order oo
 where oo.order_status_id in (5, 6, 7)
   and oo.defined_contract_id = 6341
union all

SELECT 6341 id_contrato,
       'VALOR_NO_LIQUIDADO_REAL_ORDENES' descripcion,
       null fecha_inicial,
       null fecha_final,
       null valor_liquidado,
       null valor_asignado,
       sum(nvl(estimated_cost, 0)) valor_no_liquidado
  FROM open.or_order o
 inner join open.ge_causal gc
    on gc.causal_id = o.causal_id
   and class_causal_id = 1
 WHERE o.order_status_id = 8
   AND o.defined_contract_id = 6341
   AND o.IS_PENDING_LIQ is not null
union all
select 6341 id_contrato,
       'VALOR_LIQUIDADO_REAL_ORDENES' descripcion,
       null fecha_inicial,
       null fecha_final,
       sum(nvl(gda.valor_total, 0)) valor_liquidado,
       null valor_asignado,
       null valor_no_liquidado
  FROM open.ge_detalle_acta gda, open.ge_acta ga
 WHERE ga.id_contrato = 6341
   and ga.id_tipo_acta = 1
   and gda.id_acta = ga.id_acta
   AND gda.affect_contract_val = 'Y';
