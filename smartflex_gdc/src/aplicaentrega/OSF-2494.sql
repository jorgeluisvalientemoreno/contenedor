column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "src/gascaribe/objetos-producto/sinonimos/vw_cmprodconsumptions.sql"
@src/gascaribe/objetos-producto/sinonimos/vw_cmprodconsumptions.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/tablas/ldc_calificacion_cons.sql"
@src/gascaribe/facturacion/reglas-critica/sql/tablas/ldc_calificacion_cons.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/tablas/personalizaciones.info_producto_desvpobl.sql"
@src/gascaribe/facturacion/reglas-critica/sql/tablas/personalizaciones.info_producto_desvpobl.sql

prompt "src/gascaribe/facturacion/reglas-critica/sinonimos/personalizaciones.info_producto_desvpobl.sql"
@src/gascaribe/facturacion/reglas-critica/sinonimos/personalizaciones.info_producto_desvpobl.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.actividad_veri_comercial.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.actividad_veri_comercial.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.actividad_veri_residecial.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.actividad_veri_residecial.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.categoria_comercial.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.categoria_comercial.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.categoria_industrial.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.categoria_industrial.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.categoria_residencial.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.categoria_residencial.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.formula_cons_difelect.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.formula_cons_difelect.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.meses_anti_comercial.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.meses_anti_comercial.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.meses_anti_residencial.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.meses_anti_residencial.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.meses_cons_consvali.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.meses_cons_consvali.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.meses_validacion_ordecome.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.meses_validacion_ordecome.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.meses_validacion_orderesi.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.meses_validacion_orderesi.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.numero_dias_normalizar.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.numero_dias_normalizar.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.metodo_cons_difelect.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.metodo_cons_difelect.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.metros_max_catecome.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.metros_max_catecome.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.metros_max_cateindu.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.metros_max_cateindu.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.metros_max_cateresi.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.metros_max_cateresi.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.metros_max_sinpromcatecome.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.metros_max_sinpromcatecome.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.metros_max_sinpromcateresi.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.metros_max_sinpromcateresi.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.numero_calc_limisuperior.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.numero_calc_limisuperior.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.numero_dias_normalizar.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.numero_dias_normalizar.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.numero_meses_consvali.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.numero_meses_consvali.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.porc_liminferior_come.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.porc_liminferior_come.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.porc_liminferior_indu.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.porc_liminferior_indu.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.porc_liminferior_resi.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.porc_liminferior_resi.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.porc_limsuperior_come.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.porc_limsuperior_come.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.porc_limsuperior_indu.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.porc_limsuperior_indu.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.porc_limsuperior_resi.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.porc_limsuperior_resi.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3001.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3001.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3002.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3002.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3003.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3003.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3004.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3004.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3005.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3005.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3006.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3006.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3007.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3007.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3008.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3008.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3009.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3009.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3010.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3010.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3011.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3011.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3012.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3012.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3013.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3013.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3014.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3014.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3015.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3015.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3016.sql"
@src/gascaribe/facturacion/reglas-critica/sql/parametros/personalizaciones.regla_consumo_3016.sql

prompt "src/gascaribe/facturacion/reglas-critica/paquetes/personalizaciones.pkg_info_producto_desvpobl.sql"
@src/gascaribe/facturacion/reglas-critica/paquetes/personalizaciones.pkg_info_producto_desvpobl.sql

prompt "src/gascaribe/facturacion/reglas-critica/sinonimos/personalizaciones.pkg_info_producto_desvpobl.sql"
@src/gascaribe/facturacion/reglas-critica/sinonimos/personalizaciones.pkg_info_producto_desvpobl.sql

prompt "src/gascaribe/facturacion/reglas-critica/paquetes/personalizaciones.pkg_bcgestionconsumodp.sql"
@src/gascaribe/facturacion/reglas-critica/paquetes/personalizaciones.pkg_bcgestionconsumodp.sql

prompt "src/gascaribe/facturacion/reglas-critica/sinonimos/personalizaciones.pkg_bcgestionconsumodp.sql"
@src/gascaribe/facturacion/reglas-critica/sinonimos/personalizaciones.pkg_bcgestionconsumodp.sql

prompt "src/gascaribe/facturacion/reglas-critica/sql/configuracion_calificaciones.sql"
@src/gascaribe/facturacion/reglas-critica/sql/configuracion_calificaciones.sql

prompt "src/gascaribe/facturacion/reglas-critica/fwcea/LDC_CALIFICACION_CONS.sql"
@src/gascaribe/facturacion/reglas-critica/fwcea/LDC_CALIFICACION_CONS.sql

prompt "src/gascaribe/facturacion/reglas-critica/md/CCALE.sql"
@src/gascaribe/facturacion/reglas-critica/md/CCALE.sql

prompt "src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolfac.pck"
@src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolfac.pck

prompt "src/gascaribe/facturacion/spool/paquete/ldc_detallefact_gascaribe.pck"
@src/gascaribe/facturacion/spool/paquete/ldc_detallefact_gascaribe.pck

prompt "src/gascaribe/facturacion/spool/fced/confexme_72.sql"
@src/gascaribe/facturacion/spool/fced/confexme_72.sql


prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/