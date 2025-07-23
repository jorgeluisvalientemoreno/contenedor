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

prompt "Aplicando src/gascaribe/gestion-ordenes/procedure/personalizaciones.oal_creaprodcobroservicios.sql"
@src/gascaribe/gestion-ordenes/procedure/personalizaciones.oal_creaprodcobroservicios.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.oal_creaprodcobroservicios.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.oal_creaprodcobroservicios.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/procedure/personalizaciones.prccreaprodcobroservicios.sql"
@src/gascaribe/gestion-ordenes/procedure/personalizaciones.prccreaprodcobroservicios.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.prccreaprodcobroservicios.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.prccreaprodcobroservicios.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_botramitevsi.sql"
@src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_botramitevsi.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_botramitevsi.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_botramitevsi.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/pkg_reglas_tramitevsi.sql"
@src/gascaribe/atencion-usuarios/paquetes/pkg_reglas_tramitevsi.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/pkg_reglas_tramitevsi.sql"
@src/gascaribe/atencion-usuarios/sinonimos/pkg_reglas_tramitevsi.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fwcob/ge_object_121804.sql"
@src/gascaribe/atencion-usuarios/fwcob/ge_object_121804.sql

prompt "Aplicando src/gascaribe/reglas/121402814.sql"
@src/gascaribe/reglas/121402814.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_100101.sql"
@src/gascaribe/tramites/ps_package_type_100101.sql

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