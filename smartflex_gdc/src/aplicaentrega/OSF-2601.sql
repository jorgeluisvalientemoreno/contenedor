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

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/tgr_bu_ldci_transoma.sql"
@src/gascaribe/papelera-reciclaje/triggers/tgr_bu_ldci_transoma.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_valid_plan_comer.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_valid_plan_comer.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_valid_pr_product.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_valid_pr_product.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgiurld_shopkeeper.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgiurld_shopkeeper.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2601_ActSa_Executable_ldctv.sql"
@src/gascaribe/datafix/OSF-2601_ActSa_Executable_ldctv.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaimo_executor_log_mot.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaimo_executor_log_mot.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_article.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_article.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_line.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_line.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiurld_price_list.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiurld_price_list.sql


prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on

prompt "                                                                          "
prompt "---------------------------RECOMPILAR OBJETOS-----------------------------"
prompt "                                                                          "

prompt "--->Aplicando recompilar objetos"
@src/test/recompilar-objetos.sql
show errors;
quit
/