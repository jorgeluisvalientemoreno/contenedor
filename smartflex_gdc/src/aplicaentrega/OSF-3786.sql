column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-3786"
prompt "-----------------"


prompt "-----PAQUETES-----" 
prompt "--->Aplicando creacion PKG_LDC_INTERACCION_SIN_FLUJO"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_interaccion_sin_flujo.sql

prompt "--->Aplicando creacion sinonimo FNUOBTVALORTARIFAVALORFIJO"
@src/gascaribe/general/sinonimos/adm_person.pkg_ldc_interaccion_sin_flujo.sql


prompt "--->Aplicando borrado PERSONALIZACIONES.PKG_BOGESTION_FLUJOS"
@src/gascaribe/general/paquetes/personalizaciones.pkg_bogestion_flujos.sql


prompt "--->Aplicando creacion sinonimos dependientes MO_BOACTIONCREATEPLANWF"
@src/gascaribe/general/sinonimos/mo_boactioncreateplanwf.sql

prompt "--->Aplicando creacion PKG_BOGESTION_FLUJOS"
@src/gascaribe/general/paquetes/adm_person.pkg_bogestion_flujos.sql

prompt "--->Aplicando creacion sinonimo PKG_BOGESTION_NOTIFICACIONES"
@src/gascaribe/general/sinonimos/adm_person.pkg_bogestion_flujos.sql


prompt "-----DATAFIX-----" 
@src/gascaribe/datafix/OSF-3786_ins_homologacion_servicios.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-3786-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on