column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/atencion-usuarios/valor-reclamo/parametros/parametros.sql"
@src/gascaribe/atencion-usuarios/valor-reclamo/parametros/parametros.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_100335.sql"
@src/gascaribe/tramites/ps_package_type_100335.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_100337.sql"
@src/gascaribe/tramites/ps_package_type_100337.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_100338.sql"
@src/gascaribe/tramites/ps_package_type_100338.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/valor-reclamo/procedimiento/LDC_PRCLIENTERECLAMO.prc"
@src/gascaribe/atencion-usuarios/valor-reclamo/procedimiento/LDC_PRCLIENTERECLAMO.prc

prompt "Aplicando src/gascaribe/atencion-usuarios/valor-reclamo/giras/SINCECOMP_VALORECLAMO.sql"
@src/gascaribe/atencion-usuarios/valor-reclamo/giras/SINCECOMP_VALORECLAMO.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/valor-reclamo/permisos/permisos.sql"
@src/gascaribe/atencion-usuarios/valor-reclamo/permisos/permisos.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/valor-reclamo/dataversion/ge_database_version_96.sql"
@src/gascaribe/atencion-usuarios/valor-reclamo/dataversion/ge_database_version_96.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/valor-reclamo/dataversion/version_96.sql"
@src/gascaribe/atencion-usuarios/valor-reclamo/dataversion/version_96.sql

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