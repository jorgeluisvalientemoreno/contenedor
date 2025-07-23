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

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldci_pkintegragis.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldci_pkintegragis.sql

prompt "Aplicando src/gascaribe/ventas/parametros/categoria_venta_gas_cotizada_ciclo_gis.sql"
@src/gascaribe/ventas/parametros/categoria_venta_gas_cotizada_ciclo_gis.sql

prompt "Aplicando src/gascaribe/ventas/parametros/codigo_error_permite_venta_gas_cotizada_ciclo_gis.sql"
@src/gascaribe/ventas/parametros/codigo_error_permite_venta_gas_cotizada_ciclo_gis.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/paquetes/adm_person.pkg_bodirecciones.sql"
@src/gascaribe/perdidas-no-operacionales/paquetes/adm_person.pkg_bodirecciones.sql

prompt "Aplicando src/gascaribe/ventas/procedimientos/prcreglavaldireccioncotizada.sql"
@src/gascaribe/ventas/procedimientos/prcreglavaldireccioncotizada.sql

prompt "Aplicando src/gascaribe/ventas/fwcob/ge_object_121779.sql"
@src/gascaribe/ventas/fwcob/ge_object_121779.sql

prompt "Aplicando src/gascaribe/reglas/121396482.sql"
@src/gascaribe/reglas/121396482.sql

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