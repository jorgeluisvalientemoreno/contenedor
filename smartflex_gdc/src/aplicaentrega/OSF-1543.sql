column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_getbasicdataorder.sql"
@src/gascaribe/objetos-producto/sinonimos/os_getbasicdataorder.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_getorderbypackage.sql"
@src/gascaribe/objetos-producto/sinonimos/os_getorderbypackage.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_updpaidcertif.sql"
@src/gascaribe/objetos-producto/sinonimos/os_updpaidcertif.sql

prompt "Aplicando src/gascaribe/general/api/adm_person.api_getbasicdataorder.sql"
@src/gascaribe/general/api/adm_person.api_getbasicdataorder.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.api_getbasicdataorder.sql"
@src/gascaribe/general/sinonimos/adm_person.api_getbasicdataorder.sql

prompt "Aplicando src/gascaribe/general/api/adm_person.api_getorderbypackage.sql"
@src/gascaribe/general/api/adm_person.api_getorderbypackage.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.api_getorderbypackage.sql"
@src/gascaribe/general/sinonimos/adm_person.api_getorderbypackage.sql

prompt "Aplicando src/gascaribe/actas/api/adm_person.api_updpaidcertif.sql"
@src/gascaribe/actas/api/adm_person.api_updpaidcertif.sql

prompt "Aplicando src/gascaribe/actas/sinonimos/adm_person.api_updpaidcertif.sql"
@src/gascaribe/actas/sinonimos/adm_person.api_updpaidcertif.sql

prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/