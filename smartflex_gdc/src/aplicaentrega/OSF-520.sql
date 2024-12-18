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

prompt "Aplicando src/gascaribe/facturacion/spool/tablas/LDC_GRUPVIFA.sql"
@src/gascaribe/facturacion/spool/tablas/LDC_GRUPVIFA.sql

prompt "Aplicando src/gascaribe/facturacion/spool/tablas/LDC_CONCGRVF.sql"
@src/gascaribe/facturacion/spool/tablas/LDC_CONCGRVF.sql

prompt "Aplicando src/gascaribe/facturacion/spool/secuencia/SEQ_GRUPVIFA.sql"
@src/gascaribe/facturacion/spool/secuencia/SEQ_GRUPVIFA.sql

prompt "Aplicando src/gascaribe/facturacion/spool/framework/fwcea/LDC_GRUPVIFA.sql"
@src/gascaribe/facturacion/spool/framework/fwcea/LDC_GRUPVIFA.sql

prompt "Aplicando src/gascaribe/facturacion/spool/framework/fwcea/LDC_CONCGRVF.sql"
@src/gascaribe/facturacion/spool/framework/fwcea/LDC_CONCGRVF.sql

prompt "Aplicando src/gascaribe/facturacion/spool/framework/fwcmd/LDCCGVF.sql"
@src/gascaribe/facturacion/spool/framework/fwcmd/LDCCGVF.sql

prompt "Aplicando src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolfac.pck"
@src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolfac.pck

prompt "Aplicando src/gascaribe/datafix/OSF-520_configuracion.sql"
@src/gascaribe/datafix/OSF-520_configuracion.sql

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