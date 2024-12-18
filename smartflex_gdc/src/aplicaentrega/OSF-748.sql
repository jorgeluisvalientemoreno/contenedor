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

prompt "Aplicando src/gascaribe/facturacion/notificaciones/parametros/mrgld_parameterLDC_EMAILNOCONSREC.sql"
@src/gascaribe/facturacion/notificaciones/parametros/mrgld_parameterLDC_EMAILNOCONSREC.sql

prompt "Aplicando src/gascaribe/facturacion/notificaciones/parametros/mrgld_parameterLDC_TOPENOTICR.sql"
@src/gascaribe/facturacion/notificaciones/parametros/mrgld_parameterLDC_TOPENOTICR.sql

prompt "Aplicando src/gascaribe/facturacion/notificaciones/paquetes/LDC_BONOTYCONSREC.sql"
@src/gascaribe/facturacion/notificaciones/paquetes/LDC_BONOTYCONSREC.sql

--prompt "Aplicando src/gascaribe/facturacion/notificaciones/triggers/LDC_TRGNOTITERMPROC.trg"
--@src/gascaribe/facturacion/notificaciones/triggers/LDC_TRGNOTITERMPROC.trg

--prompt "Aplicando src/gascaribe/tarifa_transitoria/notificaciones/paquete/ldc_pkgestiontaritran.sql"
--@src/gascaribe/facturacion/tarifa_transitoria/paquete/ldc_pkgestiontaritran.sql

prompt "Aplicando src/gascaribe/datafix/OSF-748_Job_GENNOTICONSREC.sql"
@src/gascaribe/datafix/OSF-748_Job_GENNOTICONSREC.sql

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