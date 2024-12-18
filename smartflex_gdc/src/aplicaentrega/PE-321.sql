column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO PE-321');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/revision-periodica/certificados/pagos-validacion/parametros/msj_aprobacion_automatica.sql"
@src/gascaribe/revision-periodica/certificados/pagos-validacion/parametros/msj_aprobacion_automatica.sql



prompt "Aplicando src/gascaribe/revision-periodica/certificados/pagos-validacion/alter_ldc_genordvaldocu.sql"
@src/gascaribe/revision-periodica/certificados/pagos-validacion/alter_ldc_genordvaldocu.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/pagos-validacion/alter_ldc_resuinsp.sql"
@src/gascaribe/revision-periodica/certificados/pagos-validacion/alter_ldc_resuinsp.sql


prompt "Aplicando src/gascaribe/revision-periodica/certificados/pagos-validacion/actualiza_actividad_validacion.sql"
@src/gascaribe/revision-periodica/certificados/pagos-validacion/actualiza_actividad_validacion.sql



prompt "Aplicando src/gascaribe/revision-periodica/certificados/pagos-validacion/ldc_prgenordvaldoc.sql"
@src/gascaribe/revision-periodica/certificados/pagos-validacion/ldc_prgenordvaldoc.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/pagos-validacion/ldc_trggenordvaldoc.sql"
@src/gascaribe/revision-periodica/certificados/pagos-validacion/ldc_trggenordvaldoc.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/fwcea/ldc_resuinsp.sql"
@src/gascaribe/revision-periodica/certificados/fwcea/ldc_resuinsp.sql


prompt "Aplicando src/gascaribe/revision-periodica/certificados/fwcmd/ldc_md_resuinsp.sql"
@src/gascaribe/revision-periodica/certificados/fwcmd/ldc_md_resuinsp.sql






prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega"
prompt "------------------------------------------------------"

commit;