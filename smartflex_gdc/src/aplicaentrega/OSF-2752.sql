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

prompt "Aplicando src/gascaribe/predios/tablas/ldc_info_predio.sql"
@src/gascaribe/predios/tablas/ldc_info_predio.sql

prompt "Aplicando src/gascaribe/predios/sinonimos/adm_person.ldc_info_predio.sql"
@src/gascaribe/predios/sinonimos/adm_person.ldc_info_predio.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2752_Actualizar_info_predio_castigado.sql"
@src/gascaribe/datafix/OSF-2752_Actualizar_info_predio_castigado.sql

prompt "Aplicando src/gascaribe/predios/paquetes/adm_person.pkg_ldc_info_predio.sql"
@src/gascaribe/predios/paquetes/adm_person.pkg_ldc_info_predio.sql

prompt "Aplicando src/gascaribe/predios/sinonimos/adm_person.pkg_ldc_info_predio.sql"
@src/gascaribe/predios/sinonimos/adm_person.pkg_ldc_info_predio.sql

prompt "Aplicando src/gascaribe/predios/fwcea/ldc_info_predio.sql"
@src/gascaribe/predios/fwcea/ldc_info_predio.sql

prompt "Aplicando src/gascaribe/predios/fwcmd/mpzns.sql"
@src/gascaribe/predios/fwcmd/mpzns.sql

prompt "Aplicando src/gascaribe/predios/paquetes/personalizaciones.pkg_bcinfopredio.sql"
@src/gascaribe/predios/paquetes/personalizaciones.pkg_bcinfopredio.sql

prompt "Aplicando src/gascaribe/predios/paquetes/personalizaciones.pkg_boinfopredio.sql"
@src/gascaribe/predios/paquetes/personalizaciones.pkg_boinfopredio.sql

prompt "Aplicando src/gascaribe/predios/sinonimos/personalizaciones.pkg_bcinfopredio.sql"
@src/gascaribe/predios/sinonimos/personalizaciones.pkg_bcinfopredio.sql

prompt "Aplicando src/gascaribe/predios/sinonimos/personalizaciones.pkg_boinfopredio.sql"
@src/gascaribe/predios/sinonimos/personalizaciones.pkg_boinfopredio.sql

prompt "Aplicando src/gascaribe/predios/paquetes/pkg_uiinfopredio.sql"
@src/gascaribe/predios/paquetes/pkg_uiinfopredio.sql

prompt "Aplicando src/gascaribe/predios/fwcob/ge_object_121758.sql"
@src/gascaribe/predios/fwcob/ge_object_121758.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/ldc_bosuspensions.sql"
@src/gascaribe/cartera/suspensiones/ldc_bosuspensions.sql

prompt "Aplicando src/gascaribe/reglas/121396482.sql"
@src/gascaribe/reglas/121396482.sql

prompt "Aplicando src/gascaribe/reglas/121396632.sql"
@src/gascaribe/reglas/121396632.sql

prompt "Aplicando src/test/recompilar-objetos.sql"
@src/test/recompilar-objetos.sql

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