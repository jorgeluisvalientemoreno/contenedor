column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0 OSF-1659" 
prompt "------------------------------------------------------"

prompt "Creando sinónimo src/gascaribe/objetos-producto/sinonimos/open.ge_log_trace.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_log_trace.sql


prompt "Aplicando paquete src/gascaribe/general/paquetes/adm_person.pkg_traza.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_traza.sql
show errors; 

prompt "Creando sinónimo src/gascaribe/general/sinonimos/adm_person.pkg_traza.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_traza.sql



prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0 OSF-1659"
prompt "------------------------------------------------------"


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Aplica!!
set timing off
set serveroutput off
set define on
quit
