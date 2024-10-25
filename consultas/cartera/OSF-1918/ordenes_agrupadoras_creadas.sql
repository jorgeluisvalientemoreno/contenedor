--ordenes_agrupadoras_creadas 
 select o.task_type_id,
        t.description,
        o.order_id,
        o.order_status_id status ,
        o.operating_unit_id,
        o.created_date, 
        o.legalization_date,
        o.causal_id,
        c.description,
        c.class_causal_id,
        oi.items_id,
        i.description,
        i.item_classif_id,
        oi.legal_item_amount,
        oi.value,
        oi.total_price
  from or_order o
 inner join or_task_type t on o.task_type_id = t.task_type_id
 inner join or_order_items  oi on oi.order_id = o.order_id
 left join or_order_activity a on a.order_id = o.order_id
 left join servsusc  ss  on ss.sesunuse = product_id
 left join or_requ_Data_value da on da.order_id = o.order_id
 left join open.ge_causal c on c.causal_id = o.causal_id
 left join ge_items  i on i.items_id = oi.items_id
 Where o.created_date >= '01/08/2024'
 and o.task_type_id in (10577,10677)
 and o.order_status_id   in (0,5,8)
 and o.operating_unit_id = 4296
 order by o.order_id  desc 
 
-- 100007378 - % DE COMISION SOBRE EL RECAUDO REALIZADO
 -- 100007380 - COMISION POR CADA SERVICIO RECUPERADO


