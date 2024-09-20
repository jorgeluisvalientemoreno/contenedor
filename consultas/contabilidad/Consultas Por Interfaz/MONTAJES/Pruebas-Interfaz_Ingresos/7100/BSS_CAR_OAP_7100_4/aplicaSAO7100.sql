column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
spool &vdb._logSAO7100_&vdt..txt
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO7100');
prompt Inicio Proceso!!
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt " APLICANDO aplicaSAO7100.sql "
prompt "------------------------------------------------------"

prompt "Aplicando 7100/01_tb_LDCI_OIPRDGENERICO.sql"
@./7100/01_tb_LDCI_OIPRDGENERICO.sql

prompt "Aplicando 7100/02_param_LDC_ORDEN_INTERNA_PROD_GENE.sql"
@./7100/02_param_LDC_ORDEN_INTERNA_PROD_GENE.sql

prompt "Aplicando 7100/03_LDCI_OIPRDGENERICO.sql"
@./7100/03_LDCI_OIPRDGENERICO.sql

prompt "Aplicando 7100/04_LDCLCTOICL.sql"
@./7100/04_LDCLCTOICL.sql

prompt "Aplicando 7100/05_LDCI_PKINTERFAZSAP.pkg"
@./7100/05_LDCI_PKINTERFAZSAP.pkg

prompt "Aplicando 7100/06_ins_Sa_tab.sql"
@./7100/06_ins_Sa_tab.sql

prompt "Aplicando 7100/09_ge_database_version.sql"
@./7100/09_ge_database_version.sql

prompt "------------------------------------------------------"
prompt " FIN DE APLICA aplicaSAO7100.sql "
prompt "------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
spool off
