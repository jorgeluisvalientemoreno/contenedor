column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2767"
prompt "-----------------"

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquetes adm_person.dage_entity.sql"
@src/gascaribe/general/sinonimos/adm_person.dage_entity.sql

prompt "-----paquete DALD_PRICE_LIST_DEHI-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_price_list_dehi.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_price_list_dehi.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_price_list_dehi.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_price_list_dehi.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_price_list_dehi.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_price_list_dehi.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_price_list_dehi.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_price_list_dehi.sql


prompt "-----paquete DALD_PROMISSORY_PU-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_promissory_pu.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_promissory_pu.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_promissory_pu.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_promissory_pu.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_promissory_pu.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_promissory_pu.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_promissory_pu.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_promissory_pu.sql


prompt "-----paquete DALD_PROPERT_BY_ARTICLE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_propert_by_article.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_propert_by_article.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_propert_by_article.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_propert_by_article.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_propert_by_article.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_propert_by_article.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_propert_by_article.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_propert_by_article.sql


prompt "-----paquete DALD_PROPERTY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_property.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_property.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_property.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_property.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_property.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_property.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_property.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_property.sql


prompt "-----paquete DALD_RELEVANT_MARKET-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_relevant_market.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_relevant_market.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_relevant_market.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_relevant_market.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_relevant_market.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_relevant_market.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_relevant_market.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_relevant_market.sql


prompt "-----paquete DALD_RESULT_CONSULT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_result_consult.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_result_consult.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_result_consult.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_result_consult.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_result_consult.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_result_consult.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_result_consult.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_result_consult.sql


prompt "-----paquete DALD_REV_SUB_AUDIT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_rev_sub_audit.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_rev_sub_audit.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_rev_sub_audit.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_rev_sub_audit.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_rev_sub_audit.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_rev_sub_audit.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_rev_sub_audit.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_rev_sub_audit.sql


prompt "-----paquete DALD_SALES_VISIT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_sales_visit.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_sales_visit.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_sales_visit.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_sales_visit.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_sales_visit.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_sales_visit.sql


prompt "-----paquete DALD_SAMPLE_CONT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_sample_cont.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_sample_cont.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_sample_cont.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_sample_cont.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_sample_cont.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_sample_cont.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_sample_cont.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_sample_cont.sql


prompt "-----paquete DALD_SAMPLE_DETAI-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_sample_detai.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_sample_detai.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_sample_detai.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_sample_detai.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_sample_detai.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_sample_detai.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_sample_detai.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_sample_detai.sql


prompt "-----paquete DALD_SAMPLE_FIN-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_sample_fin.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_sample_fin.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_sample_fin.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_sample_fin.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_sample_fin.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_sample_fin.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_sample_fin.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_sample_fin.sql


prompt "-----paquete DALD_SERVICE_BUDGET-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_service_budget.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_service_budget.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_service_budget.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_service_budget.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_service_budget.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_service_budget.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_service_budget.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_service_budget.sql


prompt "-----paquete DALD_SUB_REMAIN_DELIV-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_sub_remain_deliv.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_sub_remain_deliv.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_sub_remain_deliv.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_sub_remain_deliv.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_sub_remain_deliv.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_sub_remain_deliv.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_sub_remain_deliv.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_sub_remain_deliv.sql


prompt "-----paquete DALD_TMP_MAX_RECOVERY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_tmp_max_recovery.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_tmp_max_recovery.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_tmp_max_recovery.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_tmp_max_recovery.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_tmp_max_recovery.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_tmp_max_recovery.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_tmp_max_recovery.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_tmp_max_recovery.sql


prompt "-----paquete DALD_SECURE_CANCELLA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_secure_cancella.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_secure_cancella.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_secure_cancella.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_secure_cancella.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_secure_cancella.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_secure_cancella.sql


prompt "-----paquete DALD_SUBSIDY_CONCEPT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_subsidy_concept.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_subsidy_concept.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_subsidy_concept.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_subsidy_concept.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_subsidy_concept.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_subsidy_concept.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_subsidy_concept.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_subsidy_concept.sql


prompt "-----paquete DALD_SUBSIDY_STATES-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_subsidy_states.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_subsidy_states.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_subsidy_states.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_subsidy_states.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_subsidy_states.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_subsidy_states.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_subsidy_states.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_subsidy_states.sql


prompt "-----paquete DALD_SINESTER_CLAIMS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_sinester_claims.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_sinester_claims.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_sinester_claims.sql"
@src/gascaribe/fnb/siniestros/sinonimos/adm_person.ld_sinester_claims.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_sinester_claims.sql"
@src/gascaribe/fnb/siniestros/paquetes/adm_person.dald_sinester_claims.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_sinester_claims.sql"
@src/gascaribe/fnb/siniestros/sinonimos/adm_person.dald_sinester_claims.sql


prompt "-----paquete DALD_MOVE_SUB-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_move_sub.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_move_sub.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_move_sub.sql"
@src/gascaribe/general/sinonimos/adm_person.ld_move_sub.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_move_sub.sql"
@src/gascaribe/general/paquetes/adm_person.dald_move_sub.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_move_sub.sql"
@src/gascaribe/general/sinonimos/adm_person.dald_move_sub.sql


prompt "-----paquete DALD_ORDER_CONS_UNIT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dald_order_cons_unit.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_order_cons_unit.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_order_cons_unit.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ld_order_cons_unit.sql

prompt "--->Aplicando creacion de paquete adm_person.dald_order_cons_unit.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.dald_order_cons_unit.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dald_order_cons_unit.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.dald_order_cons_unit.sql


prompt "-----Script OSF-2767_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2767_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2767-----"
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
