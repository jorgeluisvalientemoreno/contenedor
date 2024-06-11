select ri.codigo,
       ri.descripcion,
       ri.actividad_generar,
       ag.description,
       ri.actividad_validacion,
       av.description
  from open.ldc_resuinsp ri
 inner join  open.ge_items  ag on ag.items_id = ri.actividad_generar
 inner join  open.ge_items  av on av.items_id = ri.actividad_validacion
