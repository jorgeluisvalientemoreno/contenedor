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

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_bocncrm.sql"
@src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_bocncrm.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_bocncrm.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_bocncrm.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/pkg_uicncrm.sql"
@src/gascaribe/atencion-usuarios/paquetes/pkg_uicncrm.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/pkg_uicncrm.sql"
@src/gascaribe/atencion-usuarios/sinonimos/pkg_uicncrm.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fwcea/info_facturacion_electronica.sql"
@src/gascaribe/atencion-usuarios/fwcea/info_facturacion_electronica.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fwcpi/CNCRM.sql"
@src/gascaribe/atencion-usuarios/fwcpi/CNCRM.sql

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