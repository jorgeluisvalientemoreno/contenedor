select *
from open.or_order o, open. OR_ORDER_ACT_VAR_DET d
where --o.task_type_id=12161
  o.order_id=101089070
  and o.order_id=d.order_id;
  
select *
from open.or_order o, OPEN.OR_ORDER_ACT_MEASURE D
where --o.task_type_id=12161
  o.order_id=101089070
  and o.order_id=d.order_id;  
  
  SELECT lt.lab_template_id,
       lt.activity_id,
       vt.description,
       tv.variable_id,
       tv.position,
       tv.repetitions,
       v.comparable,
       v.technical_name,
       v.display_name
FROM GE_LAB_TEMPLATE lt, GE_VARIABLE_TEMPLATE vt, GE_TEMPLATE_VAR tv, GE_VARIABLE v
WHERE lt.variable_template_id = vt.variable_template_id
AND vt.variable_template_id = tv.variable_template_id
AND tv.variable_id = v.variable_id
AND tv.variable_id = 133
;


SELECT *
FROM OPEN.GE_ASSO_SERIAL_ITEMS
