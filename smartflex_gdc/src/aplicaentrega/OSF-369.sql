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

prompt "Aplicando src/gascaribe/revision-periodica/LDC_FNUCUENTASSALDOSPRODUCTO.sql"
@src/gascaribe/revision-periodica/LDC_FNUCUENTASSALDOSPRODUCTO.sql

prompt "Aplicando src/gascaribe/revision-periodica/LDC_PRCUENTASSALDOSCONTRATO.sql"
@src/gascaribe/revision-periodica/LDC_PRCUENTASSALDOSCONTRATO.sql

prompt "Aplicando src/gascaribe/revision-periodica/ldcvalproductparamarcado.sql"
@src/gascaribe/revision-periodica/ldcvalproductparamarcado.sql

prompt "Aplicando src/gascaribe/revision-periodica/ldcvalproducttramitereco.sql"
@src/gascaribe/revision-periodica/ldcvalproducttramitereco.sql

prompt "Aplicando src/gascaribe/fwcob/GE_OBJECT_121746.sql"
@src/gascaribe/fwcob/GE_OBJECT_121746.sql

prompt "Aplicando src/gascaribe/tramites/PS_PACKAGE_TYPE_100306.sql"
@src/gascaribe/tramites/PS_PACKAGE_TYPE_100306.sql

prompt "Aplicando src/gascaribe/PermisosS/permisos_369.sql"
@src/gascaribe/Permisos/permisos_369.sql

prompt "Aplicando src/gascaribe/dataversion/ge_database_version_369.sql"
@src/gascaribe/dataversion/ge_database_version_369.sql

prompt "Aplicando src/gascaribe/dataversion/version_369.sql"
@src/gascaribe/dataversion/version_369.sql

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