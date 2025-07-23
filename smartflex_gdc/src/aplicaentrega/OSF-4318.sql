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

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/parametros/actividades_no_reincidentes_pno.sql"
@src/gascaribe/perdidas-no-operacionales/parametros/actividades_no_reincidentes_pno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/parametros/actividades_reincidentes_pno.sql"
@src/gascaribe/perdidas-no-operacionales/parametros/actividades_reincidentes_pno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/parametros/estado_producto_pno.sql"
@src/gascaribe/perdidas-no-operacionales/parametros/estado_producto_pno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/parametros/fecha_inicio_validacion_pno.sql"
@src/gascaribe/perdidas-no-operacionales/parametros/fecha_inicio_validacion_pno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/parametros/tipo_trabajo_causal_reincidentes_pno.sql"
@src/gascaribe/perdidas-no-operacionales/parametros/tipo_trabajo_causal_reincidentes_pno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/parametros/tipo_trabajo_pliego_de_cargos_pno.sql"
@src/gascaribe/perdidas-no-operacionales/parametros/tipo_trabajo_pliego_de_cargos_pno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/paquetes/personalizaciones.pkg_bcregistropno.sql"
@src/gascaribe/perdidas-no-operacionales/paquetes/personalizaciones.pkg_bcregistropno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/sinonimos/personalizaciones.pkg_bcregistropno.sql"
@src/gascaribe/perdidas-no-operacionales/sinonimos/personalizaciones.pkg_bcregistropno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/paquetes/personalizaciones.pkg_boregistropno.sql"
@src/gascaribe/perdidas-no-operacionales/paquetes/personalizaciones.pkg_boregistropno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/paquetes/pkg_reglas_tram_registro_pno.sql"
@src/gascaribe/perdidas-no-operacionales/paquetes/pkg_reglas_tram_registro_pno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/fwcob/ge_object_121809.sql"
@src/gascaribe/perdidas-no-operacionales/fwcob/ge_object_121809.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/fwcob/ge_object_121810.sql"
@src/gascaribe/perdidas-no-operacionales/fwcob/ge_object_121810.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_100260.sql"
@src/gascaribe/tramites/ps_package_type_100260.sql

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