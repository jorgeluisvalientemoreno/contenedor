select a.*, rowid
  from OPEN.GE_ATTRIBUTES a
 where a.attribute_type_id = 1
   and a.module_id = 9
   and a.attribute_class_id = 8
   and a.valid_expression is null
   and a.length is null 
   and a.precision is null
   and a.scale is null
   and a.default_value is null
   and a.is_fix_or_variable is null
--and a.name_attribute like ('%FLAG%')
