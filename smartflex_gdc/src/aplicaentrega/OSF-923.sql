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

prompt "Aplicando src/gascaribe/cartera/reconexiones/procedimientos/ldc_createsuspcone.sql"
@src/gascaribe/cartera/reconexiones/procedimientos/ldc_createsuspcone.sql

prompt "Aplicando src/gascaribe/cartera/reconexiones/procedimientos/ldc_insertsuspcone.sql"
@src/gascaribe/cartera/reconexiones/procedimientos/ldc_insertsuspcone.sql

prompt "Aplicando src/gascaribe/cartera/reconexiones/paquetes/ldc_boreconecion.sql"
@src/gascaribe/cartera/reconexiones/paquetes/ldc_boreconecion.sql

prompt "Aplicando src/gascaribe/flujos/WF_UNIT_TYPE_100559.sql"
@src/gascaribe/flujos/WF_UNIT_TYPE_100559.sql

prompt "Aplicando src/gascaribe/flujos/WF_UNIT_TYPE_100671.sql"
@src/gascaribe/flujos/WF_UNIT_TYPE_100671.sql

prompt "Aplicando src/gascaribe/reglas/121394520.sql"
@src/gascaribe/reglas/121394520.sql

prompt "Aplicando src/gascaribe/reglas/insOR_ACT_BY_REQ_DATA.sql"
@src/gascaribe/reglas/insOR_ACT_BY_REQ_DATA121394520.sql

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