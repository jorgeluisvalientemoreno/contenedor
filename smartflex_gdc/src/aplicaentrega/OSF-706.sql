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

prompt "Aplicando src/gascaribe/revision-periodica/suspension/paquetes/ldc_bo_gestionsuspseg.sql"
@src/gascaribe/revision-periodica/suspension/paquetes/ldc_bo_gestionsuspseg.sql

prompt "Aplicando src/gascaribe/revision-periodica/parametros/acti_ya_susp_ac.sql"
@src/gascaribe/revision-periodica/parametros/acti_ya_susp_ac.sql

prompt "Aplicando src/gascaribe/revision-periodica/parametros/acti_ya_susp_cm.sql"
@src/gascaribe/revision-periodica/parametros/acti_ya_susp_cm.sql

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