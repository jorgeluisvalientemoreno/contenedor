column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SOSF-529');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_accept_item.sql"
@src/gascaribe/objetos-producto/sinonimos/os_accept_item.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_reject_item.sql"
@src/gascaribe/objetos-producto/sinonimos/os_reject_item.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_set_request_conf.sql"
@src/gascaribe/objetos-producto/sinonimos/os_set_request_conf.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_customerupdate.sql"
@src/gascaribe/objetos-producto/sinonimos/os_customerupdate.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_peprodsuitrconnectn.sql"
@src/gascaribe/objetos-producto/sinonimos/os_peprodsuitrconnectn.sql




prompt "Aplicando src/gascaribe/atencion-usuarios/api/adm_person.api_customerupdate.sql"
@src/gascaribe/atencion-usuarios/api/adm_person.api_customerupdate.sql
prompt "Aplicando src/gascaribe/general/api/adm_person.api_accept_item.sql"
@src/gascaribe/general/api/adm_person.api_accept_item.sql
prompt "Aplicando src/gascaribe/general/api/adm_person.api_reject_item.sql"
@src/gascaribe/general/api/adm_person.api_reject_item.sql
prompt "Aplicando src/gascaribe/general/api/adm_person.api_set_request_conf.sql"
@src/gascaribe/general/api/adm_person.api_set_request_conf.sql
prompt "Aplicando src/gascaribe/cartera/api/adm_person.api_peprodsuitrconnectn.sql"
@src/gascaribe/cartera/api/adm_person.api_peprodsuitrconnectn.sql


prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.api_customerupdate.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.api_customerupdate.sql
prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.api_accept_item.sql"
@src/gascaribe/general/sinonimos/adm_person.api_accept_item.sql
prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.api_reject_item.sql"
@src/gascaribe/general/sinonimos/adm_person.api_reject_item.sql
prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.api_set_request_conf.sql"
@src/gascaribe/general/sinonimos/adm_person.api_set_request_conf.sql
prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.api_peprodsuitrconnectn.sql"
@src/gascaribe/cartera/sinonimo/adm_person.api_peprodsuitrconnectn.sql

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