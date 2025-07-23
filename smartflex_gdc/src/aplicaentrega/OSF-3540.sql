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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_calendar.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_calendar.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ldc_validgenaudprevias.sql"
@src/gascaribe/objetos-producto/sinonimos/ldc_validgenaudprevias.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/cocoprci.sql"
@src/gascaribe/objetos-producto/sinonimos/cocoprci.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/procesos.sql"
@src/gascaribe/objetos-producto/sinonimos/procesos.sql

prompt "Aplicando src/gascaribe/facturacion/parametros/dias_retraso_fgca.sql"
@src/gascaribe/facturacion/parametros/dias_retraso_fgca.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcldcgcam.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcldcgcam.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_boldcgcam.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_boldcgcam.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_bcldcgcam.sql"
@src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_bcldcgcam.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_boldcgcam.sql"
@src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_boldcgcam.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/pkg_uildcgcam.sql"
@src/gascaribe/facturacion/paquetes/pkg_uildcgcam.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/pkg_uildcgcam.sql"
@src/gascaribe/facturacion/sinonimos/pkg_uildcgcam.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/ldc_pkggcma.sql"
@src/gascaribe/facturacion/paquetes/ldc_pkggcma.sql

prompt "Aplicando src/gascaribe/facturacion/fwcpb/ldcgcam.sql"
@src/gascaribe/facturacion/fwcpb/ldcgcam.sql

prompt "Aplicando src/gascaribe/facturacion/fwcob/ge_object_121779.sql"
@src/gascaribe/facturacion/fwcob/ge_object_121779.sql




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