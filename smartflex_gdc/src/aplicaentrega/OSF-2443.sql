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

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_marca_producto.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_marca_producto.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ldc_unit_rp_plamin.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ldc_unit_rp_plamin.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_plazos_cert.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_plazos_cert.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_order.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_order.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/tablas/ldc_order.sql"
@src/gascaribe/gestion-ordenes/tablas/ldc_order.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/parametros/tt_autoreco_reparacion.sql"
@src/gascaribe/gestion-ordenes/parametros/tt_autoreco_reparacion.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/parametros/mar_prod_fnuasignaautorecorep.sql"
@src/gascaribe/gestion-ordenes/parametros/mar_prod_fnuasignaautorecorep.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/parametros/mar_prod_fnuasignaautorecorev.sql"
@src/gascaribe/gestion-ordenes/parametros/mar_prod_fnuasignaautorecorev.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_orden_uobysol.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_orden_uobysol.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_orden_uobysol.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.pkg_orden_uobysol.sql

prompt "Aplicando src/gascaribe/revision-periodica/plazos/paquetes/personalizaciones.pkg_bcplazos_certificados.sql"
@src/gascaribe/revision-periodica/plazos/paquetes/personalizaciones.pkg_bcplazos_certificados.sql

prompt "Aplicando src/gascaribe/revision-periodica/plazos/sinonimos/personalizaciones.pkg_bcplazos_certificados.sql"
@src/gascaribe/revision-periodica/plazos/sinonimos/personalizaciones.pkg_bcplazos_certificados.sql

prompt "Aplicando src/gascaribe/revision-periodica/plazos/paquetes/personalizaciones.pkg_bcautoreconectados.sql"
@src/gascaribe/revision-periodica/plazos/paquetes/personalizaciones.pkg_bcautoreconectados.sql

prompt "Aplicando src/gascaribe/revision-periodica/plazos/sinonimos/personalizaciones.pkg_bcautoreconectados.sql"
@src/gascaribe/revision-periodica/plazos/sinonimos/personalizaciones.pkg_bcautoreconectados.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/personalizaciones.fnuasignaautorecorep.sql"
@src/gascaribe/gestion-ordenes/funciones/personalizaciones.fnuasignaautorecorep.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.fnuasignaautorecorep.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.fnuasignaautorecorep.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/personalizaciones.fnuasignaautorecorev.sql"
@src/gascaribe/gestion-ordenes/funciones/personalizaciones.fnuasignaautorecorev.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.fnuasignaautorecorev.sql"
@src/gascaribe/gestion-ordenes/sinonimos/personalizaciones.fnuasignaautorecorev.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2443_insert_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-2443_insert_homologacion_servicios.sql

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