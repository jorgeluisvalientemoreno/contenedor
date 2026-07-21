select a.act_by_task_mod_id,
       a.task_code,
       a.module_id || ' - ' || gm.description Modulo,
       a.items_id || ' - ' || gi.description Actividad,
       a.config_expression_id || ' - ' || gce.description Regla
  from OPEN.OR_ACT_BY_TASK_MOD a
 inner join open.ge_items gi
    on gi.items_id = a.items_id
 inner join open.gr_config_expression gce
    on gce.config_expression_id = a.config_expression_id
 inner join open.ge_module gm
    on gm.module_id = a.module_id
 where a.task_code = 100645;
