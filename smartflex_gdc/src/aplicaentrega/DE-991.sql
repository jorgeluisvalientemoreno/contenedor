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

prompt "Aplicando src/gascaribe/de/tables"
@src/gascaribe/de/tables/ldcbi_ab_info_premise.sql
@src/gascaribe/de/tables/ldcbi_fm_preinvoice_pno.sql
@src/gascaribe/de/tables/ldcbi_ge_subs_housing_data.sql
@src/gascaribe/de/tables/ldcbi_ge_subs_work_relat.sql

prompt "Aplicando src/gascaribe/de/triggers"
@src/gascaribe/de/trigger/trg_de_ab_info_premise.sql
@src/gascaribe/de/trigger/trg_de_fm_preinvoice_pno.sql
@src/gascaribe/de/trigger/trg_de_ge_subs_housing_data.sql
@src/gascaribe/de/trigger/trg_de_ge_subs_work_relat.sql

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