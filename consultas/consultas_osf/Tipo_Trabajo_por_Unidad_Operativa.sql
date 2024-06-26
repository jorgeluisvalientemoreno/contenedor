SELECT oou.operating_unit_id || ' - ' || oou.name Unidad_Operativa,
       ooutt.task_type_id || ' - ' || ott.description description,
       ooutt.average_time average_time,
       to_char(ooutt.orders_amount) orders_amount,
       to_char(ooutt.qualification) qualification,
       ooutt.time_factor time_factor,
       to_char(ooutt.operating_unit_id) operating_unit_id
  FROM open.or_ope_uni_task_type ooutt,
       open.OR_task_type         ott,
       open.or_operating_unit    oou
 WHERE ooutt.task_type_id = ott.task_type_id
   and ooutt.operating_unit_id = oou.operating_unit_id
--   and ooutt.operating_unit_id = inuOperatingUnitId
--   and ooutt.task_type_id = inuTaskType;
