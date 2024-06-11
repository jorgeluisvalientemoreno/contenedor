--validación_ordenes_individuales
--ordenes_agrupadoras_generadas
select o.order_id,
       o.order_status_id,
       o.created_date,
       o.assigned_date,
       o.legalization_date,
       o.defined_contract_id,
       c.status,
       o.is_pending_liq,
       o.saved_data_values,
       oi.items_id,
       i.description,
       i.item_classif_id,
       oi.assigned_item_amount,
       oi.legal_item_amount,
       oi.value
from or_order o
inner join or_order_items  oi  on oi.order_id = o.order_id
inner join ge_items  i  on i.items_id = oi.items_id
left join ge_contrato  c  on c.id_contrato = o.defined_contract_id
where o.created_date >= '22/05/2024 11:00:00'
and   o.saved_data_values = 'ORDER_GROUPED'

/*i.item_classif_id != 2
and   o.order_id in (304863368,304396324,304396327)*/


       /*oi.assigned_item_amount,
       oi.legal_item_amount,
       oi.value,
       oi.order_items_id,
       oi.total_price,
       oi.order_activity_id,*/
