select ag.orden_agrupadora,
       ag.estado,
       sum(oi2.legal_item_amount),
       sum(oi2.value),
       oi.items_id,
       oi.legal_item_amount,
       oi.value,
       sum(oi2.legal_item_amount) - oi.legal_item_amount  Dif_cant,
       sum(oi2.value) - oi.value  Dif_Valores
from open.detalle_ot_agrupada ag
inner join open.or_order_items oi on oi.order_id=ag.orden_agrupadora
inner join open.ge_items i on i.items_id=oi.items_id 
inner join open.or_order_activity a on a.order_id=ag.orden
inner join open.or_order_items oi2 on oi2.order_id=a.order_id and oi2.order_items_id=a.order_item_id and oi.items_id=oi2.items_id
group by ag.orden_agrupadora,
       ag.estado,
       oi.items_id,
       oi.legal_item_amount,
       oi.value
