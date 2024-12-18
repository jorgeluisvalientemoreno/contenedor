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

prompt "Aplicando src/gascaribe/gestion-ordenes/tablas/conf_uo_usu_especiales.sql"
@src/gascaribe/gestion-ordenes/tablas/conf_uo_usu_especiales.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/conf_uo_usu_especiales.sql"
@src/gascaribe/gestion-ordenes/sinonimos/conf_uo_usu_especiales.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/secuencias/seq_conf_uo_usu_especiales.sql"
@src/gascaribe/gestion-ordenes/secuencias/seq_conf_uo_usu_especiales.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_bcconfiguoespeciales.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_bcconfiguoespeciales.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_bcconfiguoespeciales.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_bcconfiguoespeciales.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/personalizaciones.fnuasignausuariosespeciales.sql"
@src/gascaribe/gestion-ordenes/funciones/personalizaciones.fnuasignausuariosespeciales.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.fnuasignausuariosespeciales.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.fnuasignausuariosespeciales.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/fwcea/conf_uo_usu_especiales.sql"
@src/gascaribe/gestion-ordenes/fwcea/conf_uo_usu_especiales.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/fwcmd/mdcuue.sql"
@src/gascaribe/gestion-ordenes/fwcmd/mdcuue.sql


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