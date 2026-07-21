select 'ldc_procedimiento_obj',
       a.task_type_id || ' - ' ||
       (select ott.description
          from open.or_task_type ott
         where ott.task_type_id = a.task_type_id) Tipo_trabajo,
       causal_id || ' - ' ||
       (select gc.description
          from open.ge_causal gc
         where gc.causal_id = a.causal_id) Causal_Legalizacion,
       (select gc.causal_type_id || ' - ' || gcc.description
          from open.ge_causal gc
         inner join open.ge_class_causal gcc
            on gcc.class_causal_id = gc.class_causal_id
         where gc.causal_id = a.causal_id) Clasificacion,
       procedimiento,
       descripcion,
       orden_ejec Orden_Ejecucion,
       activo
  from open.ldc_procedimiento_obj a
 where 1 = 1
   and a.activo = 'S'
   and a.task_type_id in (10723)
--and (a.causal_id = 3780 or a.causal_id is null)
-- and upper(a.procedimiento) like upper('%PRCPERSONALIZACIONES PRCOALCARGOCREDITOAVANCEOBRA%') --'LDC_BOPROCESAORDVMP.PGENSUSP_USUNOAUTORIZA'
--order by a.orden_ejec
union all
select 'objetos_accion',
       oa.tipotrabajo || ' - ' ||
       (select ott.description
          from open.or_task_type ott
         where ott.task_type_id = oa.tipotrabajo) Tipo_trabajo,
       oa.idcausal || ' - ' ||
       (select gc.description
          from open.ge_causal gc
         where gc.causal_id = oa.idcausal) Causal_Legalizacion,
       (select gc.causal_type_id || ' - ' || gcc.description
          from open.ge_causal gc
         inner join open.ge_class_causal gcc
            on gcc.class_causal_id = gc.class_causal_id
         where gc.causal_id = oa.idcausal) Clasificacion,
       oa.nombreobjeto,
       oa.descripcion,
       oa.ordenejecucion Orden_Ejecucion,
       oa.activo
  from personalizaciones.objetos_accion oa
 where 1 = 1
   and oa.activo = 'S'
   and oa.tipotrabajo in (10723)
-- and (oa.idcausal = 3780 or oa.idcausal is null)
-- order by oa.ordenejecucion
--
--and upper(oa.nombreobjeto) like  upper('%ldc_plugreconexseg%') --
 order by 1, 5;

select a.*, rowid
  from open.ldc_procedimiento_obj a
 where 1 = 1
      -- 
   and a.activo = 'S'
      --   
   and a.task_type_id in (11056)
---and (a.causal_id = 3780 or a.causal_id is null)
--and upper(a.procedimiento) like upper('%char%') --'LDC_BOPROCESAORDVMP.PGENSUSP_USUNOAUTORIZA'
 order by a.orden_ejec;
select oa.*, rowid
  from personalizaciones.objetos_accion oa
 where 1 = 1
--and oa.tipotrabajo in (11056 )
--   and (oa.idcausal = 3780 or oa.idcausal is null)
-- order by oa.ordenejecucion
--
--and upper(oa.nombreobjeto) like  upper('%ldc_plugreconexseg%') --
;
