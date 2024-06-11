select co.id_contrato, co.valor_total_contrato, co.valor_asignado, co.valor_no_liquidado, co.valor_liquidado,
       (select sum(nvl(o.estimated_cost,0)) from open.or_order o where o.order_status_id in (5,6,7,11) and o.defined_contract_id =co.id_contrato) estimado_asignado,
       (select sum(nvl(o.estimated_cost,0)) from open.or_order o, open.ge_causal c where c.causal_id=o.causal_id and c.class_causal_id=1 and o.order_status_id=8 and  o.defined_contract_id =co.id_contrato and is_pending_liq is not null) estimado_lega_sin_acta,
       (select sum(nvl(o.estimated_cost,0)) from open.or_order o, open.ge_causal c where c.causal_id=o.causal_id and c.class_causal_id=1 and o.order_status_id=8 and  o.defined_contract_id =co.id_contrato and is_pending_liq is null) estimado_lega_con_acta,
       (SELECT sum(d.valor_total) FROM OPEN.ge_acta a, open.ge_detalle_Acta d where d.id_acta=a.id_acta and a.id_contrato=co.id_contrato and d.affect_contract_val='Y')  valor_Acta
from open.ge_contrato co
where co.id_contrato IN  (6861,6901,5541,5542,5543,6801,6801);

select *
from open.ge_contrato
where id_contrato IN  (6861,6901,5541,5542,5543,6801,6801);
