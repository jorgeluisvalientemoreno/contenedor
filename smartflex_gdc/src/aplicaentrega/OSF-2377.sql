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

prompt "Aplicando src/gascaribe/general/homologacion_servicios/or_boconstants_csbno.sql"
@src/gascaribe/general/homologacion_servicios/or_boconstants_csbno.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.pkg_estaproc.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_estaproc.sql

prompt "Aplicando src/gascaribe/facturacion/spool/paquete/ldc_pkgnotperservaso.sql"
@src/gascaribe/facturacion/spool/paquete/ldc_pkgnotperservaso.sql

prompt "Aplicando src/gascaribe/fnb/seguros/paquetes/ldc_seguros.sql"
@src/gascaribe/fnb/seguros/paquetes/ldc_seguros.sql

prompt "Aplicando src/gascaribe/flujos/paquetes/ldc_wf_sendactivities.sql"
@src/gascaribe/flujos/paquetes/ldc_wf_sendactivities.sql

prompt "Aplicando src/gascaribe/fnb/seguros/procedimientos/procrenew.sql"
@src/gascaribe/fnb/seguros/procedimientos/procrenew.sql

prompt "Aplicando src/gascaribe/contratacion/paquetes/ldc_archtipo_lista.sql"
@src/gascaribe/contratacion/paquetes/ldc_archtipo_lista.sql

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