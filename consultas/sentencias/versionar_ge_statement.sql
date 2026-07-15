SELECT 'MERGE INTO OPEN.GE_STATEMENT A USING
 (SELECT
  '||statement_id||' as "STATEMENT_ID",
  '||module_id||' as "MODULE_ID",
  '''||description||''' as "DESCRIPTION",
  '''||REPLACE(statement,'''','''''')||''' as "STATEMENT",
  '''||name||''' as "NAME"  
  FROM DUAL
) B
ON (A.statement_id = B.statement_id)
WHEN NOT MATCHED THEN 
INSERT (
  statement_id, module_id, description, statement, name)
VALUES (
  B.statement_id, B.module_id, B.description, B.statement, B.name)
WHEN MATCHED THEN
UPDATE SET 
  A.module_id = B.module_id,
  A.description = B.description,
  A.statement = B.statement,
  A.name = B.name;
/
COMMIT;
/'
from open.ge_statement
where statement_id = 120046267
/