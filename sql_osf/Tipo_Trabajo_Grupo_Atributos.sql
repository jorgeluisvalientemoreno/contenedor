select TAD.TASK_TYPE_ID || ' - ' || ott.description Tipo_Trabajo,
       TAD.ATTRIBUTE_SET_ID || ' - ' || gas.description Grupo_Atributo,
       DECODE(TAD.USE_,
              'C',
              'Cumplida - Exito',
              'I',
              'Incumplida - Fallo',
              'B',
              'Ambos (Exito - Fallo)',
              'Q',
              'Consulta',
              'N/A') Uso,
       TAD.ORDER_ Orden_Despliegue,
       TAD.ACTIVE ACtivo,
       ga.attribute_id || ' - ' || ga.name_attribute || ' - ' ||
       ga.display_name Atributo
  from OPEN.OR_TASKTYPE_ADD_DATA TAD
 inner join OPEN.GE_ATTRIB_SET_ATTRIB gasa
    on gasa.attribute_set_id = tad.attribute_set_id
 inner join OPEN.GE_ATTRIBUTES_SET gas
    on gas.attribute_set_id = gasa.attribute_set_id
 inner join OPEN.GE_ATTRIBUTES ga
    on ga.attribute_id = gasa.attribute_id
 inner join open.or_task_type ott
    on ott.task_type_id = tad.task_type_id
 where 1 = 1
      --and gasa.attribute_set_id = 13040
      --and gasa.attribute_id = 5002206
      --and tad.attribute_set_id = 14004
   and ott.task_type_id = 11056
 order by ott.task_type_id;
