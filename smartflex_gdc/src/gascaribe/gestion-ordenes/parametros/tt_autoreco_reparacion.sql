MERGE INTO OPEN.LD_PARAMETER A USING
 (SELECT
  'TT_AUTORECO_REPARACION' as "PARAMETER_ID",
  NULL as "NUMERIC_VALUE",
  '10833,10723,12460,11029' as "VALUE_CHAIN",
  'TIPOS DE TRABAJO PARA VALIDAR LA ULTIMA ORDEN DE REVISION Y/O REPARACION PARA AUTORECONECTADOS OSF-2443' as "DESCRIPTION"
  FROM DUAL) B
ON (A.PARAMETER_ID = B.PARAMETER_ID)
WHEN NOT MATCHED THEN 
INSERT (
  PARAMETER_ID, NUMERIC_VALUE, VALUE_CHAIN, DESCRIPTION)
VALUES (
  B.PARAMETER_ID, B.NUMERIC_VALUE, B.VALUE_CHAIN, B.DESCRIPTION)
WHEN MATCHED THEN
UPDATE SET 
  A.NUMERIC_VALUE = B.NUMERIC_VALUE,
  A.VALUE_CHAIN = B.VALUE_CHAIN,
  A.DESCRIPTION = B.DESCRIPTION;
/
COMMIT;
/