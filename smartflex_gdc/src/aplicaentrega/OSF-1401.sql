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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_order_stat_change.sql"
@src/gascaribe/objetos-producto/sinonimos/or_order_stat_change.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_lockorder.sql"
@src/gascaribe/objetos-producto/sinonimos/os_lockorder.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_unlockorder.sql"
@src/gascaribe/objetos-producto/sinonimos/os_unlockorder.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/api/adm_person.api_lockorder.sql"
@src/gascaribe/gestion-ordenes/api/adm_person.api_lockorder.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/api/adm_person.api_unlockorder.sql"
@src/gascaribe/gestion-ordenes/api/adm_person.api_unlockorder.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_lockorder.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_lockorder.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_unlockorder.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_unlockorder.sql

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