column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/calidad-medicion/parametros/titr_vpm_noti_susp.sql"
@src/gascaribe/calidad-medicion/parametros/titr_vpm_noti_susp.sql

prompt "Aplicando src/gascaribe/calidad-medicion/indices/idx_ldc_log_proceso_vmp_01.sql"
@src/gascaribe/calidad-medicion/indices/idx_ldc_log_proceso_vmp_01.sql

prompt "Aplicando src/gascaribe/calidad-medicion/indices/idx_ldc_log_proceso_vmp_02.sql"
@src/gascaribe/calidad-medicion/indices/idx_ldc_log_proceso_vmp_02.sql

prompt "Aplicando src/gascaribe/calidad-medicion/paquete/ldc_boprocesaordvmp.sql"
@src/gascaribe/calidad-medicion/paquete/ldc_boprocesaordvmp.sql

prompt "Aplicando src/gascaribe/calidad-medicion/sinonimos/ldc_boprocesaordvmp.sql"
@src/gascaribe/calidad-medicion/sinonimos/ldc_boprocesaordvmp.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/