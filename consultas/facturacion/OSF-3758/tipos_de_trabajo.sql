Select t.task_type_id, 
t.description,
t.short_name,
t.is_anull,
t.try_autom_assigment,
t.uses_oper_sector,
t.task_type_classif,
ctt.description  as CLASIFICACION_TIPO_TRAB,
c.causal_id,
dc.description  as CAUSAL,
dc.causal_type_id,
dc.class_causal_id,
t.add_items_allowed,
t.add_net_allowed,
t.comment_required,
t.warranty_period,
t.concept,
(select co.concdesc from open.concepto  co where t.concept = co.conccodi)"CONCEPTO",
t.sold_engineering_ser,
(select tc.comment_type_id ||'-'|| tco.description from open.or_task_type_comment  tc, open.ge_comment_type  tco where t.task_type_id = tc.task_type_id and tc.task_type_id = tco.comment_type_id)"TIPO_COMENTARIO",
(select tcont.contract_type_id ||'-'|| dtcont.descripcion from open.ct_tasktype_contype tcont, open.ge_tipo_contrato  dtcont where t.task_type_id = tcont.tasktype_contype_id and tcont.contract_type_id = dtcont.id_tipo_contrato)"TIPO_CONTRATO",
t.priority,
t.nodal_change,
t.arranged_hour_allowed,
t.object_id,
t.task_type_group_id,
t.work_days,
t.compromise_crm,
t.use_,
t.notificable,
t.gen_admin_order,
t.upd_items_allowed,
t.print_format_id
from open.or_task_type  t
inner join open.ge_task_class  ctt  on t.task_type_classif = ctt.task_class_id
left join open.or_task_type_causal c  on t.task_type_id = c.task_type_id
left join open.ge_causal  dc  on c.causal_id = dc.causal_id
where t.task_type_id in (12130, 10539, 12134)
  
