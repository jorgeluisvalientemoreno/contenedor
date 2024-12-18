column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                  Aplicando Entrega OSF-2766                              "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "---------------- INICIA MIGRACION DE ESQUEMA -----------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------ 1.PAQUETE DALD_AGE_RANGE ------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_age_range.sql               "
@src/gascaribe/papelera-reciclaje/paquetes/dald_age_range.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.dage_entity.sql      "
@src/gascaribe/fnb/sinonimos/adm_person.dage_entity.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_age_range.sql       "
@src/gascaribe/fnb/sinonimos/adm_person.ld_age_range.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_age_range.sql     "
@src/gascaribe/fnb/paquetes/adm_person.dald_age_range.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_age_range.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_age_range.sql
show errors;

prompt "                                                                          " 
prompt "------------ 2.PAQUETE DALD_BINE_CENCOSUD --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_bine_cencosud.sql           "
@src/gascaribe/papelera-reciclaje/paquetes/dald_bine_cencosud.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_bine_cencosud.sql   "
@src/gascaribe/fnb/sinonimos/adm_person.ld_bine_cencosud.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_bine_cencosud.sql "
@src/gascaribe/fnb/paquetes/adm_person.dald_bine_cencosud.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_bine_cencosud.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_bine_cencosud.sql
show errors;

prompt "                                                                          " 
prompt "------------ 3.PAQUETE DALD_BLOCK_UNBLOCK_SH -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_block_unblock_sh.sql        "
@src/gascaribe/papelera-reciclaje/paquetes/dald_block_unblock_sh.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_block_unblock_sh.sql "
@src/gascaribe/fnb/sinonimos/adm_person.ld_block_unblock_sh.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_block_unblock_sh.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_block_unblock_sh.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_block_unblock_sh.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_block_unblock_sh.sql
show errors;

prompt "                                                                          " 
prompt "------------ 4.PAQUETE DALD_CANCEL_CAUSAL --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_cancel_causal.sql           "
@src/gascaribe/papelera-reciclaje/paquetes/dald_cancel_causal.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_cancel_causal.sql   "
@src/gascaribe/fnb/sinonimos/adm_person.ld_cancel_causal.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_cancel_causal.sql "
@src/gascaribe/fnb/paquetes/adm_person.dald_cancel_causal.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_cancel_causal.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_cancel_causal.sql
show errors;

prompt "                                                                          " 
prompt "------------ 5.PAQUETE DALD_CHA_STA_SUB_AUDI -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_cha_sta_sub_audi.sql        "
@src/gascaribe/papelera-reciclaje/paquetes/dald_cha_sta_sub_audi.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_cha_sta_sub_audi.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_cha_sta_sub_audi.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_cha_sta_sub_audi.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_cha_sta_sub_audi.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_cha_sta_sub_audi.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_cha_sta_sub_audi.sql
show errors;

prompt "                                                                          " 
prompt "------------ 6.PAQUETE DALD_COMMISSION -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_commission.sql              "
@src/gascaribe/papelera-reciclaje/paquetes/dald_commission.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_commission.sql      "
@src/gascaribe/fnb/sinonimos/adm_person.ld_commission.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.ge_bocatalog.sql     "
@src/gascaribe/fnb/sinonimos/adm_person.ge_bocatalog.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_commission.sql    "
@src/gascaribe/fnb/paquetes/adm_person.dald_commission.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_commission.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_commission.sql
show errors;

prompt "                                                                          " 
prompt "------------ 7.PAQUETE DALD_CON_UNI_BUDGET -------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_con_uni_budget.sql          "
@src/gascaribe/papelera-reciclaje/paquetes/dald_con_uni_budget.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_con_uni_budget.sql  "
@src/gascaribe/fnb/sinonimos/adm_person.ld_con_uni_budget.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_con_uni_budget.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_con_uni_budget.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_con_uni_budget.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_con_uni_budget.sql
show errors;

prompt "                                                                          " 
prompt "------------ 8.PAQUETE DALD_CONSE_HISTORIC_SALES -------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_conse_historic_sales.sql    "
@src/gascaribe/papelera-reciclaje/paquetes/dald_conse_historic_sales.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_conse_historic_sales.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_conse_historic_sales.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_conse_historic_sales.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_conse_historic_sales.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_conse_historic_sales.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_conse_historic_sales.sql
show errors;

prompt "                                                                          " 
prompt "------------ 9.PAQUETE DALD_CREDIT_BUREAU --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_credit_bureau.sql           "
@src/gascaribe/papelera-reciclaje/paquetes/dald_credit_bureau.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_credit_bureau.sql   "
@src/gascaribe/fnb/sinonimos/adm_person.ld_credit_bureau.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_credit_bureau.sql "
@src/gascaribe/fnb/paquetes/adm_person.dald_credit_bureau.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_credit_bureau.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_credit_bureau.sql
show errors;

prompt "                                                                          " 
prompt "------------ 10.PAQUETE DALD_CREG ----------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_creg.sql                    "
@src/gascaribe/papelera-reciclaje/paquetes/dald_creg.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_creg.sql            "
@src/gascaribe/facturacion/sinonimos/adm_person.ld_creg.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_creg.sql          "
@src/gascaribe/facturacion/paquetes/adm_person.dald_creg.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_creg.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.dald_creg.sql
show errors;

prompt "                                                                          " 
prompt "------------ 11.PAQUETE DALD_DEMAND_BUDGET -------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_demand_budget.sql           "
@src/gascaribe/papelera-reciclaje/paquetes/dald_demand_budget.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_demand_budget.sql   "
@src/gascaribe/fnb/sinonimos/adm_person.ld_demand_budget.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_demand_budget.sql "
@src/gascaribe/fnb/paquetes/adm_person.dald_demand_budget.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_demand_budget.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_demand_budget.sql
show errors;

prompt "                                                                          " 
prompt "------------ 12.PAQUETE DALD_DETA_EXTRA_QUOTA_FNB ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_deta_extra_quota_fnb.sql    "
@src/gascaribe/papelera-reciclaje/paquetes/dald_deta_extra_quota_fnb.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_deta_extra_quota_fnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_deta_extra_quota_fnb.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_deta_extra_quota_fnb.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_deta_extra_quota_fnb.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_deta_extra_quota_fnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_deta_extra_quota_fnb.sql
show errors;

prompt "                                                                          " 
prompt "------------ 13.PAQUETE DALD_DETAIL_LIQUI_SELLER -------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_detail_liqui_seller.sql     "
@src/gascaribe/papelera-reciclaje/paquetes/dald_detail_liqui_seller.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_detail_liqui_seller.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_detail_liqui_seller.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_detail_liqui_seller.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_detail_liqui_seller.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_detail_liqui_seller.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_detail_liqui_seller.sql
show errors;

prompt "                                                                          " 
prompt "------------ 14.PAQUETE DALD_EXEC_METH -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_exec_meth.sql               "
@src/gascaribe/papelera-reciclaje/paquetes/dald_exec_meth.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_exec_meth.sql       "
@src/gascaribe/general/sinonimos/adm_person.ld_exec_meth.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_exec_meth.sql     "
@src/gascaribe/general/paquetes/adm_person.dald_exec_meth.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_exec_meth.sql"
@src/gascaribe/general/sinonimos/adm_person.dald_exec_meth.sql
show errors;

prompt "                                                                          " 
prompt "------------ 15.PAQUETE DALD_EXTRA_QUOTA ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_extra_quota.sql             "
@src/gascaribe/papelera-reciclaje/paquetes/dald_extra_quota.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_extra_quota.sql     "
@src/gascaribe/fnb/sinonimos/adm_person.ld_extra_quota.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_extra_quota.sql   "
@src/gascaribe/fnb/paquetes/adm_person.dald_extra_quota.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_extra_quota.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_extra_quota.sql
show errors;

prompt "                                                                          " 
prompt "------------ 16.PAQUETE DALD_GENDER --------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_gender.sql                  "
@src/gascaribe/papelera-reciclaje/paquetes/dald_gender.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_gender.sql          "
@src/gascaribe/general/sinonimos/adm_person.ld_gender.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_gender.sql        "
@src/gascaribe/general/paquetes/adm_person.dald_gender.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_gender.sql"
@src/gascaribe/general/sinonimos/adm_person.dald_gender.sql
show errors;

prompt "                                                                          " 
prompt "------------ 17.PAQUETE DALD_GENERAL_AUDIACE -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_general_audiace.sql         "
@src/gascaribe/papelera-reciclaje/paquetes/dald_general_audiace.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_general_audiace.sql "
@src/gascaribe/general/sinonimos/adm_person.ld_general_audiace.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_general_audiace.sql"
@src/gascaribe/general/paquetes/adm_person.dald_general_audiace.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_general_audiace.sql"
@src/gascaribe/general/sinonimos/adm_person.dald_general_audiace.sql
show errors;

prompt "                                                                          " 
prompt "------------ 18.PAQUETE DALD_INCONS_FNB_EXITO ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_incons_fnb_exito.sql        "
@src/gascaribe/papelera-reciclaje/paquetes/dald_incons_fnb_exito.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_incons_fnb_exito.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_incons_fnb_exito.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_incons_fnb_exito.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_incons_fnb_exito.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_incons_fnb_exito.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_incons_fnb_exito.sql
show errors;

prompt "                                                                          " 
prompt "------------ 19.PAQUETE DALD_LIQUIDATION ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_liquidation.sql             "
@src/gascaribe/papelera-reciclaje/paquetes/dald_liquidation.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_liquidation.sql     "
@src/gascaribe/fnb/sinonimos/adm_person.ld_liquidation.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_liquidation.sql   "
@src/gascaribe/fnb/siniestros/adm_person.dald_liquidation.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_liquidation.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_liquidation.sql
show errors;

prompt "                                                                          " 
prompt "------------ 20.PAQUETE DALD_LIQUIDATION_SELLER --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_liquidation_seller.sql      "
@src/gascaribe/papelera-reciclaje/paquetes/dald_liquidation_seller.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_liquidation_seller.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_liquidation_seller.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.dald_liquidation_seller.sql"
@src/gascaribe/fnb/siniestros/adm_person.dald_liquidation_seller.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_liquidation_seller.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_liquidation_seller.sql
show errors;

prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------------ TERMINA MIGRACION DE ESQUEMA --------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          " 
prompt "------------ ACTUALIZAR REGISTRO MASTER_PERSONALIZACIONES ----------------" 
prompt "                                                                          "

prompt "--->Aplicando ingreso de objetos en MASTER_PERSONALIZACIONES              "
@src/gascaribe/datafix/OSF-2766_Actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2766                           "
prompt "--------------------------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso Aplica Entrega!!
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