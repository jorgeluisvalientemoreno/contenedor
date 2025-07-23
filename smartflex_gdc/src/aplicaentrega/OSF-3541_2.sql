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

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/proceso-negocio/proceso_negocio.reformas.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/proceso-negocio/proceso_negocio.reformas.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/mere_actualizacion_datos_predio.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/mere_actualizacion_datos_predio.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/pack_permite_ing_direccion.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/pack_permite_ing_direccion.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/mensaje_correo_verificacion_estrato.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/mensaje_correo_verificacion_estrato.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/asunto_correo_verificacion_estrato.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/asunto_correo_verificacion_estrato.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/actividad_verificacion_estrato_actual.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/actividad_verificacion_estrato_actual.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/correos_verificacion_estrato.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/correos_verificacion_estrato.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/paquetes/pkg_reglas_flujo_cambiodeuso.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/paquetes/pkg_reglas_flujo_cambiodeuso.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/fwcob/ge_object_121768.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/fwcob/ge_object_121768.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/procedimientos/personalizaciones.oal_actualizacategoria.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/procedimientos/personalizaciones.oal_actualizacategoria.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/sinonimos/personalizaciones.oal_actualizacategoria.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/sinonimos/personalizaciones.oal_actualizacategoria.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/procedimientos/personalizaciones.prcactualizacategoriacambiouso.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/procedimientos/personalizaciones.prcactualizacategoriacambiouso.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/sinonimos/personalizaciones.prcactualizacategoriacambiouso.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/sinonimos/personalizaciones.prcactualizacategoriacambiouso.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/plugin/tt_12622_cambio_plan_comercial.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/plugin/tt_12622_cambio_plan_comercial.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/plugin/tt_12622_actualiza_categoria_cambio_uso.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/plugin/tt_12622_actualiza_categoria_cambio_uso.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/procedimientos/prcreglavalsubcatcambiouso.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/procedimientos/prcreglavalsubcatcambiouso.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/fwcob/ge_object_121812.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/fwcob/ge_object_121812.sql

prompt "Aplicando src/gascaribe/reglas/121057740.sql"
@src/gascaribe/reglas/121057740.sql

prompt "Aplicando src/gascaribe/flujos/WF_UNIT_TYPE_100390.sql"
@src/gascaribe/flujos/WF_UNIT_TYPE_100390.sql

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