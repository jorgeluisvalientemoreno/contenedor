
select *
from open.ge_variable
where technical_name LIKE 'FECHA%CALIBR%';


select *
from ge_items_seriado
where items_id=4001211
  and id_items_estado_inv=1
  and operating_unit_id=799
;


select *
from open.LDC_CHANGE_DATA_ORDER
where daor 67693307;



select *
from ge_object
where object_id=121234;

LDC_BODATACOMP_LAGALIZE.CHANGELEGADATE
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
