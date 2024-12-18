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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pr_subs_type_prod.sql"
@src/gascaribe/objetos-producto/sinonimos/pr_subs_type_prod.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ps_product_status.sql"
@src/gascaribe/objetos-producto/sinonimos/ps_product_status.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_getbranchbyaddress.sql"
@src/gascaribe/objetos-producto/sinonimos/os_getbranchbyaddress.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_getcustusersbyprod.sql"
@src/gascaribe/objetos-producto/sinonimos/os_getcustusersbyprod.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_getcustomerdata.sql"
@src/gascaribe/objetos-producto/sinonimos/os_getcustomerdata.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_getproductdata.sql"
@src/gascaribe/objetos-producto/sinonimos/os_getproductdata.sql

prompt "Aplicando src/gascaribe/general/api/adm_person.api_getbranchbyaddress.sql"
@src/gascaribe/general/api/adm_person.api_getbranchbyaddress.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.api_getbranchbyaddress.sql"
@src/gascaribe/general/sinonimos/adm_person.api_getbranchbyaddress.sql

prompt "Aplicando src/gascaribe/general/api/adm_person.api_getcustusersbyprod.sql"
@src/gascaribe/general/api/adm_person.api_getcustusersbyprod.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.api_getcustusersbyprod.sql"
@src/gascaribe/general/sinonimos/adm_person.api_getcustusersbyprod.sql

prompt "Aplicando src/gascaribe/general/api/adm_person.api_getcustomerdata.sql"
@src/gascaribe/general/api/adm_person.api_getcustomerdata.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.api_getcustomerdata.sql"
@src/gascaribe/general/sinonimos/adm_person.api_getcustomerdata.sql

prompt "Aplicando src/gascaribe/general/api/adm_person.api_getproductdata.sql"
@src/gascaribe/general/api/adm_person.api_getproductdata.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.api_getproductdata.sql"
@src/gascaribe/general/sinonimos/adm_person.api_getproductdata.sql

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