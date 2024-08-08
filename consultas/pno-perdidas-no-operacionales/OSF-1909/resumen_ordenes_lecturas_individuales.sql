-- resumen_ordenes_lecturas_individuales
select count(*)
  from or_order o
  inner join or_order_items oi  on oi.order_id = o.order_id
  inner join ge_items i  on i.items_id = oi.items_id
 where o.task_type_id in (12626, 12617, 12626, 10043)
   and o.order_status_id = 8
   and trunc(o.legalization_date) >= '21/05/2024'
   and trunc(o.legalization_date) <= '21/05/2024'
   and o.defined_contract_id is not null
  and o.is_pending_liq = 'Y'
 and (o.saved_data_values is null or  saved_data_values != 'ORDER_GROUPED')
