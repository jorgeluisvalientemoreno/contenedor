column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "src/gascaribe/atencion-usuarios/api/adm_person.api_setcustworkdata.sql"
@src/gascaribe/atencion-usuarios/api/adm_person.api_setcustworkdata.sql

prompt "src/gascaribe/cartera/api/adm_person.api_attendfinanrequest.sql"
@src/gascaribe/cartera/api/adm_person.api_attendfinanrequest.sql

prompt "src/gascaribe/ventas/api/adm_person.api_addrequestaddress.sql"
@src/gascaribe/ventas/api/adm_person.api_addrequestaddress.sql

prompt "src/gascaribe/atencion-usuarios/sinonimos/adm_person.api_setcustworkdata.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.api_setcustworkdata.sql

prompt "src/gascaribe/cartera/sinonimo/adm_person.api_attendfinanrequest.sql"
@src/gascaribe/cartera/sinonimo/adm_person.api_attendfinanrequest.sql

prompt "src/gascaribe/ventas/sinonimos/adm_person.api_addrequestaddress.sql"
@src/gascaribe/ventas/sinonimos/adm_person.api_addrequestaddress.sql


prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/