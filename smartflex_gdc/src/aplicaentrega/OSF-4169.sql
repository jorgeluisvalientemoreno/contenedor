column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-4169"
prompt "-----------------"

prompt "-----PAQUETES-----" 

prompt "creacion paquete pkg_bcpersecucion-----" 
@src/gascaribe/cartera/suspensiones/paquetes/personalizaciones.pkg_bcpersecucion.sql
@src/gascaribe/cartera/suspensiones/sinonimos/personalizaciones.pkg_bcpersecucion.sql

prompt "creacion paquete pkg_bopersecucion-----" 
@src/gascaribe/cartera/suspensiones/paquetes/personalizaciones.pkg_bopersecucion.sql
@src/gascaribe/cartera/suspensiones/sinonimos/personalizaciones.pkg_bopersecucion.sql

prompt "Modificacion paquete ldc_bopersecucion-----" 
@src/gascaribe/cartera/suspensiones/paquetes/ldc_bopersecucion.sql


prompt "-----FWCOB-----" 
@src/gascaribe/fwcob/ge_object_120791.sql


prompt "-----JOBS-----" 
prompt "Desprogracion job LDC_ANULAR_ORDENES_PERSECU-----" 
@src/gascaribe/cartera/suspensiones/scripts/programacionjobpersecucion.sql

prompt "Desprogracion job ANULACIONORDENESPERSECUCION-----" 
@src/gascaribe/cartera/suspensiones/scripts/job_anulacionordenespersecucion.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-4169-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on