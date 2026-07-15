select * from ge_items where items_id in (4000916,100007093);
select f.item_id,
i.description,
f.object_id,
o.name_,
o.description,
f.is_active,
f.ord_execut
from open.LDC_ITEM_OBJ  f,
open.ge_items  i,
open.ge_object  o
where f.item_id = i.items_id
and f.object_id = o.object_id
--and o.name_ = 'LDC_VALIDACIONESSERVNUEVOS.PROCIERRAOTSERVNUEVOS'
--and f.is_active = 'Y'
and f.item_id  = 4000916
