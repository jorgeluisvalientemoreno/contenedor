SELECT oou.operating_unit_id || ' - ' || oou.name Unidad_Operativa,
       oou.oper_unit_status_id || ' - ' || oous.description Estado,
       oou.*
  FROM OR_OPERATING_UNIT oou
 inner join or_OPER_UNIT_STATUS oous
    on oous.oper_unit_status_id = oou.oper_unit_status_id
 WHERE 1 = 1
      --and oou.OPER_UNIT_STATUS_ID = DALD_PARAMETER.fnuGetNumeric_Value('LDC_STATUS_BODEGA')
   and oou.operating_unit_id = 2363
 order by oou.operating_unit_id;
