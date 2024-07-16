select /*sid,action*/* from gv$session where ( program like 'sqlplus%' OR PROGRAM ='SQL Developer') AND USERNAME='OPEN' and upper(action) like 'APLICANDO%';

select *
from dba_objects
where status!='VALID'
and owner in ('OPEN','PERSONALIZACIONES','ADM_PERSON')
 and exists(select null from dba_errors where name=object_name)
 ;

select *
from dba_objects
where object_name=upper('ldc_pksolicitudinteraccion');
;
