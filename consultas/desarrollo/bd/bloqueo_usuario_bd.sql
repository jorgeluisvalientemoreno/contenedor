SELECT
  TO_CHAR(TIMESTAMP,'MM/DD HH24:MI') TIMESTAMP,
  SUBSTR(OS_USERNAME,1,20) OS_USERNAME,
  SUBSTR(USERNAME,1,20) USERNAME,
  SUBSTR(TERMINAL,1,20) TERMINAL,
  ACTION_NAME,
  RETURNCODE
FROM
  SYS.DBA_AUDIT_SESSION
WHERE
  UPPER(USERNAME) LIKE 'REFINAAPP'
  AND TIMESTAMP BETWEEN SYSDATE-1 AND SYSDATE
ORDER BY
  TIMESTAMP DESC;
RETURNCODE=0 indicates success
RETURNCODE=1017 indicates bad password
RETURNCODE=28000 indicates account is locked out