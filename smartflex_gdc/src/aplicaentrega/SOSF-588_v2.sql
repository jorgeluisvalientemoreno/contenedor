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

prompt "Aplicando src/gascaribe/datafix/SOSF-588_v2_ActualizaTarifaTransitoria.sql"
@src/gascaribe/datafix/SOSF-588_v2_ActualizaTarifaTransitoria.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega"
prompt "------------------------------------------------------"

commit;