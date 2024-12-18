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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_coupongeneration.sql"
@src/gascaribe/objetos-producto/sinonimos/os_coupongeneration.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_getsubscripbalance.sql"
@src/gascaribe/objetos-producto/sinonimos/os_getsubscripbalance.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_registerdebtfinancing.sql"
@src/gascaribe/objetos-producto/sinonimos/os_registerdebtfinancing.sql

prompt "Aplicando src/gascaribe/facturacion/api/api_coupongeneration.sql"
@src/gascaribe/facturacion/api/api_coupongeneration.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.api_coupongeneration.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.api_coupongeneration.sql

prompt "Aplicando src/gascaribe/facturacion/api/api_getsubscripbalance.sql"
@src/gascaribe/facturacion/api/api_getsubscripbalance.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.api_getsubscripbalance.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.api_getsubscripbalance.sql

prompt "Aplicando src/gascaribe/facturacion/api/api_registerdebtfinancing.sql"
@src/gascaribe/facturacion/api/api_registerdebtfinancing.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.api_registerdebtfinancing.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.api_registerdebtfinancing.sql

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