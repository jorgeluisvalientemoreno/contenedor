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

prompt "Aplicando src/gascaribe/atencion-usuarios/parametros/nro_dias_exencion_cobro_factura.sql"
@src/gascaribe/atencion-usuarios/parametros/nro_dias_exencion_cobro_factura.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/parametros/cate_orden_exencion_regulados.sql"
@src/gascaribe/atencion-usuarios/parametros/cate_orden_exencion_regulados.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/parametros/cate_orden_exencion_no_regulados.sql"
@src/gascaribe/atencion-usuarios/parametros/cate_orden_exencion_no_regulados.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/tablas/personalizaciones.exencion_cobro_factura.sql"
@src/gascaribe/atencion-usuarios/tablas/personalizaciones.exencion_cobro_factura.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.exencion_cobro_factura.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.exencion_cobro_factura.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_exencion_cobro_factura.sql"
@src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_exencion_cobro_factura.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_xml_soli_aten_cliente.sql"
@src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_xml_soli_aten_cliente.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_bcexencion_cobro_factura.sql"
@src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_bcexencion_cobro_factura.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_boexencion_cobro_factura.sql"
@src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_boexencion_cobro_factura.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_bcexencion_cobro_factura.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_bcexencion_cobro_factura.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_boexencion_cobro_factura.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_boexencion_cobro_factura.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_exencion_cobro_factura.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_exencion_cobro_factura.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/procedimientos/personalizaciones.oal_exencion_cobro_factura.sql"
@src/gascaribe/atencion-usuarios/procedimientos/personalizaciones.oal_exencion_cobro_factura.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/procedimientos/personalizaciones.prcRegisExencionCobro.sql"
@src/gascaribe/atencion-usuarios/procedimientos/personalizaciones.prcRegisExencionCobro.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.prcRegisExencionCobro.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.prcRegisExencionCobro.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_bocncrm.sql"
@src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_bocncrm.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/pkg_reglas_tram_exencion_cobro.sql"
@src/gascaribe/atencion-usuarios/paquetes/pkg_reglas_tram_exencion_cobro.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/pkg_reglas_flujo_exen_cobro.sql"
@src/gascaribe/atencion-usuarios/paquetes/pkg_reglas_flujo_exen_cobro.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/pkg_uicncrm.sql"
@src/gascaribe/atencion-usuarios/paquetes/pkg_uicncrm.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fwcob/ge_object_121790.sql"
@src/gascaribe/atencion-usuarios/fwcob/ge_object_121790.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fwcob/ge_object_121787.sql"
@src/gascaribe/atencion-usuarios/fwcob/ge_object_121787.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fwcob/ge_object_121788.sql"
@src/gascaribe/atencion-usuarios/fwcob/ge_object_121788.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fwcob/ge_object_121805.sql"
@src/gascaribe/atencion-usuarios/fwcob/ge_object_121805.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fwcob/ge_object_121806.sql"
@src/gascaribe/atencion-usuarios/fwcob/ge_object_121806.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fwcea/info_vigencias_exencion.sql"
@src/gascaribe/atencion-usuarios/fwcea/info_vigencias_exencion.sql

prompt "Aplicando src/gascaribe/flujos/wf_unit_type_100675.sql"
@src/gascaribe/flujos/wf_unit_type_100675.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_100320.sql"
@src/gascaribe/tramites/ps_package_type_100320.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4171_Insertar_SA_TAB.sql"
@src/gascaribe/datafix/OSF-4171_Insertar_SA_TAB.sql

prompt "Aplicando src/gascaribe/datafix/OSF_4171_Configuracion_plugin.sql"
@src/gascaribe/datafix/OSF_4171_Configuracion_plugin.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4171_Datafix_promociones.sql"
@src/gascaribe/datafix/OSF-4171_Datafix_promociones.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fwcpi/CNCRM.sql"
@src/gascaribe/atencion-usuarios/fwcpi/CNCRM.sql

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