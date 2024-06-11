select open.or_operating_unit.name,
       open.ldc_item_uo_lr.actividad,
       open.ge_items.description,
       open.ldc_item_uo_lr.item,
       ge_items1.description as description1,
       open.ldc_item_uo_lr.liquidacion,
       open.ldc_item_uo_lr.unidad_operativa
  from open.ldc_item_uo_lr
 inner join open.or_operating_unit on open.ldc_item_uo_lr.unidad_operativa = open.or_operating_unit.operating_unit_id 
 inner join open.ge_items on open.ge_items.items_id = open.ldc_item_uo_lr.actividad
 inner join open.ge_items ge_items1 on ge_items1.items_id = open.ldc_item_uo_lr.item
 where open.ldc_item_uo_lr.actividad in (4000380, 100009343,100008473)
  and open.ldc_item_uo_lr.item = 100005130
   and open.ldc_item_uo_lr.unidad_operativa = 3032
