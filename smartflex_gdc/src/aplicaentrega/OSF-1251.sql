column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO OSF-1251');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_subscriptionregister.sql"
@src/gascaribe/objetos-producto/sinonimos/os_subscriptionregister.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/api/adm_person.api_subscriptionregiste.sql"
@src/gascaribe/atencion-usuarios/api/adm_person.api_subscriptionregiste.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.api_subscriptionregiste.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.api_subscriptionregiste.sql

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