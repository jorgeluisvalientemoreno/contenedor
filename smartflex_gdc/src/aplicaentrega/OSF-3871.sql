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

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ldc_cott_cflo.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ldc_cott_cflo.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_ldc_au_cflot.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_ldc_au_cflot.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_ldc_au_cflot.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_ldc_au_cflot.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_bcldccflot.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_bcldccflot.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_bcldccflot.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_bcldccflot.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_boldccflot.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_boldccflot.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_boldccflot.sqll"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_boldccflot.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/pkg_uildccflot.sql"
@src/gascaribe/gestion-ordenes/paquetes/pkg_uildccflot.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/pkg_uildccflot.sql"
@src/gascaribe/gestion-ordenes/sinonimos/pkg_uildccflot.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/procedure/adm_person.ldcprocescambiofeleot.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldcprocescambiofeleot.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/fwcpb/ldccflot.sql"
@src/gascaribe/gestion-ordenes/fwcpb/ldccflot.sql

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