MERGE INTO OPEN.LD_PARAMETER A USING
 (SELECT
  'PARAM_MENSAJE_NO_PAGO' as "PARAMETER_ID",
  NULL as "NUMERIC_VALUE",
  'El no pago de la cuota inicial pactada en el acuerdo de pago, acarrea la rescision automatica del presente acuerdo. Por lo tanto, ante este evento, se retrotraeran los efectos del acuerdo y cualquier suspension por no pago podra ejecutarse de inmediato.' as "VALUE_CHAIN",
  'MENSAJE CUPON DE NEGOCIACION DE DEUDA' as "DESCRIPTION"
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
COMMIT;