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


prompt "src/gascaribe/papelera-reciclaje/procedimientos/ldcpbgoc.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcpbgoc.sql

prompt "src/gascaribe/papelera-reciclaje/paquetes/ldc_pkpbgoc.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkpbgoc.sql

prompt "src/gascaribe/datafix/OSF-1755_1_obs_ejecutable.sql"
@src/gascaribe/datafix/OSF-1755_1_obs_ejecutable.sql


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