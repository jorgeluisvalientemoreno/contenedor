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

prompt "Aplicando src/gascaribe/ventas/proceso-negocio/proceso_negocio.energia_solar.sql"
@src/gascaribe/ventas/proceso-negocio/proceso_negocio.energia_solar.sql

prompt "Aplicando src/gascaribe/ventas/proceso-negocio/proceso_negocio.ventas.sql"
@src/gascaribe/ventas/proceso-negocio/proceso_negocio.ventas.sql

prompt "Aplicando src/gascaribe/ventas/proceso-negocio/proceso_negocio.pno.sql"
@src/gascaribe/ventas/proceso-negocio/proceso_negocio.pno.sql

prompt "Aplicando src/gascaribe/ventas/proceso-negocio/proceso_negocio.redes.sql"
@src/gascaribe/ventas/proceso-negocio/proceso_negocio.redes.sql

prompt "Aplicando src/gascaribe/ventas/proceso-negocio/proceso_negocio.contabilidad.sql"
@src/gascaribe/ventas/proceso-negocio/proceso_negocio.contabilidad.sql

prompt "Aplicando src/gascaribe/ventas/proceso-negocio/proceso_negocio.tesoreria.sql"
@src/gascaribe/ventas/proceso-negocio/proceso_negocio.tesoreria.sql

prompt "Aplicando src/gascaribe/ventas/proceso-negocio/proceso_negocio.calidad.sql"
@src/gascaribe/ventas/proceso-negocio/proceso_negocio.calidad.sql

prompt "Aplicando src/gascaribe/ventas/proceso-negocio/proceso_negocio.operacion_mantenimiento.sql"
@src/gascaribe/ventas/proceso-negocio/proceso_negocio.operacion_mantenimiento.sql

prompt "Aplicando src/gascaribe/ventas/proceso-negocio/proceso_negocio.analisis_consumo.sql"
@src/gascaribe/ventas/proceso-negocio/proceso_negocio.analisis_consumo.sql

prompt "Aplicando src/gascaribe/ventas/proceso-negocio/proceso_negocio.servicios_asociados.sql"
@src/gascaribe/ventas/proceso-negocio/proceso_negocio.servicios_asociados.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/ldc_tipotrab_coti_com.sql"
@src/gascaribe/ventas/sinonimos/ldc_tipotrab_coti_com.sql

prompt "Aplicando src/gascaribe/ventas/permisos/ldc_tipotrab_coti_com.sql"
@src/gascaribe/ventas/permisos/ldc_tipotrab_coti_com.sql

prompt "Aplicando src/gascaribe/ventas/parametros/personalizaciones.porcentaje_minimo_aiu_fcvc.sql"
@src/gascaribe/ventas/parametros/personalizaciones.porcentaje_minimo_aiu_fcvc.sql

prompt "Aplicando src/gascaribe/ventas/parametros/personalizaciones.porcentaje_maximo_aiu_fcvc.sql"
@src/gascaribe/ventas/parametros/personalizaciones.porcentaje_maximo_aiu_fcvc.sql

prompt "Aplicando src/gascaribe/ventas/parametros/personalizaciones.actividad_instalacion_interna.sql"
@src/gascaribe/ventas/parametros/personalizaciones.actividad_instalacion_interna.sql

prompt "Aplicando src/gascaribe/ventas/parametros/personalizaciones.tipo_trabajo_instalacion_interna.sql"
@src/gascaribe/ventas/parametros/personalizaciones.tipo_trabajo_instalacion_interna.sql

prompt "Aplicando src/gascaribe/ventas/parametros/personalizaciones.categoria_inactiva_aiu.sql"
@src/gascaribe/ventas/parametros/personalizaciones.categoria_inactiva_aiu.sql

prompt "Aplicando src/gascaribe/objetos-producto/permisos/cc_quotation.sql"
@src/gascaribe/objetos-producto/permisos/cc_quotation.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/ldc_cotizacion_comercial.sql"
@src/gascaribe/ventas/sinonimos/ldc_cotizacion_comercial.sql

prompt "Aplicando src/gascaribe/ventas/permisos/ldc_cotizacion_comercial.sql"
@src/gascaribe/ventas/permisos/ldc_cotizacion_comercial.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/ldc_items_cotizacion_com.sql"
@src/gascaribe/ventas/sinonimos/ldc_items_cotizacion_com.sql

prompt "Aplicando src/gascaribe/ventas/permisos/ldc_items_cotizacion_com.sql"
@src/gascaribe/ventas/permisos/ldc_items_cotizacion_com.sql

prompt "Aplicando src/gascaribe/ventas/tablas/personalizaciones.datos_cotizacion_comercial.sql"
@src/gascaribe/ventas/tablas/personalizaciones.datos_cotizacion_comercial.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/personalizaciones.datos_cotizacion_comercial.sql"
@src/gascaribe/ventas/sinonimos/personalizaciones.datos_cotizacion_comercial.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/personalizaciones.pkg_bocotizacioncomercial.sql"
@src/gascaribe/ventas/paquetes/personalizaciones.pkg_bocotizacioncomercial.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/personalizaciones.pkg_bocotizacioncomercial.sql"
@src/gascaribe/ventas/sinonimos/personalizaciones.pkg_bocotizacioncomercial.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/ldc_bocotizacioncomercial.sql"
@src/gascaribe/ventas/paquetes/ldc_bocotizacioncomercial.sql

prompt "Aplicando src/gascaribe/ventas/funciones/fnu_baseliquidacion.sql"
@src/gascaribe/ventas/funciones/fnu_baseliquidacion.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/fnu_baseliquidacion.sql"
@src/gascaribe/ventas/sinonimos/fnu_baseliquidacion.sql

prompt "Aplicando src/gascaribe/ventas/fwcob/ge_object_121731.sql"
@src/gascaribe/ventas/fwcob/ge_object_121731.sql

prompt "Aplicando src/gascaribe/ventas/giras/ludycom_commercialsale.sql"
@src/gascaribe/ventas/giras/ludycom_commercialsale.sql

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