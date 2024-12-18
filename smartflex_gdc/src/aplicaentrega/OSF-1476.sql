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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_subs_general_data.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_subs_general_data.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_items_gama_item.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_items_gama_item.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_customerregister.sql"
@src/gascaribe/objetos-producto/sinonimos/os_customerregister.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_update_item.sql"
@src/gascaribe/objetos-producto/sinonimos/os_update_item.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_set_newitem.sql"
@src/gascaribe/objetos-producto/sinonimos/os_set_newitem.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/api/api_customerregister.sql"
@src/gascaribe/gestion-ordenes/api/api_customerregister.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_customerregister.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_customerregister.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/api/api_update_item.sql"
@src/gascaribe/gestion-ordenes/api/api_update_item.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_update_item.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_update_item.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/api/api_set_newitem.sql"
@src/gascaribe/gestion-ordenes/api/api_set_newitem.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_set_newitem.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_set_newitem.sql

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