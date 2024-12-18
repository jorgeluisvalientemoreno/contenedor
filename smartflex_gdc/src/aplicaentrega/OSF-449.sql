column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO TRG_RESTRICT_CXC_CERTIFICADO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"
prompt "Aplicando @src/gascaribe/facturacion/tarifa_transitoria/paquete/ldc_pkgestiontaritran.sql"
@src/gascaribe/facturacion/tarifa_transitoria/paquete/ldc_pkgestiontaritran.sql

prompt "Aplicando @src/gascaribe/facturacion/tarifa_transitoria/sql/reversion_tarifatran.sql"
@src/gascaribe/facturacion/tarifa_transitoria/sql/reversion_tarifatran.sql
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