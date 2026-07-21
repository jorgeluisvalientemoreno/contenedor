-- tipos de trabajo Adicionales LEGO
select t.tipotrablego_id || ' - ' || ottpadre.description Tipo_Trabajo_Padre,
       t.tipotrabadiclego_id || ' - ' || ott.description Tipo_Trabajo_Adicional,
       t.causaladiclego_id || ' - ' || gc.description Causal
  from open.ldc_tipotrabadiclego t
 inner join open.ge_causal gc
    on gc.causal_id = t.causaladiclego_id
 inner join open.or_task_type ott
    on ott.task_type_id = t.tipotrabadiclego_id
 inner join open.or_task_type ottpadre
    on ottpadre.task_type_id = t.tipotrablego_id
 where 1 = 1
   and t.tipotrablego_id = &TtPadre
 order by t.tipotrablego_id asc
