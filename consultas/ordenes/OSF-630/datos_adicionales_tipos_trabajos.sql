select tda.task_type_id,
       open.daor_task_type.fsbgetdescription(tda.task_type_id, null) desc_titr,
       tda.attribute_set_id,
       sete.description,
       a.attribute_id,
       a.name_attribute,
       a.display_name,
       tda.use_,
       tda.active,
       gd.mandatory
  from open.or_tasktype_add_data tda
  inner join open.ge_attrib_set_attrib gd on gd.attribute_set_id = tda.attribute_set_id
  inner join open.ge_attributes        a  on a.attribute_id = gd.attribute_id
  inner join open.ge_attributes_set sete  on sete.attribute_set_id = tda.attribute_set_id
   where tda.task_type_id in (12244)
   and   tda.active = 'Y'
   
