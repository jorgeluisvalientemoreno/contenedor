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

prompt "Aplicando src/gascaribe/fnb/fwcpb/ldc_difeapm.sql"
@src/gascaribe/fnb/fwcpb/ldc_difeapm.sql

prompt "Aplicando src/gascaribe/fnb/procedimientos/ldc_difeapm.sql"
@src/gascaribe/fnb/procedimientos/ldc_difeapm.sql

prompt "Aplicando src/gascaribe/fnb/procedimientos/ldc_pasadifeapmplano.sql"
@src/gascaribe/fnb/procedimientos/ldc_pasadifeapmplano.sql

prompt "Aplicando src/gascaribe/Permisos/permisos_684.sql"
@src/gascaribe/Permisos/permisos_684.sql

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