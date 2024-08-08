select ottc.task_type_id || ' - ' || ott.description Tipo_trabajo,
       gc.causal_id || ' - ' || gc.description Causal,
       gc.class_causal_id || ' - ' || gcc.description Clasificaion
  from open.or_task_type_causal ottc,
       open.ge_causal           gc,
       open.ge_class_causal     gcc,
       open.or_task_type        ott
 where ottc.task_type_id in (12135, 12138, 12143)
   and gc.class_causal_id = gcc.class_causal_id
   and ott.task_type_id = ottc.task_type_id
