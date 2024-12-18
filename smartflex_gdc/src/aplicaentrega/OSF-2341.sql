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

prompt "Aplicando src/gascaribe/autoreconectados/tablas/altldc_proceso.sql"
@src/gascaribe/autoreconectados/tablas/altldc_proceso.sql

prompt "Aplicando src/gascaribe/autoreconectados/fwcea/ldc_proceso.sql"
@src/gascaribe/autoreconectados/fwcea/ldc_proceso.sql

prompt "Aplicando src/gascaribe/autoreconectados/fwcmd/ldccap.sql"
@src/gascaribe/autoreconectados/fwcmd/ldccap.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/ldc_pkgeneordeautoreco.sql"
@src/gascaribe/revision-periodica/paquetes/ldc_pkgeneordeautoreco.sql

prompt "Aplicando src/gascaribe/objetos-producto/permisos/ldc_pkgeneordeautoreco.sql"
@src/gascaribe/objetos-producto/permisos/ldc_pkgeneordeautoreco.sql

prompt "Aplicando src/gascaribe/revision-periodica/procedimientos/persca.sql"
@src/gascaribe/revision-periodica/procedimientos/persca.sql

prompt "Aplicando src/gascaribe/revision-periodica/procedimientos/ldc_propersecusion.sql"
@src/gascaribe/revision-periodica/procedimientos/ldc_propersecusion.sql

prompt "Aplicando src/gascaribe/autoreconectados/fwcob/ge_object_121762.sql"
@src/gascaribe/autoreconectados/fwcob/ge_object_121762.sql


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