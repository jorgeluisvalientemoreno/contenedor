MERGE INTO OPEN.LDC_TIPSOLPLANCOMERCIAL A USING
 (SELECT
  271 as "PACKAGE_TYPE_ID",
  4 as "COMMERCIAL_PLAN_ID",
  TO_DATE('08/19/2022 09:23:57', 'MM/DD/YYYY HH24:MI:SS') as "CREATED_TSPC",
  'OPEN' as "USUARIO_CREATED",
  NULL as "UPDATED_TSPC",
  NULL as "USUARIO_UPDATED"
  FROM DUAL) B
ON (A.PACKAGE_TYPE_ID = B.PACKAGE_TYPE_ID and A.COMMERCIAL_PLAN_ID = B.COMMERCIAL_PLAN_ID)
WHEN NOT MATCHED THEN 
INSERT (
  PACKAGE_TYPE_ID, COMMERCIAL_PLAN_ID, CREATED_TSPC, USUARIO_CREATED, UPDATED_TSPC, 
  USUARIO_UPDATED)
VALUES (
  B.PACKAGE_TYPE_ID, B.COMMERCIAL_PLAN_ID, B.CREATED_TSPC, B.USUARIO_CREATED, B.UPDATED_TSPC, 
  B.USUARIO_UPDATED)
WHEN MATCHED THEN
UPDATE SET 
  A.CREATED_TSPC = B.CREATED_TSPC,
  A.USUARIO_CREATED = B.USUARIO_CREATED,
  A.UPDATED_TSPC = B.UPDATED_TSPC,
  A.USUARIO_UPDATED = B.USUARIO_UPDATED;

MERGE INTO OPEN.LDC_TIPSOLPLANCOMERCIAL A USING
 (SELECT
  271 as "PACKAGE_TYPE_ID",
  5 as "COMMERCIAL_PLAN_ID",
  TO_DATE('08/19/2022 09:23:57', 'MM/DD/YYYY HH24:MI:SS') as "CREATED_TSPC",
  'OPEN' as "USUARIO_CREATED",
  NULL as "UPDATED_TSPC",
  NULL as "USUARIO_UPDATED"
  FROM DUAL) B
ON (A.PACKAGE_TYPE_ID = B.PACKAGE_TYPE_ID and A.COMMERCIAL_PLAN_ID = B.COMMERCIAL_PLAN_ID)
WHEN NOT MATCHED THEN 
INSERT (
  PACKAGE_TYPE_ID, COMMERCIAL_PLAN_ID, CREATED_TSPC, USUARIO_CREATED, UPDATED_TSPC, 
  USUARIO_UPDATED)
VALUES (
  B.PACKAGE_TYPE_ID, B.COMMERCIAL_PLAN_ID, B.CREATED_TSPC, B.USUARIO_CREATED, B.UPDATED_TSPC, 
  B.USUARIO_UPDATED)
WHEN MATCHED THEN
UPDATE SET 
  A.CREATED_TSPC = B.CREATED_TSPC,
  A.USUARIO_CREATED = B.USUARIO_CREATED,
  A.UPDATED_TSPC = B.UPDATED_TSPC,
  A.USUARIO_UPDATED = B.USUARIO_UPDATED;

MERGE INTO OPEN.LDC_TIPSOLPLANCOMERCIAL A USING
 (SELECT
  271 as "PACKAGE_TYPE_ID",
  36 as "COMMERCIAL_PLAN_ID",
  TO_DATE('08/19/2022 09:23:57', 'MM/DD/YYYY HH24:MI:SS') as "CREATED_TSPC",
  'OPEN' as "USUARIO_CREATED",
  NULL as "UPDATED_TSPC",
  NULL as "USUARIO_UPDATED"
  FROM DUAL) B
ON (A.PACKAGE_TYPE_ID = B.PACKAGE_TYPE_ID and A.COMMERCIAL_PLAN_ID = B.COMMERCIAL_PLAN_ID)
WHEN NOT MATCHED THEN 
INSERT (
  PACKAGE_TYPE_ID, COMMERCIAL_PLAN_ID, CREATED_TSPC, USUARIO_CREATED, UPDATED_TSPC, 
  USUARIO_UPDATED)
VALUES (
  B.PACKAGE_TYPE_ID, B.COMMERCIAL_PLAN_ID, B.CREATED_TSPC, B.USUARIO_CREATED, B.UPDATED_TSPC, 
  B.USUARIO_UPDATED)
WHEN MATCHED THEN
UPDATE SET 
  A.CREATED_TSPC = B.CREATED_TSPC,
  A.USUARIO_CREATED = B.USUARIO_CREATED,
  A.UPDATED_TSPC = B.UPDATED_TSPC,
  A.USUARIO_UPDATED = B.USUARIO_UPDATED;

MERGE INTO OPEN.LDC_TIPSOLPLANCOMERCIAL A USING
 (SELECT
  271 as "PACKAGE_TYPE_ID",
  41 as "COMMERCIAL_PLAN_ID",
  TO_DATE('08/19/2022 09:23:57', 'MM/DD/YYYY HH24:MI:SS') as "CREATED_TSPC",
  'OPEN' as "USUARIO_CREATED",
  NULL as "UPDATED_TSPC",
  NULL as "USUARIO_UPDATED"
  FROM DUAL) B
ON (A.PACKAGE_TYPE_ID = B.PACKAGE_TYPE_ID and A.COMMERCIAL_PLAN_ID = B.COMMERCIAL_PLAN_ID)
WHEN NOT MATCHED THEN 
INSERT (
  PACKAGE_TYPE_ID, COMMERCIAL_PLAN_ID, CREATED_TSPC, USUARIO_CREATED, UPDATED_TSPC, 
  USUARIO_UPDATED)
VALUES (
  B.PACKAGE_TYPE_ID, B.COMMERCIAL_PLAN_ID, B.CREATED_TSPC, B.USUARIO_CREATED, B.UPDATED_TSPC, 
  B.USUARIO_UPDATED)
WHEN MATCHED THEN
UPDATE SET 
  A.CREATED_TSPC = B.CREATED_TSPC,
  A.USUARIO_CREATED = B.USUARIO_CREATED,
  A.UPDATED_TSPC = B.UPDATED_TSPC,
  A.USUARIO_UPDATED = B.USUARIO_UPDATED;

MERGE INTO OPEN.LDC_TIPSOLPLANCOMERCIAL A USING
 (SELECT
  271 as "PACKAGE_TYPE_ID",
  48 as "COMMERCIAL_PLAN_ID",
  TO_DATE('08/19/2022 09:23:57', 'MM/DD/YYYY HH24:MI:SS') as "CREATED_TSPC",
  'OPEN' as "USUARIO_CREATED",
  NULL as "UPDATED_TSPC",
  NULL as "USUARIO_UPDATED"
  FROM DUAL) B
ON (A.PACKAGE_TYPE_ID = B.PACKAGE_TYPE_ID and A.COMMERCIAL_PLAN_ID = B.COMMERCIAL_PLAN_ID)
WHEN NOT MATCHED THEN 
INSERT (
  PACKAGE_TYPE_ID, COMMERCIAL_PLAN_ID, CREATED_TSPC, USUARIO_CREATED, UPDATED_TSPC, 
  USUARIO_UPDATED)
VALUES (
  B.PACKAGE_TYPE_ID, B.COMMERCIAL_PLAN_ID, B.CREATED_TSPC, B.USUARIO_CREATED, B.UPDATED_TSPC, 
  B.USUARIO_UPDATED)
WHEN MATCHED THEN
UPDATE SET 
  A.CREATED_TSPC = B.CREATED_TSPC,
  A.USUARIO_CREATED = B.USUARIO_CREATED,
  A.UPDATED_TSPC = B.UPDATED_TSPC,
  A.USUARIO_UPDATED = B.USUARIO_UPDATED;

MERGE INTO OPEN.LDC_TIPSOLPLANCOMERCIAL A USING
 (SELECT
  271 as "PACKAGE_TYPE_ID",
  54 as "COMMERCIAL_PLAN_ID",
  TO_DATE('08/19/2022 09:23:57', 'MM/DD/YYYY HH24:MI:SS') as "CREATED_TSPC",
  'OPEN' as "USUARIO_CREATED",
  NULL as "UPDATED_TSPC",
  NULL as "USUARIO_UPDATED"
  FROM DUAL) B
ON (A.PACKAGE_TYPE_ID = B.PACKAGE_TYPE_ID and A.COMMERCIAL_PLAN_ID = B.COMMERCIAL_PLAN_ID)
WHEN NOT MATCHED THEN 
INSERT (
  PACKAGE_TYPE_ID, COMMERCIAL_PLAN_ID, CREATED_TSPC, USUARIO_CREATED, UPDATED_TSPC, 
  USUARIO_UPDATED)
VALUES (
  B.PACKAGE_TYPE_ID, B.COMMERCIAL_PLAN_ID, B.CREATED_TSPC, B.USUARIO_CREATED, B.UPDATED_TSPC, 
  B.USUARIO_UPDATED)
WHEN MATCHED THEN
UPDATE SET 
  A.CREATED_TSPC = B.CREATED_TSPC,
  A.USUARIO_CREATED = B.USUARIO_CREATED,
  A.UPDATED_TSPC = B.UPDATED_TSPC,
  A.USUARIO_UPDATED = B.USUARIO_UPDATED;

MERGE INTO OPEN.LDC_TIPSOLPLANCOMERCIAL A USING
 (SELECT
  100229 as "PACKAGE_TYPE_ID",
  8 as "COMMERCIAL_PLAN_ID",
  TO_DATE('08/19/2022 09:24:34', 'MM/DD/YYYY HH24:MI:SS') as "CREATED_TSPC",
  'OPEN' as "USUARIO_CREATED",
  NULL as "UPDATED_TSPC",
  NULL as "USUARIO_UPDATED"
  FROM DUAL) B
ON (A.PACKAGE_TYPE_ID = B.PACKAGE_TYPE_ID and A.COMMERCIAL_PLAN_ID = B.COMMERCIAL_PLAN_ID)
WHEN NOT MATCHED THEN 
INSERT (
  PACKAGE_TYPE_ID, COMMERCIAL_PLAN_ID, CREATED_TSPC, USUARIO_CREATED, UPDATED_TSPC, 
  USUARIO_UPDATED)
VALUES (
  B.PACKAGE_TYPE_ID, B.COMMERCIAL_PLAN_ID, B.CREATED_TSPC, B.USUARIO_CREATED, B.UPDATED_TSPC, 
  B.USUARIO_UPDATED)
WHEN MATCHED THEN
UPDATE SET 
  A.CREATED_TSPC = B.CREATED_TSPC,
  A.USUARIO_CREATED = B.USUARIO_CREATED,
  A.UPDATED_TSPC = B.UPDATED_TSPC,
  A.USUARIO_UPDATED = B.USUARIO_UPDATED;

MERGE INTO OPEN.LDC_TIPSOLPLANCOMERCIAL A USING
 (SELECT
  100229 as "PACKAGE_TYPE_ID",
  9 as "COMMERCIAL_PLAN_ID",
  TO_DATE('08/19/2022 09:24:34', 'MM/DD/YYYY HH24:MI:SS') as "CREATED_TSPC",
  'OPEN' as "USUARIO_CREATED",
  NULL as "UPDATED_TSPC",
  NULL as "USUARIO_UPDATED"
  FROM DUAL) B
ON (A.PACKAGE_TYPE_ID = B.PACKAGE_TYPE_ID and A.COMMERCIAL_PLAN_ID = B.COMMERCIAL_PLAN_ID)
WHEN NOT MATCHED THEN 
INSERT (
  PACKAGE_TYPE_ID, COMMERCIAL_PLAN_ID, CREATED_TSPC, USUARIO_CREATED, UPDATED_TSPC, 
  USUARIO_UPDATED)
VALUES (
  B.PACKAGE_TYPE_ID, B.COMMERCIAL_PLAN_ID, B.CREATED_TSPC, B.USUARIO_CREATED, B.UPDATED_TSPC, 
  B.USUARIO_UPDATED)
WHEN MATCHED THEN
UPDATE SET 
  A.CREATED_TSPC = B.CREATED_TSPC,
  A.USUARIO_CREATED = B.USUARIO_CREATED,
  A.UPDATED_TSPC = B.UPDATED_TSPC,
  A.USUARIO_UPDATED = B.USUARIO_UPDATED;

MERGE INTO OPEN.LDC_TIPSOLPLANCOMERCIAL A USING
 (SELECT
  100229 as "PACKAGE_TYPE_ID",
  15 as "COMMERCIAL_PLAN_ID",
  TO_DATE('08/19/2022 09:24:34', 'MM/DD/YYYY HH24:MI:SS') as "CREATED_TSPC",
  'OPEN' as "USUARIO_CREATED",
  NULL as "UPDATED_TSPC",
  NULL as "USUARIO_UPDATED"
  FROM DUAL) B
ON (A.PACKAGE_TYPE_ID = B.PACKAGE_TYPE_ID and A.COMMERCIAL_PLAN_ID = B.COMMERCIAL_PLAN_ID)
WHEN NOT MATCHED THEN 
INSERT (
  PACKAGE_TYPE_ID, COMMERCIAL_PLAN_ID, CREATED_TSPC, USUARIO_CREATED, UPDATED_TSPC, 
  USUARIO_UPDATED)
VALUES (
  B.PACKAGE_TYPE_ID, B.COMMERCIAL_PLAN_ID, B.CREATED_TSPC, B.USUARIO_CREATED, B.UPDATED_TSPC, 
  B.USUARIO_UPDATED)
WHEN MATCHED THEN
UPDATE SET 
  A.CREATED_TSPC = B.CREATED_TSPC,
  A.USUARIO_CREATED = B.USUARIO_CREATED,
  A.UPDATED_TSPC = B.UPDATED_TSPC,
  A.USUARIO_UPDATED = B.USUARIO_UPDATED;

MERGE INTO OPEN.LDC_TIPSOLPLANCOMERCIAL A USING
 (SELECT
  100229 as "PACKAGE_TYPE_ID",
  16 as "COMMERCIAL_PLAN_ID",
  TO_DATE('08/19/2022 09:24:34', 'MM/DD/YYYY HH24:MI:SS') as "CREATED_TSPC",
  'OPEN' as "USUARIO_CREATED",
  NULL as "UPDATED_TSPC",
  NULL as "USUARIO_UPDATED"
  FROM DUAL) B
ON (A.PACKAGE_TYPE_ID = B.PACKAGE_TYPE_ID and A.COMMERCIAL_PLAN_ID = B.COMMERCIAL_PLAN_ID)
WHEN NOT MATCHED THEN 
INSERT (
  PACKAGE_TYPE_ID, COMMERCIAL_PLAN_ID, CREATED_TSPC, USUARIO_CREATED, UPDATED_TSPC, 
  USUARIO_UPDATED)
VALUES (
  B.PACKAGE_TYPE_ID, B.COMMERCIAL_PLAN_ID, B.CREATED_TSPC, B.USUARIO_CREATED, B.UPDATED_TSPC, 
  B.USUARIO_UPDATED)
WHEN MATCHED THEN
UPDATE SET 
  A.CREATED_TSPC = B.CREATED_TSPC,
  A.USUARIO_CREATED = B.USUARIO_CREATED,
  A.UPDATED_TSPC = B.UPDATED_TSPC,
  A.USUARIO_UPDATED = B.USUARIO_UPDATED;

MERGE INTO OPEN.LDC_TIPSOLPLANCOMERCIAL A USING
 (SELECT
  100229 as "PACKAGE_TYPE_ID",
  17 as "COMMERCIAL_PLAN_ID",
  TO_DATE('08/19/2022 09:24:34', 'MM/DD/YYYY HH24:MI:SS') as "CREATED_TSPC",
  'OPEN' as "USUARIO_CREATED",
  NULL as "UPDATED_TSPC",
  NULL as "USUARIO_UPDATED"
  FROM DUAL) B
ON (A.PACKAGE_TYPE_ID = B.PACKAGE_TYPE_ID and A.COMMERCIAL_PLAN_ID = B.COMMERCIAL_PLAN_ID)
WHEN NOT MATCHED THEN 
INSERT (
  PACKAGE_TYPE_ID, COMMERCIAL_PLAN_ID, CREATED_TSPC, USUARIO_CREATED, UPDATED_TSPC, 
  USUARIO_UPDATED)
VALUES (
  B.PACKAGE_TYPE_ID, B.COMMERCIAL_PLAN_ID, B.CREATED_TSPC, B.USUARIO_CREATED, B.UPDATED_TSPC, 
  B.USUARIO_UPDATED)
WHEN MATCHED THEN
UPDATE SET 
  A.CREATED_TSPC = B.CREATED_TSPC,
  A.USUARIO_CREATED = B.USUARIO_CREATED,
  A.UPDATED_TSPC = B.UPDATED_TSPC,
  A.USUARIO_UPDATED = B.USUARIO_UPDATED;

MERGE INTO OPEN.LDC_TIPSOLPLANCOMERCIAL A USING
 (SELECT
  100229 as "PACKAGE_TYPE_ID",
  19 as "COMMERCIAL_PLAN_ID",
  TO_DATE('08/19/2022 09:24:34', 'MM/DD/YYYY HH24:MI:SS') as "CREATED_TSPC",
  'OPEN' as "USUARIO_CREATED",
  NULL as "UPDATED_TSPC",
  NULL as "USUARIO_UPDATED"
  FROM DUAL) B
ON (A.PACKAGE_TYPE_ID = B.PACKAGE_TYPE_ID and A.COMMERCIAL_PLAN_ID = B.COMMERCIAL_PLAN_ID)
WHEN NOT MATCHED THEN 
INSERT (
  PACKAGE_TYPE_ID, COMMERCIAL_PLAN_ID, CREATED_TSPC, USUARIO_CREATED, UPDATED_TSPC, 
  USUARIO_UPDATED)
VALUES (
  B.PACKAGE_TYPE_ID, B.COMMERCIAL_PLAN_ID, B.CREATED_TSPC, B.USUARIO_CREATED, B.UPDATED_TSPC, 
  B.USUARIO_UPDATED)
WHEN MATCHED THEN
UPDATE SET 
  A.CREATED_TSPC = B.CREATED_TSPC,
  A.USUARIO_CREATED = B.USUARIO_CREATED,
  A.UPDATED_TSPC = B.UPDATED_TSPC,
  A.USUARIO_UPDATED = B.USUARIO_UPDATED;

MERGE INTO OPEN.LDC_TIPSOLPLANCOMERCIAL A USING
 (SELECT
  100229 as "PACKAGE_TYPE_ID",
  21 as "COMMERCIAL_PLAN_ID",
  TO_DATE('08/19/2022 09:24:34', 'MM/DD/YYYY HH24:MI:SS') as "CREATED_TSPC",
  'OPEN' as "USUARIO_CREATED",
  NULL as "UPDATED_TSPC",
  NULL as "USUARIO_UPDATED"
  FROM DUAL) B
ON (A.PACKAGE_TYPE_ID = B.PACKAGE_TYPE_ID and A.COMMERCIAL_PLAN_ID = B.COMMERCIAL_PLAN_ID)
WHEN NOT MATCHED THEN 
INSERT (
  PACKAGE_TYPE_ID, COMMERCIAL_PLAN_ID, CREATED_TSPC, USUARIO_CREATED, UPDATED_TSPC, 
  USUARIO_UPDATED)
VALUES (
  B.PACKAGE_TYPE_ID, B.COMMERCIAL_PLAN_ID, B.CREATED_TSPC, B.USUARIO_CREATED, B.UPDATED_TSPC, 
  B.USUARIO_UPDATED)
WHEN MATCHED THEN
UPDATE SET 
  A.CREATED_TSPC = B.CREATED_TSPC,
  A.USUARIO_CREATED = B.USUARIO_CREATED,
  A.UPDATED_TSPC = B.UPDATED_TSPC,
  A.USUARIO_UPDATED = B.USUARIO_UPDATED;

COMMIT;
/