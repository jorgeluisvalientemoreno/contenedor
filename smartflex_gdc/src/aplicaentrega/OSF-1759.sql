column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0 OSF-1734" 
prompt "------------------------------------------------------"


prompt "Aplicando paquete ldci_pkossolicitud.sql"
@src/gascaribe/gestion-ordenes/package/ldci_pkosssolicitud.sql
show errors; 


prompt "Aplicando  paquete adm_person.pkg_session.sql"
@src/gascaribe/gestion-ordenes/sinonimos/open.ldci_pkosssolicitud.sql

prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0 OSF-1734"
prompt "------------------------------------------------------"


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit