column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2743"
prompt "-----------------"

prompt "-----paquete DALDC_ACTBLOQ-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_actbloq.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_actbloq.sql


prompt "-----paquete DALDC_ANALISIS_DE_CONSUMO -----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_analisis_de_consumo.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_analisis_de_consumo.sql


prompt "-----paquete DALD_NOTIFICATION-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_notification.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_notification.sql


prompt "-----paquete DALD_PROD_LINE_GE_CONT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_prod_line_ge_cont.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_prod_line_ge_cont.sql


prompt "-----paquete DALD_REL_MAR_GEO_LOC-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_rel_mar_geo_loc.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_rel_mar_geo_loc.sql


prompt "-----paquete DALD_REL_MARK_BUDGET-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_rel_mark_budget.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_rel_mark_budget.sql


prompt "-----paquete DALD_REL_MARKET_RATE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_rel_market_rate.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_rel_market_rate.sql


prompt "-----paquete DALD_RESOL_CONS_UNIT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_resol_cons_unit.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_resol_cons_unit.sql


prompt "-----paquete DALD_SEGMEN_SUPPLIER-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_segmen_supplier.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_segmen_supplier.sql


prompt "-----paquete DALD_SEGMENT_CATEG-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_segment_categ.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_segment_categ.sql


prompt "-----paquete DALD_SHOPKEEPER-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_shopkeeper.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_shopkeeper.sql


prompt "-----paquete DALD_SUPPLI_MODIFICA_DATE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_suppli_modifica_date.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_suppli_modifica_date.sql


prompt "-----paquete DALD_ZON_ASSIG_VALID-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_zon_assig_valid.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_zon_assig_valid.sql


prompt "-----paquete DALDC_BUDGET-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_budget.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_budget.sql


prompt "-----paquete DALDC_BUDGETBYPROVIDER-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_budgetbyprovider.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_budgetbyprovider.sql


prompt "-----paquete DALD_POLICY_STATE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_policy_state.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_policy_state.sql


prompt "-----paquete DALD_RENEWALL_SECURP-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_renewall_securp.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_renewall_securp.sql


prompt "-----paquete DALD_REP_INCO_SUB-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_rep_inco_sub.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_rep_inco_sub.sql


prompt "-----paquete DALDC_ARCHASOBANC-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_archasobanc.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_archasobanc.sql


prompt "-----paquete DALDC_ATRIASOBANC-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_atriasobanc.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_atriasobanc.sql


prompt "-----Script OSF-2743_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2743_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2743-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on

prompt "-----RECOMPILAR OBJETOS-----"
prompt "--->Aplicando recompilar objetos"
@src/test/recompilar-objetos.sql
show errors;
