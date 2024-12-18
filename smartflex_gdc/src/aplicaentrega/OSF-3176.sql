column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/general/sinonimos/os_deladdress.sql"
@src/gascaribe/general/sinonimos/os_deladdress.sql

prompt "Aplicando src/gascaribe/general/procedimientos/adm_person.api_deladdress.sql"
@src/gascaribe/general/procedimientos/adm_person.api_deladdress.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.api_deladdress.sql"
@src/gascaribe/general/sinonimos/adm_person.api_deladdress.sql

prompt "Aplicando src/gascaribe/general/sinonimos/gisosf.api_deladdress.sql"
@src/gascaribe/general/sinonimos/gisosf.api_deladdress.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3176_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-3176_homologacion_servicios.sql

prompt "Recompilando objetos invalidos"
@src/test/recompilar-objetos.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/