select otti.task_type_id || ' - ' || ott.description Tipo_trabajo,
       otti.items_id || ' - ' || gi.description Activdad,
       gi.item_classif_id
  from open.or_task_types_items otti
  left join open.ge_items gi
    on gi.items_id = otti.items_id
  left join open.or_task_type ott
    on ott.task_type_id = otti.task_type_id
 where 1 = 1
--
and otti.task_type_id in (&tipo_trabajo)
--and gi.item_classif_id = 2
--and gi.items_id in (100011672)
--AND gi.description LIKE '%RECON%'
;

select a.*, rowid
  from OPEN.GE_ITEMS_ATTRIBUTES a
 where 1 = 1
   and A.ITEMS_ID IN (select otti.items_id
                        from open.or_task_types_items otti
                       where otti.task_type_id = &tipo_trabajo);

select a.*, rowid
  from OPEN.GE_ITEMS a
 where A.ITEMS_ID IN (select otti.items_id
                        from open.or_task_types_items otti
                       where otti.task_type_id = &tipo_trabajo);

select a.*, rowid
  from OPEN.OR_PLANNED_ACTIVIT a
 where a.planned_activity_id IN
       (select otti.items_id
          from open.or_task_types_items otti
         where otti.task_type_id = &tipo_trabajo);

--and ott.description like '%DOCUMEN%'
-- and otti.items_id in (100009057, 100009058)
;
select a.*, rowid
  from open.ldc_procedimiento_obj a
 where 1 = 1
      -- and a.activo = 'S'
      --   
   and a.task_type_id in (&tipo_trabajo)
-- and (a.causal_id = 3764 or a.causal_id is null)
---and (a.causal_id = 9517 or a.causal_id is null)
--and upper(a.procedimiento) like upper('%char%') --'LDC_BOPROCESAORDVMP.PGENSUSP_USUNOAUTORIZA'
 order by a.orden_ejec;
--select seq_or_actividades_rol.nextval from dual
