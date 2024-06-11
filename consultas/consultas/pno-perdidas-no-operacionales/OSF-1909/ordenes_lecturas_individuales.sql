-- ordenes_lecturas_individuales
SELECT o.operating_unit_id  Unidad_Trabajo,
       o.task_type_id       Tipo_Trabajo,
       oi.items_id           Item,
       i.description         Desc_Item,
       i.item_classif_id     Tipo_Item,
       o.is_pending_liq     Pendiente_Liquidacion,
       count (distinct o.order_id) cantidad_ordenes,
       sum(oi.legal_item_amount) Cant_Item,
       sum(oi.value)             valor_Item
  FROM or_order o
  inner join or_order_items oi  on oi.order_id = o.order_id
  inner join ge_items i  on i.items_id = oi.items_id
 WHERE o.task_type_id in (12626, 12617, 12626, 10043)
   and o.order_status_id = 8
   and trunc(o.legalization_date) = '22/05/2024'
  and o.is_pending_liq = 'Y'
   and o.defined_contract_id is not null
 and (o.saved_data_values is null or  saved_data_values != 'ORDER_GROUPED')
group by o.operating_unit_id, o.task_type_id, oi.items_id, i.description, i.item_classif_id, o.is_pending_liq
order by o.operating_unit_id, o.task_type_id;



   /*and not exists
   (select null
   from or_order_items  do, ge_items i2
   where do.order_id = o.order_id
   and   i2.items_id = do.items_id
   and i2.item_classif_id =51)*/
   
   
   --and o.is_pending_liq = 'Y'
  --and i.item_classif_id  not in (3,8,21,2)

   --and i.item_classif_id  not in (3,8,21,2)
 --,o.saved_data_values
   --
/*        ---SELECT  dtotg.orden_agrupadora,
                oi.items_id,
                sum(oi.legal_item_amount) legal_item_amount,
                sum(oi.value) value
        FROM    detalle_ot_agrupada dtotg,
                or_order_items oi,
                ge_items i
        WHERE   oi.order_id = dtotg.orden
        AND     i.items_id = oi.items_id
        AND     dtotg.estado = 'R'
        AND     i.item_classif_id  not in (3,8,21,2)
        GROUP BY dtotg.orden_agrupadora, oi.items_id;*/
