SELECT *
FROM DBA_TAB_PRIVS
WHERE GRANTEE='PUBLIC'
  and owner='OPEN'


select *
from dba_role_privs
where granted_role='REXEOPEN'