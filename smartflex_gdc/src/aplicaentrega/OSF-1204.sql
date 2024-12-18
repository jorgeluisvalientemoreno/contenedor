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

prompt "Aplicando src/gascaribe/servicios-nuevos/parametros/codigo_solicitud_venta_gas.sql"
@src/gascaribe/servicios-nuevos/parametros/codigo_solicitud_venta_gas.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/mo_packages.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_packages.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_order_activity.sql"
@src/gascaribe/objetos-producto/sinonimos/or_order_activity.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pr_component.sql"
@src/gascaribe/objetos-producto/sinonimos/pr_component.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pr_product.sql"
@src/gascaribe/objetos-producto/sinonimos/pr_product.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/servsusc.sql"
@src/gascaribe/objetos-producto/sinonimos/servsusc.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ut_trace.sql"
@src/gascaribe/objetos-producto/sinonimos/ut_trace.sql

prompt "Aplicando src/gascaribe/objetos-producto/paquetes/ut_trace.sql"
@src/gascaribe/objetos-producto/paquetes/ut_trace.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_producto.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/adm_person.pkg_producto.sql"
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.pkg_producto.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_componente_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_componente_producto.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/adm_person.pkg_componente_producto.sql"
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.pkg_componente_producto.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_gestion_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_gestion_producto.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.pkg_gestion_producto.sql"
@src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.pkg_gestion_producto.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/procedimientos/personalizaciones.oal_activaproducto.sql"
@src/gascaribe/servicios-nuevos/procedimientos/personalizaciones.oal_activaproducto.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.oal_activaproducto.sql"
@src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.oal_activaproducto.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/configuracion-objeto-accion/proceso_negocio.servicios_nuevos.sql"
@src/gascaribe/servicios-nuevos/configuracion-objeto-accion/proceso_negocio.servicios_nuevos.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/configuracion-objeto-accion/oal_activaproducto.sql"
@src/gascaribe/servicios-nuevos/configuracion-objeto-accion/oal_activaproducto.sql

prompt "Aplicando src/gascaribe/datafix/OSF-1204_desactiva_plugin_12152.sql"
@src/gascaribe/datafix/OSF-1204_desactiva_plugin_12152.sql

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