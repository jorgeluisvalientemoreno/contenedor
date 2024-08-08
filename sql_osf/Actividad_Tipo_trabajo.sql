select otti.task_type_id || ' - ' || ott.description Tipo_Trabajo,
       otti.items_id || ' - ' || gi.description Actividad
  from open.or_task_types_items otti
 inner join open.ge_items gi
    on gi.items_id = otti.items_id
 inner join open.or_task_type ott
    on ott.task_type_id = otti.task_type_id
 where
--otti.task_type_id = 12617 
--4295222 
 gi.items_id in (4294449)
--
;
