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

prompt "Aplicando src/gascaribe/gestion-ordenes/parametros/personalizaciones.tipos_trabajo_ord_servicios_ing.sql"
@src/gascaribe/gestion-ordenes/parametros/personalizaciones.tipos_trabajo_ord_servicios_ing.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_bcordenes_servicios_inge.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_bcordenes_servicios_inge.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_bcordenes_servicios_inge.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_bcordenes_servicios_inge.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_boordenes_servicios_inge.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_boordenes_servicios_inge.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_boordenes_servicios_inge.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_boordenes_servicios_inge.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/pkg_uiordenes_servicios_inge.sql"
@src/gascaribe/gestion-ordenes/paquetes/pkg_uiordenes_servicios_inge.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121756.sql"
@src/gascaribe/fwcob/ge_object_121756.sql

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