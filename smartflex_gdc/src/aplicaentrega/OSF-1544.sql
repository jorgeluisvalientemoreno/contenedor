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

prompt "Aplicando src/gascaribe/cartera/api/adm_person.api_setcommercialsegment.sql"
@src/gascaribe/cartera/api/adm_person.api_setcommercialsegment.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.api_setcommercialsegment.sql"
@src/gascaribe/cartera/sinonimo/adm_person.api_setcommercialsegment.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_customerregister.sql"
@src/gascaribe/objetos-producto/sinonimos/os_customerregister.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/api/adm_person.api_register_ntl.sql"
@src/gascaribe/perdidas-no-operacionales/api/adm_person.api_register_ntl.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.api_register_ntl.sql"
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.api_register_ntl.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/api/api_customerregister.sql"
@src/gascaribe/gestion-ordenes/api/api_customerregister.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_customerregister.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_customerregister.sql

prompt "Aplicando src/gascaribe/predios/api/adm_person.api_updinfopremise.sql"
@src/gascaribe/predios/api/adm_person.api_updinfopremise.sql

prompt "Aplicando src/gascaribe/predios/sinonimos/adm_person.api_updinfopremise.sql"
@src/gascaribe/predios/sinonimos/adm_person.api_updinfopremise.sql


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