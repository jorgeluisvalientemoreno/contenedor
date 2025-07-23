/***************************************************************************
Propiedad Intelectual de Gases del Caribe
Autor           : Paola Acosta
Fecha           : 10-06-2025
Modificaciones  :
Autor       Fecha           Caso        Descripcion
pacosta     10-06-2025      OSF-4569    Creacion
***************************************************************************/
MERGE INTO OPEN.AB_PREMISE_TYPE A USING
 (SELECT
  47 as PREMISE_TYPE_ID,
  'FINCA' as DESCRIPTION,
  NULL as ACCESS_TIME
  FROM DUAL) B
ON (A.PREMISE_TYPE_ID = B.PREMISE_TYPE_ID)
WHEN NOT MATCHED THEN 
INSERT (
  PREMISE_TYPE_ID, DESCRIPTION, ACCESS_TIME)
VALUES (
  B.PREMISE_TYPE_ID, B.DESCRIPTION, B.ACCESS_TIME)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCRIPTION = B.DESCRIPTION,
  A.ACCESS_TIME = B.ACCESS_TIME;

COMMIT;
/