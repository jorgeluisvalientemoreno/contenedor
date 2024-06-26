SELECT distinct ora_.actividad || ' - ' || giorigen.description,
                ora_.id_causal,
                ora_.actividad_regenerar || ' - ' || gigenera.description,
                ora_.actividad_wf
  FROM open.OR_REGENERA_ACTIVIDA ORA_ --, open.GE_ITEMS GIA
  left join open.ge_items giorigen
    on giorigen.items_id = ora_.actividad
  left join open.ge_items gigenera
    on gigenera.items_id = ora_.actividad_regenerar
 WHERE ORA_.ACTIVIDAD in (103120,
                          103122,
                          103127,
                          103121,
                          103123,
                          103125,
                          4294446,
                          4294447,
                          4294448,
                          4294449,
                          4295220,
                          4295221)
   and ora_.id_causal in (262,
                          3038,
                          3039,
                          3041,
                          3042,
                          3043,
                          3044,
                          3045,
                          3046,
                          3060,
                          3061,
                          3062,
                          3078,
                          3086,
                          3089,
                          3230,
                          3770,
                          9775)
 order by ora_.actividad || ' - ' || giorigen.description asc,
                ora_.id_causal asc;

SELECT distinct /*+ INDEX(OR_regenera_activida IDX_OR_REGENERA_ACTIVIDA_02)
                                                                                 INDEX(actRegenerar PK_GE_ITEMS) */
                ORA_.ACTIVIDAD || ' - ' || gi_padre.description Actividad_Padre,
                ora_.id_causal || ' - ' || gc.description Causal_Padre,
                decode(ora_.cumplida,
                       1,
                       '1 - Cumplida[Exito]',
                       '0 - No Cumplida[Fallo]') Clasificacion,
                ora_.actividad_regenerar || ' - ' || gi_generar.description Actividad_A_Generar,
                otti.task_type_id || ' - ' || ott.description Tipo_trabajo_A_Generar,
                ora_.actividad_wf Asociada_al_Flujo,
                ora_.estado_final || ' - ' || oos.description Estado_final_padre,
                ora_.tiempo_espera Tiempo_espera_para_generacion,
                decode(ora_.action,
                       1,
                       '1 - Asignar',
                       2,
                       '2 - Bloquear',
                       '3 - Reprogramar') Accion_sobre_la_nueva_orden
--,ora_.try_legalize Intetos_regeneracion
  FROM open.OR_REGENERA_ACTIVIDA ORA_ --, open.GE_ITEMS GIA
/*+ Or_bcRegeneraActivid.CargaTablaRegAct SAO182466 */
  left join open.ge_items gi_padre
    on gi_padre.items_id = ora_.actividad
  left join open.ge_causal gc
    on gc.causal_id = ora_.id_causal
  left join open.ge_items gi_generar
    on gi_generar.items_id = ora_.actividad
  left join open.or_order_status oos
    on oos.order_status_id = ora_.estado_final
  left join open.or_task_types_items otti
    on otti.items_id = ora_.actividad_regenerar
  left join open.or_task_type ott
    on ott.task_type_id = otti.task_type_id
 WHERE ORA_.ACTIVIDAD in (4294447);
