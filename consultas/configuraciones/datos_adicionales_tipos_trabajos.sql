select or_tasktype_add_data.task_type_id,
       open.daor_task_type.fsbgetdescription(or_tasktype_add_data.task_type_id, null) desc_titr,
       or_tasktype_add_data.attribute_set_id,
       ge_attributes_set.description,
       ge_attributes.attribute_id,
       ge_attributes.name_attribute,
       ge_attributes.display_name,
       or_tasktype_add_data.use_,
       or_tasktype_add_data.active,
       ge_attrib_set_attrib.mandatory
  from open.or_tasktype_add_data
  inner join open.ge_attrib_set_attrib on ge_attrib_set_attrib.attribute_set_id = or_tasktype_add_data.attribute_set_id
  inner join open.ge_attributes on ge_attributes.attribute_id = ge_attrib_set_attrib.attribute_id
  inner join open.ge_attributes_set on ge_attributes_set.attribute_set_id = or_tasktype_add_data.attribute_set_id
   
