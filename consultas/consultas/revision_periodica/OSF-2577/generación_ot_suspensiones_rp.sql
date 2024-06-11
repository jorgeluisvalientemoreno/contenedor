--generación_ot_suspensiones_rp
select t.orden,
       t.tipotrabajo || ' - ' || tt.description tipo_trabajo,
       t.causal || ' - ' || c.description causal,
       t.solicitud,
       t.unidadopera,
       t.procesado
  from open.ldc_ordentramiterp t
 inner join open.or_task_type  tt on tt.task_type_id = t.tipotrabajo
 inner join open.ge_causal c on c.causal_id = t.causal
 where t.solicitud in (207202807, 207202819, 207202829, 207203903, 205042862)
