select p.parameter_id,
       p.description,
       p.value,
       p.val_function,
       p.module_id,
       p.data_type,
       p.allow_update
  from open.ge_parameter p
 where p.parameter_id = 'AGRUPED_TASK_TYPE'
