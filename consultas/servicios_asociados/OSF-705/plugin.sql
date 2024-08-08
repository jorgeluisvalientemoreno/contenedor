select o.task_type_id,
       t.description,
       o.causal_id,
       c.description,
       o.procedimiento,
       o.descripcion,
       o.orden_ejec,
       o.activo
  from open.ldc_procedimiento_obj o
 inner join open.or_task_type  t  on t.task_type_id = o.task_type_id
 left join open.ge_causal  c  on c.causal_id = o.causal_id
 where o.task_type_id = 12667
   and o.causal_id = 3799
