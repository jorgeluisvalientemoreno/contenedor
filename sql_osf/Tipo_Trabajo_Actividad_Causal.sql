select ottc.task_type_id || ' - ' || ott.description Tipo_trabajo,
       otti.items_id || ' - ' || gi.description Actividad,
       gc.causal_id || ' - ' || gc.description Causal,
       gc.class_causal_id || ' - ' || gcc.description Clasificaion
  from open.or_task_type_causal ottc,
       open.ge_causal           gc,
       open.or_task_type        ott,
       open.ge_class_causal     gcc,
       open.or_task_types_items otti,
       open.ge_items            gi
 where 1 = 1
   and ottc.task_type_id in (12579, 11436) --(11359, 11360, 11361, 11362)
      --and ottc.causal_id in (3904, 3905, 3906, 3907)
   and ottc.causal_id = gc.causal_id
   and ottc.task_type_id = ott.task_type_id
   and gc.class_causal_id = gcc.class_causal_id
   and otti.task_type_id = ott.task_type_id
   and otti.items_id = gi.items_id;
