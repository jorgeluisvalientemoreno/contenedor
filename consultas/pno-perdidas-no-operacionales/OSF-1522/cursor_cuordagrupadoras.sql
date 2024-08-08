--cursor_cuordagrupadoras is
SELECT oo.created_date,
        ooa.activity_id,
       TRUNC(oo.legalization_date),
       oo.operating_unit_id,
       oo.DEFINED_CONTRACT_ID,
       aa.GEOGRAP_LOCATION_ID,
       oo.order_id orden,
       ooi.*
  FROM or_order          oo,
       or_order_activity ooa,
       or_order_items    ooi,
       ab_address        aa
 where oo.order_id = ooa.order_id
   and oo.order_id = ooi.order_id
   and oo.EXTERNAL_ADDRESS_ID = aa.ADDRESS_ID
   and EXTRACT(YEAR FROM oo.legalization_date) = 2023 --inuYear
   and EXTRACT(MONTH FROM oo.legalization_date) = 9 --inuMonth
   AND ooa.activity_id = 102008 --nuActiLecInd -- nuActiLecInd = DALD_PARAMETER.fnuGetNumeric_Value('COD_ACTIVIDAD_LECTURA_INDUS');
   AND oo.operating_unit_id = 4439 --inuOperatingUnit
   and oo.task_type_id = 12617
   AND oo.order_status_id = 8
   and oo.IS_PENDING_LIQ = 'Y'
   AND oo.saved_data_values = 'ORDER_GROUPED'
