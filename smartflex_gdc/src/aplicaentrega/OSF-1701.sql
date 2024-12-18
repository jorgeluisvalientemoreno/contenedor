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

prompt "Aplicando src/gascaribe/general/tablas/datos/homologacion_servicios_fsbgetaddress_parsed.sql"
@src/gascaribe/general/tablas/datos/homologacion_servicios_fsbgetaddress_parsed.sql

prompt "Aplicando src/gascaribe/general/tablas/datos/homologacion_servicios_fnugetgeo_loca_father_id.sql"
@src/gascaribe/general/tablas/datos/homologacion_servicios_fnugetgeo_loca_father_id.sql

prompt "Aplicando src/gascaribe/facturacion/spool/paquete/ldc_pkgprocrevperfact.sql"
@src/gascaribe/facturacion/spool/paquete/ldc_pkgprocrevperfact.sql

prompt "Aplicando src/gascaribe/facturacion/spool/sinonimos/ldc_pkgprocrevperfact.sql"
@src/gascaribe/facturacion/spool/sinonimos/ldc_pkgprocrevperfact.sql

prompt "Aplicando src/gascaribe/facturacion/spool/paquete/ldc_pkgosffacture.sql"
@src/gascaribe/facturacion/spool/paquete/ldc_pkgosffacture.sql

prompt "Aplicando src/gascaribe/facturacion/spool/sinonimos/ldc_pkgosffacture.sql"
@src/gascaribe/facturacion/spool/sinonimos/ldc_pkgosffacture.sql


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