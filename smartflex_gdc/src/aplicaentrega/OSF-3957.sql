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

prompt "Aplicando src/gascaribe/actas/paquetes/personalizaciones.pkg_boexclusionordenes.sql"
@src/gascaribe/actas/paquetes/personalizaciones.pkg_boexclusionordenes.sql

prompt "Aplicando src/gascaribe/actas/sinonimos/personalizaciones.pkg_boexclusionordenes.sql"
@src/gascaribe/actas/sinonimos/personalizaciones.pkg_boexclusionordenes.sql

prompt "Aplicando src/gascaribe/contratacion/paquetes/pkg_reglasplancondiciones.sql"
@src/gascaribe/contratacion/paquetes/pkg_reglasplancondiciones.sql

prompt "Aplicando src/gascaribe/contratacion/fwcob/ge_object_121789.sql"
@src/gascaribe/contratacion/fwcob/ge_object_121789.sql

prompt "Aplicando src/gascaribe/contratacion/reglas/121310391.sql"
@src/gascaribe/contratacion/reglas/121310391.sql

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