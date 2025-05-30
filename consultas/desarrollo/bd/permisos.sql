SELECT *
FROM DBA_TAB_PRIVS
WHERE GRANTEE='PUBLIC'
  and owner='OPEN'


select *
from dba_role_privs
where granted_role='REXEOPEN'


GRANT SELECT ON multiempresa.empresa TO open with grant option;
GRANT SELECT ON OPEN.VW_EMPRESA  TO SYSTEM_OBJ_PRIVS_ROLE;