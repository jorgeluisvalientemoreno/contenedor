select owner, name, type
  from all_dependencies
 where referenced_owner = 'OPEN'
   and referenced_name = 'LDC_PROTECCION_DATOS'
;

select distinct d.name, d.REFERENCED_NAME,d.referenced_type, d.referenced_owner, level, o.created, o.LAST_DDL_TIME, o.TIMESTAMP
from DBA_DEPENDENCIES D
inner join dba_objects o on o.object_name=d.referenced_name and o.object_type=d.referenced_type and d.referenced_owner=d.owner
where referenced_type in ('PACKAGE','PACKAGE BODY','PROCEDURE','FUNCTION')
and name!=referenced_name
 and referenced_owner!='SYS'
START WITH d.name=upper('OS_PAYMENTSREGISTER')
CONNECT BY NOCYCLE  PRIOR   D.REFERENCED_NAME=d.name  AND LEVEL <= 6;