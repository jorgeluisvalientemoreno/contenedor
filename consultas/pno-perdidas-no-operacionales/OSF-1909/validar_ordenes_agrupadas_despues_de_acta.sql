--validar_ordenes_agrupadas_despues_de_acta
select distinct o.is_pending_liq
from detalle_ot_agrupada  ag
inner join open.or_order o on o.order_id = ag.orden_agrupadora
where o.defined_contract_id = 8521
