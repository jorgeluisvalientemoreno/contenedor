--validación_ordenes_individuales
select o.* 
from or_order o
inner join or_order_items  oi  on oi.order_id = o.order_id
inner join ge_items  i  on i.items_id = oi.items_id




/*distinct (oi.order_id),
       o.order_status_id
       o.defined_contract_id,
       oi.items_id,
       i.description,
       i.item_classif_id,
       oi.assigned_item_amount,
       oi.legal_item_amount,
       oi.value,
       oi.order_items_id,
       oi.total_price,
       oi.order_activity_id,
       o.defined_contract_id,
       o.saved_data_values,
       o.created_date,
       o.legalization_date*/
       
     /*  where i.item_classif_id != 2
and   o.order_id in (304863368,304396324,304396327)*/
