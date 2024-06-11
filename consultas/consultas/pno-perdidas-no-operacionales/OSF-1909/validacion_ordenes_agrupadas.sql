select ag.orden_agrupadora,
       ag.estado,
       sum(oi2.legal_item_amount)  suma_items_orden,
       sum(oi2.value)              suma_valores_orden,
       oi.items_id,
       oi.legal_item_amount        Cant_item_agrupadora,
       oi.value                    Valor_item_agrupadora,
       sum(oi2.legal_item_amount) - oi.legal_item_amount  Dif_cant,
       sum(oi2.value) - oi.value  Dif_Valores
from open.detalle_ot_agrupada ag
inner join open.or_order_items oi on oi.order_id=ag.orden_agrupadora
inner join open.ge_items i on i.items_id=oi.items_id and i.item_classif_id=2
inner join open.or_order_activity a on a.order_id=ag.orden
inner join open.or_order_items oi2 on oi2.order_id=a.order_id and oi2.order_items_id=a.order_item_id
group by ag.orden_agrupadora,
       ag.estado,
       oi.items_id,
       oi.legal_item_amount,
       oi.value
       
       
--
--where ag.orden_agrupadora not in (305897760,305897875,305897886,305897675,305897725)
