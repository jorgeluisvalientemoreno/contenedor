select dt.OWNER Propietario,
       dt.TABLE_NAME ENTIDAD,
       decode(nvl(ge.description, '0'), '0', atc.COMMENTS, ge.description) Comentario,
       decode(nvl(ge.entity_id, 0), 0, 'No', 'Si') FWCEA,
       ge.module_id || ' - ' || gm.description Modulo
  from dba_tables dt
  left join open.ge_entity ge
    on ge.name_ = dt.TABLE_NAME
  left join open.ge_module gm
    on gm.module_id = ge.module_id
  left join all_tab_comments atc
    on atc.TABLE_NAME = dt.TABLE_NAME
 where dt.OWNER in ('OPEN', 'ADM_PERSON', 'PERSONALIZACIONES')
   and ge.name_ in
       ('CC_CAUSAL', 'OR_ACT_BY_REQ_DATA', 'OR_ACT_BY_TASK_MOD','GE_SUSPENSION_TYPE');

--select * from all_tab_comments a where a.TABLE_NAME = 'SA_USER'
