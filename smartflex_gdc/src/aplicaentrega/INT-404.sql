column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO INT-404 ');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/datafix/INT-404_Parametros.sql"
@src/gascaribe/datafix/INT-404_Parametros.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pksoapapi.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pksoapapi.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkfactelectronica_emi.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkfactelectronica_emi.sql

prompt "Aplicando src/gascaribe/datafix/INT-404_Scheduler.sql"
@src/gascaribe/datafix/INT-404_Scheduler.sql

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