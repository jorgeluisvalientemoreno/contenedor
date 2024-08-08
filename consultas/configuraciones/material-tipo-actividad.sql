select h.item_material,
       m.description,
       m.item_classif_id,
       h.item_actividad,
       a.description,
       a.item_classif_id
from open.ldc_homoitmaitac h
inner join open.ge_items m on m.items_id=h.item_material
inner join open.ge_items a on a.items_id=h.item_actividad
