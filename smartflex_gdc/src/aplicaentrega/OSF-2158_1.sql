column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"


prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.causales_ingreso_fael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.causales_ingreso_fael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.conc_excluir_ingreso_fael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.conc_excluir_ingreso_fael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.tipo_docu_factura.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.tipo_docu_factura.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.tipo_docu_notas.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.tipo_docu_notas.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.arte_fact_recurrente.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.arte_fact_recurrente.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.arte_fact_venta.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.arte_fact_venta.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.arte_fact_notas.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.arte_fact_notas.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.causales_ingreso_venta_fael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.causales_ingreso_venta_fael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.tipo_docu_ventas.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.tipo_docu_ventas.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.documento_soporte_venta_fael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.documento_soporte_venta_fael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.condiciones_especiales_factele.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.condiciones_especiales_factele.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.cant_hilo_notas_factele.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.cant_hilo_notas_factele.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.causales_ingreso_notas_fael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.causales_ingreso_notas_fael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.prefijo_nota_credito.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.prefijo_nota_credito.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.prefijo_nota_debito.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.prefijo_nota_debito.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.programa_ajuste_consumo_fael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.programa_ajuste_consumo_fael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.programas_excluir_notas_fael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.programas_excluir_notas_fael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_factura_elect_general.sql"
@src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_factura_elect_general.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_factura_elect_general.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_factura_elect_general.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_bcfactuelectronicagen.sql"
@src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_bcfactuelectronicagen.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_bofactuelectronicagen.sql"
@src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_bofactuelectronicagen.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_utilfacturacionelecgen.sql"
@src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_utilfacturacionelecgen.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_bofactuelectronicagen.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_bofactuelectronicagen.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_utilfacturacionelecgen.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_utilfacturacionelecgen.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_bcfactuelectronicagen.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_bcfactuelectronicagen.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/procedimiento/adm_person.api_actualizaplanofael.sql"
@src/gascaribe/facturacion/facturacion_electronica/procedimiento/adm_person.api_actualizaplanofael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/adm_person.api_actualizaplanofael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/adm_person.api_actualizaplanofael.sql

prompt "Aplicando src/gascaribe/facturacion/spool/paquete/ldc_detallefact_gascaribe.pck"
@src/gascaribe/facturacion/spool/paquete/ldc_detallefact_gascaribe.pck

prompt "Aplicando src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolfac.pck"
@src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolfac.pck

prompt "Aplicando src/gascaribe/facturacion/spool/framework/fwcob/ge_object_121713.sql"
@src/gascaribe/facturacion/spool/framework/fwcob/ge_object_121713.sql

prompt "Aplicando src/gascaribe/facturacion/spool/fced/confexme_72.sql"
@src/gascaribe/facturacion/spool/fced/confexme_72.sql

prompt "Aplicando src/gascaribe/facturacion/spool/fced/confexme_82.sql"
@src/gascaribe/facturacion/spool/fced/confexme_82.sql

prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/