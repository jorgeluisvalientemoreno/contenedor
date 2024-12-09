select ottc.task_type_id || ' - ' || ott.description Tipo_trabajo,
       gc.causal_id || ' - ' || gc.description Causal,
       gc.class_causal_id || ' - ' || gcc.description Clasificaion
  from open.or_task_type_causal ottc,
       open.ge_causal           gc,
       open.or_task_type        ott,
       open.ge_class_causal     gcc
 where ottc.task_type_id in (10217, 12622)
      --ottc.causal_id in ()
   and ottc.causal_id = gc.causal_id
   and ottc.task_type_id = ott.task_type_id
   and gc.class_causal_id = gcc.class_causal_id
