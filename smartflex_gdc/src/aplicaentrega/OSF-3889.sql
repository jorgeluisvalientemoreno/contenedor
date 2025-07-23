column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ldc_log_camb_fecha_max_leg.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ldc_log_camb_fecha_max_leg.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/or_log_order_action.sql"
@src/gascaribe/gestion-ordenes/sinonimos/or_log_order_action.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_ldc_log_camb_fecha_max_leg.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_ldc_log_camb_fecha_max_leg.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_ldc_log_camb_fecha_max_leg.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_ldc_log_camb_fecha_max_leg.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_boldcmomafela.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_boldcmomafela.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_boldcmomafela.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_boldcmomafela.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/pkg_uildcmomafela.sql"
@src/gascaribe/gestion-ordenes/paquetes/pkg_uildcmomafela.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/pkg_uildcmomafela.sql"
@src/gascaribe/gestion-ordenes/sinonimos/pkg_uildcmomafela.sql

prompt "Aplicando src/gascaribe/gestion-contratista/procedimientos/ldcmomafela.sql"
@src/gascaribe/gestion-contratista/procedimientos/ldcmomafela.sql



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

