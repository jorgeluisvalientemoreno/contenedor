column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO OSF-419');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega OSF-419"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/gestion-ordenes/notificaciones/ldc_fsbttprocesocorreo.sql"
@src/gascaribe/gestion-ordenes/notificaciones/ldc_fsbttprocesocorreo.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega OSF-419"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/