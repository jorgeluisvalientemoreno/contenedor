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

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/parametros/ciclo_mostrar_infoformapago.sql"
@src/gascaribe/facturacion/facturacion_electronica/parametros/ciclo_mostrar_infoformapago.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/parametros/forma_pago_opcional81.sql"
@src/gascaribe/facturacion/facturacion_electronica/parametros/forma_pago_opcional81.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_bcfactuelectronicagen.sql"
@src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_bcfactuelectronicagen.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_bofactuelectronicagen.sql"
@src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_bofactuelectronicagen.sql

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