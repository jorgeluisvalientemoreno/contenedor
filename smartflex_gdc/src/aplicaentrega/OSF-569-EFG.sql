column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
spool &vdb._logSAO569_&vdt..txt
set serveroutput on
set timing on
execute dbms_application_info.set_action('APLICANDO SAO569');
prompt Inicio Proceso!!
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt " APLICANDO aplicaSAO569.sql "
prompt "------------------------------------------------------"

prompt "Aplicando src/efigas/cartera-fnb/entidad/ldc_afianzado.sql"
@src/efigas/cartera-fnb/entidad/ldc_afianzado.sql

prompt "Aplicando src/efigas/cartera-fnb/trigger/trg_afianzado_historial_biu.sql"
@src/efigas/cartera-fnb/trigger/trg_afianzado_historial_biu.sql

prompt "Aplicando src/efigas/cartera-fnb/trigger/trg_financiar_afianzado_biu.sql"
@src/efigas/cartera-fnb/trigger/trg_financiar_afianzado_biu.sql

prompt "Aplicando src/efigas/datafix/OSF-569.sql"
@src/efigas/datafix/OSF-569.sql

prompt "------------------------------------------------------"
prompt " FIN DE APLICA aplicaSAO569.sql "
prompt "------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
spool off
