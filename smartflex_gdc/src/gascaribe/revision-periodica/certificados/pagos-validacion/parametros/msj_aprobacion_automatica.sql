MERGE INTO OPEN.LDC_PARAREPE A USING
 (SELECT
  'MSJ_APROBACION_AUTOMATICA' as "PARECODI",
  NULL as "PAREVANU",
  'VALIDACION NO PAGA' as "PARAVAST",
  'CONTIENE LA CADENA QUE SE RECIBE DESDE EL PORTAL VALIDADOR PARA INDICAR QUE NO SE DEBE PAGAR AL CONTRATISTA' as "PARADESC"
  FROM DUAL
) B
ON (A.PARECODI = B.PARECODI)
WHEN NOT MATCHED THEN 
INSERT (
  PARECODI, PAREVANU, PARAVAST, PARADESC)
VALUES (
  B.PARECODI, B.PAREVANU, B.PARAVAST, B.PARADESC)
WHEN MATCHED THEN
UPDATE SET 
  A.PAREVANU = B.PAREVANU,
  A.PARAVAST = B.PARAVAST,
  A.PARADESC = B.PARADESC;
/
COMMIT;