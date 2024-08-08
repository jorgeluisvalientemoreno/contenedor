select distinct t.task_type_id, c.causal_id, c.description, t.is_warranty
from open.LDC_TT_CAUSAL_WARR t, open.ge_causal c
where t.causal_id=c.causal_id
and  exists(select null from open.or_task_type_causal tc where t.task_type_id=tc.task_type_id and t.causal_id=tc.causal_id)
;
select order_id, o.order_value, o.charge_status, o.legalization_date
from open.or_order o
where task_type_id=12135		
  and order_status_id=8
  and causal_id=9546
  and legalization_date>='01/01/2018';
  
 * FMTTPS: TT Principal x TT Secundario (Garantía)
 * FMTTCW: Garantía por causales de Legalización para TT
