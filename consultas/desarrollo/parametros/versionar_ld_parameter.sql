SELECT 'MERGE INTO OPEN.LD_PARAMETER A USING
 (SELECT
  '''||parameter_id||''' as "PARAMETER_ID",
  '''||description||''' as "DESCRIPTION",
  '||NVL(TO_CHAR(numeric_value),'NULL')||' as "NUMERIC_VALUE",
  '''||value_chain||''' as "VALUE_CHAIN"  
  FROM DUAL
) B
ON (A.parameter_id = B.parameter_id)
WHEN NOT MATCHED THEN 
INSERT (
  parameter_id, numeric_value, value_chain, description)
VALUES (
  B.parameter_id, B.numeric_value, B.value_chain, B.description)
WHEN MATCHED THEN
UPDATE SET 
  A.numeric_value = B.numeric_value,
  A.value_chain = B.value_chain,
  A.description = B.description;
/
COMMIT;
/'
from open.ld_parameter
where parameter_id = 'UO_ENTREGA_SALDO_A_FAVOR'
/