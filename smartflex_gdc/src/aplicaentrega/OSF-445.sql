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

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/COD_SOL_EST_REGISTRADA_100225.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/COD_SOL_EST_REGISTRADA_100225.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/funcion/LDC_VAL_SOL_EST_REG_100225.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/funcion/LDC_VAL_SOL_EST_REG_100225.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/fwcob/GE_OBJECT_121657.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/fwcob/GE_OBJECT_121657.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_100225.sql"
@src/gascaribe/tramites/ps_package_type_100225.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/permisos/permisos_445.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/permisos/permisos_445.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/dataversion/ge_database_version_445.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/dataversion/ge_database_version_445.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/dataversion/version_445.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/dataversion/version_445.sql

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