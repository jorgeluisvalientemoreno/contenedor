--comparar_cantidades_ot_individuales
select count (o.order_id)  cantidad_individuales,
       count (ag.orden)  cantidad_ind_agrupadas,
       count (o.order_id) - count (ag.orden)  Diferencia
from or_order o
inner join or_order_items oi  on oi.order_id = o.order_id
  inner join ge_items i  on i.items_id = oi.items_id
left join detalle_ot_agrupada  ag on ag.orden = o.order_id
 WHERE o.task_type_id IN (12626, 12617, 12626, 10043)
   and o.order_status_id = 8
   and trunc(o.legalization_date) >= '20/02/2024'
   and trunc(o.legalization_date) <= '22/02/2024'
   and o.defined_contract_id is not null
 and (o.saved_data_values is null or  saved_data_values != 'ORDER_GROUPED')
