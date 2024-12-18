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

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/paquete/ldc_pkgestiontaritran.sql"
@src/gascaribe/facturacion/tarifa_transitoria/paquete/ldc_pkgestiontaritran.sql

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIXTARITRAN.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIXTARITRAN.sql

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H1.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H1.sql

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H2.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H2.sql

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H3.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H3.sql

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H4.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H4.sql

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H5.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H5.sql

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H6.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H6.sql

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H7.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H7.sql

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H8.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H8.sql

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H9.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H9.sql

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H10.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H10.sql

prompt "Aplicando src/gascaribe/datafix/datafix_OSF-605.sql"
@src/gascaribe/datafix/datafix_OSF-605.sql


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