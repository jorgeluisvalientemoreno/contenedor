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

prompt "Aplicando src/gascaribe/ventas/comisiones/procedimientos/gopcvnel.sql"
@src/gascaribe/ventas/comisiones/procedimientos/gopcvnel.sql

prompt "Aplicando src/gascaribe/metrologia/paquetes/ldc_bometrological.sql"
@src/gascaribe/metrologia/paquetes/ldc_bometrological.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/package/ldc_boordenes.sql"
@src/gascaribe/gestion-ordenes/package/ldc_boordenes.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/ldc_bosuspensions.sql"
@src/gascaribe/cartera/suspensiones/ldc_bosuspensions.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/ldc_bsgestiontarifas.sql"
@src/gascaribe/facturacion/paquetes/ldc_bsgestiontarifas.sql

prompt "Aplicando src/gascaribe/ventas/procedimientos/ldc_pbldcrvp.sql"
@src/gascaribe/ventas/procedimientos/ldc_pbldcrvp.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/ldc_pkfaac.sql"
@src/gascaribe/facturacion/paquetes/ldc_pkfaac.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/ldc_pkfapc.sql"
@src/gascaribe/facturacion/paquetes/ldc_pkfapc.sql

prompt "Aplicando src/gascaribe/ingenieria/paquetes/ldc_pkgestionacartasredes.sql"
@src/gascaribe/ingenieria/paquetes/ldc_pkgestionacartasredes.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/LDC_pkgestionAnulaVenta.sql"
@src/gascaribe/ventas/paquetes/LDC_pkgestionAnulaVenta.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/paquetes/LDC_PKGESTIONLEGORDCRI.sql"
@src/gascaribe/facturacion/reglas-critica/paquetes/LDC_PKGESTIONLEGORDCRI.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/ldc_pkggcma.sql"
@src/gascaribe/facturacion/paquetes/ldc_pkggcma.sql

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