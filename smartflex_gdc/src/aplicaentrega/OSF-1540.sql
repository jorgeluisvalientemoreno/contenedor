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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_items_request.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_items_request.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ciclcons.sql"
@src/gascaribe/objetos-producto/sinonimos/ciclcons.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_get_item.sql"
@src/gascaribe/objetos-producto/sinonimos/os_get_item.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_get_transit_item.sql"
@src/gascaribe/objetos-producto/sinonimos/os_get_transit_item.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_get_request.sql"
@src/gascaribe/objetos-producto/sinonimos/os_get_request.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_get_requests_reg.sql"
@src/gascaribe/objetos-producto/sinonimos/os_get_requests_reg.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_getorderactivities.sql"
@src/gascaribe/objetos-producto/sinonimos/os_getorderactivities.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_getworkorders.sql"
@src/gascaribe/objetos-producto/sinonimos/os_getworkorders.sql

prompt "Aplicando src/gascaribe/general/api/adm_person.api_get_item.sql"
@src/gascaribe/general/api/adm_person.api_get_item.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.api_get_item.sql"
@src/gascaribe/general/sinonimos/adm_person.api_get_item.sql

prompt "Aplicando src/gascaribe/general/api/adm_person.api_get_transit_item.sql"
@src/gascaribe/general/api/adm_person.api_get_transit_item.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.api_get_transit_item.sql"
@src/gascaribe/general/sinonimos/adm_person.api_get_transit_item.sql

prompt "Aplicando src/gascaribe/general/api/adm_person.api_get_request.sql"
@src/gascaribe/general/api/adm_person.api_get_request.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.api_get_request.sql"
@src/gascaribe/general/sinonimos/adm_person.api_get_request.sql

prompt "Aplicando src/gascaribe/general/api/adm_person.api_get_requests_reg.sql"
@src/gascaribe/general/api/adm_person.api_get_requests_reg.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.api_get_requests_reg.sql"
@src/gascaribe/general/sinonimos/adm_person.api_get_requests_reg.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/api/adm_person.api_getorderactivities.sql"
@src/gascaribe/gestion-ordenes/api/adm_person.api_getorderactivities.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_getorderactivities.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_getorderactivities.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/api/adm_person.api_getworkorders.sql"
@src/gascaribe/gestion-ordenes/api/adm_person.api_getworkorders.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_getworkorders.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_getworkorders.sql

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