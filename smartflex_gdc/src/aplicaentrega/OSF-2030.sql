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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_task_type_causal.sql"
@src/gascaribe/objetos-producto/sinonimos/or_task_type_causal.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/cc_commercial_plan.sql"
@src/gascaribe/objetos-producto/sinonimos/cc_commercial_plan.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_bcbloqueo_ordenes.sql"
@src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_bcbloqueo_ordenes.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.pkg_bcbloqueo_ordenes.sql"
@src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.pkg_bcbloqueo_ordenes.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/permisos/personalizaciones.pkg_bcbloqueo_ordenes.sql"
@src/gascaribe/servicios-nuevos/permisos/personalizaciones.pkg_bcbloqueo_ordenes.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_bobloqueo_ordenes.sql"
@src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_bobloqueo_ordenes.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.pkg_bobloqueo_ordenes.sql"
@src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.pkg_bobloqueo_ordenes.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/permisos/personalizaciones.pkg_bobloqueo_ordenes.sql"
@src/gascaribe/servicios-nuevos/permisos/personalizaciones.pkg_bobloqueo_ordenes.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/pkg_uipbblor.sql"
@src/gascaribe/servicios-nuevos/paquetes/pkg_uipbblor.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/permisos/pkg_uipbblor.sql"
@src/gascaribe/servicios-nuevos/permisos/pkg_uipbblor.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/pkg_uipbblor.sql"
@src/gascaribe/servicios-nuevos/sinonimos/pkg_uipbblor.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/fwcpb/pbblor.sql"
@src/gascaribe/servicios-nuevos/fwcpb/pbblor.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2030_actualizar_valor_asignado_contrato.sql"
@src/gascaribe/datafix/OSF-2030_actualizar_valor_asignado_contrato.sql

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