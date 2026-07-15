select open.or_operating_unit.name, open.ldc_item_uo_lr.actividad,
  open.ge_items.description, open.ldc_item_uo_lr.item, ge_items1.description as
  description1, open.ldc_item_uo_lr.liquidacion,
  open.ldc_item_uo_lr.unidad_operativa,
  or_operating_unit.name
from open.ldc_item_uo_lr 
     inner join open.or_operating_unit on ldc_item_uo_lr.unidad_operativa =  or_operating_unit.operating_unit_id 
     inner join open.ge_items on open.ge_items.items_id = ldc_item_uo_lr.actividad
     inner join open.ge_items ge_items1 on ge_items1.items_id = ldc_item_uo_lr.item
where open.ldc_item_uo_lr.actividad  in (100009056)
and open.ldc_item_uo_lr.unidad_operativa = 4607
