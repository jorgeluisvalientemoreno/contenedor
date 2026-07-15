SELECT 'MERGE INTO OPEN.ge_attributes A USING
 (SELECT
  '||attribute_id||' as "ATTRIBUTE_ID",
  '||NVL(TO_CHAR(father_id),'NULL')||' as "FATHER_ID",
  '||attribute_type_id||' as "ATTRIBUTE_TYPE_ID",
  '||module_id||' as "MODULE_ID",
  '||attribute_class_id||' as "ATTRIBUTE_CLASS_ID",
  '||NVL(TO_CHAR(valid_expression),'NULL')||' as "VALID_EXPRESSION",
  '''||name_attribute||''' as "NAME_ATTRIBUTE",
  '||NVL(TO_CHAR(length),'NULL')||' as "LENGTH",
  '||NVL(TO_CHAR(precision),'NULL')||' as "PRECISION",
  '||NVL(TO_CHAR(scale),'NULL')||' as "SCALE",
  '''||default_value||''' as "DEFAULT_VALUE",
  '''||is_fix_or_variable||''' as "IS_FIX_OR_VARIABLE",
  '''||comment_||''' as "COMMENT_",
  '''||display_name||''' as "DISPLAY_NAME"
  FROM DUAL
) B
ON (A.attribute_id = B.attribute_id)
WHEN NOT MATCHED THEN 
INSERT (
  attribute_id,father_id,attribute_type_id,module_id,attribute_class_id,valid_expression,name_attribute,length,precision,scale,default_value,is_fix_or_variable,comment_,display_name)
VALUES (
  B.attribute_id,B.father_id,B.attribute_type_id,B.module_id,B.attribute_class_id,B.valid_expression,B.name_attribute,B.length,B.precision,B.scale,B.default_value,B.is_fix_or_variable,B.comment_,B.display_name)
WHEN MATCHED THEN
UPDATE SET 
  A.father_id = B.father_id,
  A.attribute_type_id = B.attribute_type_id,
  A.module_id = B.module_id,
  A.attribute_class_id = B.attribute_class_id,
  A.valid_expression = B.valid_expression,
  A.name_attribute = B.name_attribute,
  A.length = B.length,
  A.precision = B.precision,
  A.scale = B.scale,
  A.default_value = B.default_value,
  A.is_fix_or_variable = B.is_fix_or_variable,
  A.comment_ = B.comment_,
  A.display_name = B.display_name;
/
COMMIT;
/'
from open.ge_attributes
where attribute_id = 5001496
/