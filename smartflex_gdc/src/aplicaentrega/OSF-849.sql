column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/revision-periodica/plugin/ldc_registerntl.sql"
@src/gascaribe/perdidas-no-operacionales/paquetes/ldc_registerntl.sql

prompt "Aplicando src/gascaribe/datafix/OSF-849.sql"
@src/gascaribe/datafix/OSF-849.sql

prompt "--------------- OSF-691.sql"
prompt "Aplicando src/gascaribe/perdidas-no-operacionales/parametros/insldc_parameter_ldc_conf_rege_acti_pno.sql"
@src/gascaribe/perdidas-no-operacionales/parametros/insldc_parameter_ldc_conf_rege_acti_pno.sql

prompt "Aplicando src/gascaribe/fwcob/GE_OBJECT_121709.sql"
@src/gascaribe/fwcob/GE_OBJECT_121709.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/paquetes/ldc_boregistropno.sql"
@src/gascaribe/perdidas-no-operacionales/paquetes/ldc_boregistropno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/configuracion/config_regenera_actividades_pno.sql"
@src/gascaribe/perdidas-no-operacionales/configuracion/config_regenera_actividades_pno.sql
prompt "--------------- OSF-691.sql"

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