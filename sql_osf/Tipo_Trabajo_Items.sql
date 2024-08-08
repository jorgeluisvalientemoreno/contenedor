select otti.task_type_id || ' - ' || ott.description Tipo_trabajo,
       otti.items_id || ' - ' || gi.description Activdad, gi.item_classif_id
  from open.or_task_types_items otti
  left join open.ge_items gi
    on gi.items_id = otti.items_id
  left join open.or_task_type ott
    on ott.task_type_id = otti.task_type_id
 where
otti.task_type_id in (12135, 12138, 12143)
and gi.item_classif_id = 2
-- otti.items_id in (100009057, 100009058);
