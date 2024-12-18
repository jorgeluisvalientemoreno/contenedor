column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO INN SN');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/servicios-nuevos/triggers"
@src/gascaribe/servicios-nuevos/triggers/TRG_CAMUNDA_PACKAGE.sql
@src/gascaribe/servicios-nuevos/triggers/TRG_OR_ORDER_CXC.sql
@src/gascaribe/servicios-nuevos/triggers/TRG_RESTRICT_CXC_CERTIFICADO.sql
@src/gascaribe/servicios-nuevos/triggers/TRG_RESTRICT_SERVNUEV.sql

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