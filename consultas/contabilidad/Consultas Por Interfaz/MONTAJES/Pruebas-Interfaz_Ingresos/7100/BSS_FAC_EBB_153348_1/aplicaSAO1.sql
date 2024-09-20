column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
spool &vdb._logSAO1_&vdt..txt
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO1');
prompt Inicio Proceso!!
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt " APLICANDO aplicaSAO1.sql "
prompt "------------------------------------------------------"

prompt "Aplicando ARA_153348/OBJETOS/1Ara153348.sql"
@./ARA_153348/OBJETOS/1Ara153348.sql

prompt "Aplicando ARA_153348/OBJETOS/2ge_database_version.sql"
@./ARA_153348/OBJETOS/2ge_database_version.sql
commit;
prompt "------------------------------------------------------"
prompt " FIN DE APLICA aplicaSAO1.sql "
prompt "------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
spool off
