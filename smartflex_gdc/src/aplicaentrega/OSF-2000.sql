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


prompt "Aplicando src/ejecutores/bajar-ejecutores.sql"
@src/ejecutores/bajar-ejecutores.sql

prompt "Aplicando src/gascaribe/nuevas-energias/condicion-visualizacion/sa_tab_tramite_100316.sql"
@src/gascaribe/nuevas-energias/condicion-visualizacion/sa_tab_tramite_100316.sql

prompt "Aplicando src/gascaribe/nuevas-energias/parametros/ciclo_productos_energia_solar.sql"
@src/gascaribe/nuevas-energias/parametros/ciclo_productos_energia_solar.sql

prompt "Aplicando src/gascaribe/general/parametros/tipo_soli_no_val_dir_prod_gas.sql"
@src/gascaribe/general/parametros/tipo_soli_no_val_dir_prod_gas.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.pkg_parametros.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_parametros.sql



prompt "Aplicando src/gascaribe/ventas/trigger/ldc_trgvaldir.sql"
@src/gascaribe/ventas/trigger/ldc_trgvaldir.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_100316.sql"
@src/gascaribe/tramites/ps_package_type_100316.sql






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