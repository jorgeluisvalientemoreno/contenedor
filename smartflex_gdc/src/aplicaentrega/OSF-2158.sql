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

--prompt "Aplicando src/gascaribe/facturacion/spool/fced/confexme_82.sql"
--@src/gascaribe/facturacion/spool/fced/confexme_82.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/configuracion_proceso_neg.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/configuracion_proceso_neg.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.numero_intentos_faelgen.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.numero_intentos_faelgen.sql

prompt "src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.cant_hilo_factele.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.cant_hilo_factele.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.causales_ingreso_fael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.causales_ingreso_fael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.cod_tributo_emisor.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.cod_tributo_emisor.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.conc_excluir_ingreso_fael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.conc_excluir_ingreso_fael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.concepto_consumo_fael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.concepto_consumo_fael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.email_emisor.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.email_emisor.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.fax_emisor.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.fax_emisor.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.localidad_emisor.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.localidad_emisor.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.matricula_mercantil.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.matricula_mercantil.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.nombre_tributo_emisor.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.nombre_tributo_emisor.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.porcentaje_iva_actual.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.porcentaje_iva_actual.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.resp_fiscal_emisor.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.resp_fiscal_emisor.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.telefono_emisor.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.telefono_emisor.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.tipo_docu_factura.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.tipo_docu_factura.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.zona_postal_emisor.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.zona_postal_emisor.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.cant_hilo_venta_factele.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.cant_hilo_venta_factele.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.causales_ingreso_venta_fael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.causales_ingreso_venta_fael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.tipo_docu_ventas.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.tipo_docu_ventas.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.documento_soporte_venta_fael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.documento_soporte_venta_fael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.direccion_emisor.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.direccion_emisor.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.email_controler_emisor.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.email_controler_emisor.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.razon_social_emisor.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.razon_social_emisor.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.tipo_regimen_emisor.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.tipo_regimen_emisor.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.cedula_defecto_receptor.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.cedula_defecto_receptor.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.valida_nits.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.valida_nits.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.codigo_descuento.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.codigo_descuento.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.condiciones_especiales_factele.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/personalizaciones.condiciones_especiales_factele.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/secuencia/seq_recofael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/secuencia/seq_recofael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/secuencia/seq_tidofael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/secuencia/seq_tidofael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/secuencia/personalizaciones.seq_factura_elect_gen_consfael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/secuencia/personalizaciones.seq_factura_elect_gen_consfael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/secuencia/personalizaciones.seq_lote_fact_electronica.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/secuencia/personalizaciones.seq_lote_fact_electronica.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/tablas/personalizaciones.recofael_log.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/tablas/personalizaciones.recofael_log.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/tablas/tidofael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/tablas/tidofael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/tablas/recofael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/tablas/recofael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/tablas/personalizaciones.lote_fact_electronica.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/tablas/personalizaciones.lote_fact_electronica.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/tablas/personalizaciones.factura_elect_general.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/tablas/personalizaciones.factura_elect_general.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.factura_elect_general.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.factura_elect_general.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.lote_fact_electronica.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.lote_fact_electronica.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.recofael_log.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.recofael_log.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/recofael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/recofael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/tidofael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/tidofael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/fwcea/tidofael.sql"
@src/gascaribe/facturacion/facturacion_electronica/fwcea/tidofael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/fwcea/recofael.sql"
@src/gascaribe/facturacion/facturacion_electronica/fwcea/recofael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/fwcmd/mdctdf.sql"
@src/gascaribe/facturacion/facturacion_electronica/fwcmd/mdctdf.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/fwcmd/mdccfe.sql"
@src/gascaribe/facturacion/facturacion_electronica/fwcmd/mdccfe.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/paquetes/pkg_recofael.sql"
@src/gascaribe/facturacion/facturacion_electronica/paquetes/pkg_recofael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/pkg_recofael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/pkg_recofael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_recofael_log.sql"
@src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_recofael_log.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_recofael_log.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_recofael_log.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/trigger/trg_valiconsfael.sql"
@src/gascaribe/facturacion/facturacion_electronica/trigger/trg_valiconsfael.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ta_rangvitc.sql"
@src/gascaribe/objetos-producto/sinonimos/ta_rangvitc.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/concbali.sql"
@src/gascaribe/objetos-producto/sinonimos/concbali.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ed_document.sql"
@src/gascaribe/objetos-producto/sinonimos/ed_document.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ldc_equiva_localidad.sql"
@src/gascaribe/objetos-producto/sinonimos/ldc_equiva_localidad.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_lote_fact_electronica.sql"
@src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_lote_fact_electronica.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_lote_fact_electronica.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_lote_fact_electronica.sql

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

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/job/adm_person.job_facturacion_elecgen.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/job/adm_person.job_facturacion_elecgen.sql


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