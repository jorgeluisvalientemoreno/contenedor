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

prompt "Aplicando src/gascaribe/ventas/lista_valores_planes/tablas/LDC_TIPSOLPLANCOMERCIAL.sql"
@src/gascaribe/ventas/lista_valores_planes/tablas/LDC_TIPSOLPLANCOMERCIAL.sql

prompt "src/gascaribe/ventas/lista_valores_planes/tablas/LDC_TIPSOLPLANFINAN.sql"
@src/gascaribe/ventas/lista_valores_planes/tablas/LDC_TIPSOLPLANFINAN.sql

prompt "Aplicando src/gascaribe/ventas/lista_valores_planes/fwcea/LDC_TIPSOLPLANCOMERCIAL.sql"
@src/gascaribe/ventas/lista_valores_planes/fwcea/LDC_TIPSOLPLANCOMERCIAL.sql

prompt "Aplicando src/gascaribe/ventas/lista_valores_planes/fwcea/LDC_TIPSOLPLANFINAN.sql"
@src/gascaribe/ventas/lista_valores_planes/fwcea/LDC_TIPSOLPLANFINAN.sql

prompt "Aplicando src/gascaribe/ventas/lista_valores_planes/trigger/TRG_INSUPD_TIPSOLPLANCOMERCIAL.sql"
@src/gascaribe/ventas/lista_valores_planes/trigger/TRG_INSUPD_TIPSOLPLANCOMERCIAL.sql

prompt "Aplicando src/gascaribe/ventas/lista_valores_planes/trigger/TRG_INSUPD_TIPSOLPLANFINAN.sql"
@src/gascaribe/ventas/lista_valores_planes/trigger/TRG_INSUPD_TIPSOLPLANFINAN.sql

prompt "Aplicando src/gascaribe/ventas/lista_valores_planes/fwcmd/LDCTIPSOLPLANES.sql"
@src/gascaribe/ventas/lista_valores_planes/fwcmd/LDCTIPSOLPLANES.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_271.sql"
@src/gascaribe/tramites/ps_package_type_271.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_100229.sql"
@src/gascaribe/tramites/ps_package_type_100229.sql

prompt "Aplicando src/gascaribe/datafix/data_ldc_tipsolplancomercial.sql"
@src/gascaribe/datafix/data_ldc_tipsolplancomercial.sql

prompt "Aplicando src/gascaribe/datafix/data_ldc_tipsolplanfinan.sql"
@src/gascaribe/datafix/data_ldc_tipsolplanfinan.sql

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