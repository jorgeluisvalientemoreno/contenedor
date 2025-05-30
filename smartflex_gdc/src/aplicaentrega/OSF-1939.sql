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

prompt "Aplicando src/gascaribe/facturacion/spool/tablas/personalizaciones.detalle_envio_fact_digital.sql"
@src/gascaribe/facturacion/spool/tablas/personalizaciones.detalle_envio_fact_digital.sql

prompt "Aplicando src/gascaribe/facturacion/spool/paquete/personalizaciones.pkg_detalle_envio_fact_digital.sql"
@src/gascaribe/facturacion/spool/paquete/personalizaciones.pkg_detalle_envio_fact_digital.sql

prompt "Aplicando src/gascaribe/facturacion/spool/sinonimos/personalizaciones.pkg_detalle_envio_fact_digital.sql"
@src/gascaribe/facturacion/spool/sinonimos/personalizaciones.pkg_detalle_envio_fact_digital.sql

prompt "Aplicando src/gascaribe/facturacion/spool/paquete/ldc_utilidades_fact.sql"
@src/gascaribe/facturacion/spool/paquete/ldc_utilidades_fact.sql

prompt "Aplicando src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolfac.pck"
@src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolfac.pck

prompt "Aplicando src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolatencli.pck"
@src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolatencli.pck

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/