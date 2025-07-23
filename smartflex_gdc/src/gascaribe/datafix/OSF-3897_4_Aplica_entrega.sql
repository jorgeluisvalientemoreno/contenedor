column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;


prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/datafix/OSF-3897_4_Actualiza_Tarifas.sql"
@src/gascaribe/datafix/OSF-3897_4_Actualiza_Tarifas.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3897_job_genera_proceso.sql"
@src/gascaribe/datafix/OSF-3897_job_genera_proceso.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega"
prompt "------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
/
