select o.order_id, 
o.task_type_id, 
o.order_status_id,
o.operating_unit_id,
o.created_date, 
o.legalization_date,
o.saved_data_values,
o.defined_contract_id,
o.order_value,
i.value,
o.is_pending_liq
  from or_order  o
  inner join or_order_items  i  on i.order_id = o.order_id
 where o.legalization_date >= '01/07/2023'
   --and saved_data_values != 'ORDER_GROUPED'
   and o.operating_unit_id = 4441
   
order by o.created_date desc
