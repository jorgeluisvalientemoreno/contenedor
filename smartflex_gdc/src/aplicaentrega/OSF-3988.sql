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

prompt "Aplicando src/gascaribe/multiempresa/tablas/multiempresa.base_admin.sql"
@src/gascaribe/multiempresa/tablas/multiempresa.base_admin.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.base_admin.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.base_admin.sql

prompt "Aplicando src/gascaribe/multiempresa/paquetes/multiempresa.pkg_base_admin.sql"
@src/gascaribe/multiempresa/paquetes/multiempresa.pkg_base_admin.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_base_admin.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_base_admin.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3988_ins_base_admin.sql"
@src/gascaribe/datafix/OSF-3988_ins_base_admin.sql

prompt "Aplicando src/gascaribe/multiempresa/triggers/multiempresa.trg_or_oper_uni_val_empresa.sql"
@src/gascaribe/multiempresa/triggers/multiempresa.trg_or_oper_uni_val_empresa.sql

prompt "Aplicando src/gascaribe/multiempresa/triggers/multiempresa.trg_ge_items_doc_val_empresas.sql"
@src/gascaribe/multiempresa/triggers/multiempresa.trg_ge_items_doc_val_empresas.sql

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