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

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_boservicio_tecn_clie_ext.sql"
@src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_boservicio_tecn_clie_ext.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_boservicio_tecn_clie_ext.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_boservicio_tecn_clie_ext.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/pkg_reglas_tram_serv_tecn_ext.sql"
@src/gascaribe/atencion-usuarios/paquetes/pkg_reglas_tram_serv_tecn_ext.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/pkg_reglas_tram_serv_tecn_ext.sql"
@src/gascaribe/atencion-usuarios/sinonimos/pkg_reglas_tram_serv_tecn_ext.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fwcob/ge_object_121807.sql"
@src/gascaribe/atencion-usuarios/fwcob/ge_object_121807.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fwcob/ge_object_121808.sql"
@src/gascaribe/atencion-usuarios/fwcob/ge_object_121808.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_299.sql"
@src/gascaribe/tramites/ps_package_type_299.sql

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