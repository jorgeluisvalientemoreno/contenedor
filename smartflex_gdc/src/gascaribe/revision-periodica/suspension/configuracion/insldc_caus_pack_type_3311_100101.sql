SET DEFINE OFF;
MERGE INTO OPEN.LDC_CAUS_PACK_TYPE A USING
 (SELECT
  3311 as CAUSAL_ID,
  100101 as PACKAGE_TYPE_ID
  FROM DUAL) B
ON (A.CAUSAL_ID = B.CAUSAL_ID and A.PACKAGE_TYPE_ID = B.PACKAGE_TYPE_ID)
WHEN NOT MATCHED THEN 
INSERT (
  CAUSAL_ID, PACKAGE_TYPE_ID)
VALUES (
  B.CAUSAL_ID, B.PACKAGE_TYPE_ID);

COMMIT;