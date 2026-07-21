select a.*, rowid from OPEN.OR_SUPPORT_ACTIVITY a;
select a.*, rowid
  from OPEN.OR_ACT_BY_REQ_DATA a
 where a.config_expression_id = 121411160;
select a.*, rowid
  from OPEN.OR_ACT_BY_REQ_ELEM a
 where a.config_expression_id = 121411160;
select a.*, rowid from OPEN.GE_ACT_PRODTYPE_STAT a;
select a.*, rowid from OPEN.OR_PLANNED_ACTIVIT a;
select a.ACT_BY_TASK_MOD_ID,
       a.TASK_CODE codigo_tarea_wf,
       a.MODULE_ID || ' - ' || gm.description Modulo,
       a.ITEMS_ID || ' - ' || ge.description Actividad,
       a.CONFIG_EXPRESSION_ID
  from OPEN.OR_ACT_BY_TASK_MOD a
 inner join open.ge_module gm
    on gm.module_id = a.module_id
 inner join open.ge_items ge
    on ge.items_id = a.items_id
 where 1 = 1
   and a.task_code in (31, 33, 100586)
      -- and a.config_expression_id = 121411160
   and 1 = 1;
