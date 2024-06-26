select 'ldc_procedimiento_obj',
       a.task_type_id || ' - ' ||
       (select ott.description
          from open.or_task_type ott
         where ott.task_type_id = a.task_type_id) Tipo_trabajo,
       causal_id || ' - ' ||
       (select gc.description
          from open.ge_causal gc
         where gc.causal_id = a.causal_id) Causal_Legalizacion,
       procedimiento,
       descripcion,
       orden_ejec Orden_Ejecucion,
       activo
  from open.ldc_procedimiento_obj a
 where a.activo = 'S'
   and a.task_type_id in (12155)
  -- and (a.causal_id = 3764 or a.causal_id is null)
and (a.causal_id = 9517 or a.causal_id is null)
--and upper(a.procedimiento) like upper( '%prc_asiglegasuspcdmacom%') --'LDC_BOPROCESAORDVMP.PGENSUSP_USUNOAUTORIZA'
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
       oa.nombreobjeto,
       oa.descripcion,
       oa.ordenejecucion Orden_Ejecucion,
       oa.activo
  from personalizaciones.objetos_accion oa
 where oa.activo = 'S'
   and oa.tipotrabajo in (12155)
   and (oa.idcausal = 9517 or oa.idcausal is null)
-- order by oa.ordenejecucion
--and upper(oa.nombreobjeto) like  upper('%prc_asiglegasuspcdmacom%') --
 order by 1, 5;
