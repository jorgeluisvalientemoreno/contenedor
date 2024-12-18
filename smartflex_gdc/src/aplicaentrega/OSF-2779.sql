column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                  Aplicando Entrega OSF-2779                              "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "---------------- INICIA MIGRACION DE ESQUEMA -----------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------ 1.PAQUETE DALD_ADITIONAL_FNB_INFO ---------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_aditional_fnb_info.sql "
@src/gascaribe/papelera-reciclaje/paquetes/dald_aditional_fnb_info.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_aditional_fnb_info.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_aditional_fnb_info.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_aditional_fnb_info.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_aditional_fnb_info.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_aditional_fnb_info.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_aditional_fnb_info.sql
show errors;

prompt "                                                                          " 
prompt "------------ 2.PAQUETE DALD_CREDIT_QUOTA ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_credit_quota.sql      "
@src/gascaribe/papelera-reciclaje/paquetes/dald_credit_quota.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_credit_quota.sql    "
@src/gascaribe/fnb/sinonimos/adm_person.ld_credit_quota.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_credit_quota.sql  "
@src/gascaribe/fnb/paquetes/adm_person.dald_credit_quota.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_credit_quota.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_credit_quota.sql
show errors;

prompt "                                                                          " 
prompt "------------ 3.PAQUETE DALD_DIS_EXP_BUDGET -------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_dis_exp_budget.sql    "
@src/gascaribe/papelera-reciclaje/paquetes/dald_dis_exp_budget.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_dis_exp_budget.sql"
@src/gascaribe/general/paquetes/adm_person.dald_dis_exp_budget.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_dis_exp_budget.sql"
@src/gascaribe/general/sinonimos/adm_person.dald_dis_exp_budget.sql
show errors;

prompt "                                                                          " 
prompt "------------ 4.PAQUETE DALD_EFFECTIVE_STATE ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_effective_state.sql   "
@src/gascaribe/papelera-reciclaje/paquetes/dald_effective_state.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_effective_state.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_effective_state.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_effective_state.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_effective_state.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_effective_state.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_effective_state.sql
show errors;

prompt "                                                                          " 
prompt "------------ 5.PAQUETE DALD_EXTRA_QUOTA_FNB ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_extra_quota_fnb.sql   "
@src/gascaribe/papelera-reciclaje/paquetes/dald_extra_quota_fnb.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_extra_quota_fnb.sql "
@src/gascaribe/fnb/sinonimos/adm_person.ld_extra_quota_fnb.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_extra_quota_fnb.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_extra_quota_fnb.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_extra_quota_fnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_extra_quota_fnb.sql
show errors;

prompt "                                                                          " 
prompt "------------ 6.PAQUETE DALD_MANUAL_QUOTA ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_manual_quota.sql      "
@src/gascaribe/papelera-reciclaje/paquetes/dald_manual_quota.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_manual_quota.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_manual_quota.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_manual_quota.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_manual_quota.sql
show errors;

prompt "                                                                          " 
prompt "------------ 7.PAQUETE DALD_MAX_RECOVERY ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_max_recovery.sql      "
@src/gascaribe/papelera-reciclaje/paquetes/dald_max_recovery.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_max_recovery.sql    "
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_max_recovery.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_max_recovery.sql  "
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_max_recovery.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_max_recovery.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_max_recovery.sql
show errors;

prompt "                                                                          " 
prompt "------------ 8.PAQUETE DALD_NON_BAN_FI_ITEM ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_non_ban_fi_item.sql         "
@src/gascaribe/papelera-reciclaje/paquetes/dald_non_ban_fi_item.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_non_ban_fi_item.sql "
@src/gascaribe/fnb/sinonimos/adm_person.ld_non_ban_fi_item.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_non_ban_fi_item.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_non_ban_fi_item.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.dald_non_ban_fi_item.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_non_ban_fi_item.sql
show errors;

prompt "                                                                          " 
prompt "------------ 9.PAQUETE DALD_POLICY_BY_CRED_QUOT --------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N dald_policy_by_cred_quot.sql     "
@src/gascaribe/papelera-reciclaje/paquetes/dald_policy_by_cred_quot.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_policy_by_cred_quot.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_policy_by_cred_quot.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_policy_by_cred_quot.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_policy_by_cred_quot.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_policy_by_cred_quot.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_policy_by_cred_quot.sql
show errors;

prompt "                                                                          " 
prompt "------------ 10.PAQUETE DALD_POLICY_HISTORIC -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_policy_historic.sql   "
@src/gascaribe/papelera-reciclaje/paquetes/dald_policy_historic.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_policy_historic.sql "
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_policy_historic.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_policy_historic.sql "
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_policy_historic.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_policy_historic.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_policy_historic.sql
show errors;

prompt "                                                                          " 
prompt "------------ 11.PAQUETE DALD_POLICY_TYPE ---.-----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_policy_type.sql       "
@src/gascaribe/papelera-reciclaje/paquetes/dald_policy_type.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_policy_type.sql     "
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_policy_type.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_policy_type.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_policy_type.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_policy_type.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_policy_type.sql
show errors;

prompt "                                                                          " 
prompt "------------ 12.PAQUETE DALD_POS_SETTINGS --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_pos_settings.sql      "
@src/gascaribe/papelera-reciclaje/paquetes/dald_pos_settings.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_pos_settings.sql    "
@src/gascaribe/fnb/sinonimos/adm_person.ld_pos_settings.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_pos_settings.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_pos_settings.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_pos_settings.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_pos_settings.sql
show errors;

prompt "                                                                          " 
prompt "------------ 13.PAQUETE DALD_PRICE_LIST_DETA -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_price_list_deta.sql   "
@src/gascaribe/papelera-reciclaje/paquetes/dald_price_list_deta.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_price_list_deta.sql "
@src/gascaribe/fnb/sinonimos/adm_person.ld_price_list_deta.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_price_list_deta.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_price_list_deta.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_price_list_deta.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_price_list_deta.sql
show errors;

prompt "                                                                          " 
prompt "------------ 14.PAQUETE DALD_PRODUCT_LINE --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_product_line.sql      "
@src/gascaribe/papelera-reciclaje/paquetes/dald_product_line.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_product_line.sql    "
@src/gascaribe/fnb/sinonimos/adm_person.ld_product_line.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_product_line.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_product_line.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_product_line.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_product_line.sql
show errors;

prompt "                                                                          " 
prompt "------------ 15.PAQUETE DALD_QUOTA_ASSIGN_POLICY -------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_quota_assign_policy.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_quota_assign_policy.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_quota_assign_policy.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_quota_assign_policy.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_quota_assign_policy.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_quota_assign_policy.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_quota_assign_policy.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_quota_assign_policy.sql
show errors;

prompt "                                                                          " 
prompt "------------ 16.PAQUETE DALD_RETURN_ITEM ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_return_item.sql       "
@src/gascaribe/papelera-reciclaje/paquetes/dald_return_item.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_return_item.sql     "
@src/gascaribe/fnb/sinonimos/adm_person.ld_return_item.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_return_item.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_return_item.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_return_item.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_return_item.sql
show errors;

prompt "                                                                          " 
prompt "------------ 17.PAQUETE DALD_RETURN_ITEM_DETAIL --------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_return_item_detail.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_return_item_detail.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_return_item_detail.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_return_item_detail.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_return_item_detail.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_return_item_detail.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_return_item_detail.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_return_item_detail.sql
show errors;

prompt "                                                                          " 
prompt "------------ 18.PAQUETE DALD_SUBSIDY_DETAIL ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_subsidy_detail.sql    "
@src/gascaribe/papelera-reciclaje/paquetes/dald_subsidy_detail.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_subsidy_detail.sql  "
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_subsidy_detail.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_subsidy_detail.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_subsidy_detail.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_subsidy_detail.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_subsidy_detail.sql
show errors;

prompt "                                                                          " 
prompt "------------ 19.PAQUETE DALD_VALIDITY_POLICY_TYPE ------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N dald_validity_policy_type.sql  "
@src/gascaribe/papelera-reciclaje/paquetes/dald_validity_policy_type.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_validity_policy_type.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_validity_policy_type.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.dald_validity_policy_type.sql "
@src/gascaribe/fnb/seguros/paquetes/adm_person.dald_validity_policy_type.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.dald_validity_policy_type.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.dald_validity_policy_type.sql
show errors;

prompt "                                                                          " 
prompt "------------ 20.PAQUETE DALDC_EQUIVA_LOCALIDAD ---------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N daldc_equiva_localidad.sql "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_equiva_localidad.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_equiva_localidad.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_equiva_localidad.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.daldc_equiva_localidad.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.daldc_equiva_localidad.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.daldc_equiva_localidad.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.daldc_equiva_localidad.sql
show errors;

prompt "                                                                          " 
prompt "------------ 21.PAQUETE DALDC_ATECLIREPO ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N daldc_ateclirepo.sql       "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_ateclirepo.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_ateclirepo.sql     "
@src/gascaribe/atencion-usuarios/reporte-sui/sinonimo/adm_person.ldc_ateclirepo.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.daldc_ateclirepo.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/PAQUETE/adm_person.daldc_ateclirepo.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.daldc_ateclirepo.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/sinonimo/adm_person.daldc_ateclirepo.sql
show errors;

prompt "                                                                          " 
prompt "------------ 22.PAQUETE DALDC_COTIZACION_CONSTRUCT -----------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N daldc_cotizacion_construct.sql "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_cotizacion_construct.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_cotizacion_construct.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_cotizacion_construct.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.daldc_cotizacion_construct.sql"
@src/gascaribe/ventas/paquetes/adm_person.daldc_cotizacion_construct.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.daldc_cotizacion_construct.sql"
@src/gascaribe/ventas/sinonimos/adm_person.daldc_cotizacion_construct.sql
show errors;

prompt "                                                                          " 
prompt "------------ 23.PAQUETE DALDC_ORDEN_LODPD --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N daldc_orden_lodpd.sql      "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_orden_lodpd.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_orden_lodpd.sql    "
@src/gascaribe/fnb/sinonimos/adm_person.ldc_orden_lodpd.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.daldc_orden_lodpd.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_orden_lodpd.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.daldc_orden_lodpd.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_orden_lodpd.sql
show errors;

prompt "                                                                          " 
prompt "------------ 24.PAQUETE DALDC_PROD_COMERC_SECTOR -------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N daldc_prod_comerc_sector.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_prod_comerc_sector.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_prod_comerc_sector.sql    "
@src/gascaribe/general/sinonimos/adm_person.ldc_prod_comerc_sector.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.daldc_prod_comerc_sector.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_prod_comerc_sector.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.daldc_prod_comerc_sector.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_prod_comerc_sector.sql
show errors;

prompt "                                                                          " 
prompt "------------ 25.PAQUETE DALDC_REQCLOSE_CONTRACT --------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N daldc_reqclose_contract.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_reqclose_contract.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_reqclose_contract.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_reqclose_contract.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.daldc_reqclose_contract.sql"
@src/gascaribe/actas/paquetes/adm_person.daldc_reqclose_contract.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.daldc_reqclose_contract.sql"
@src/gascaribe/actas/sinonimos/adm_person.daldc_reqclose_contract.sql
show errors;

prompt "                                                                          " 
prompt "------------ 26.PAQUETE DALDC_SEGMENT_SUSC -------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al PAQUETE O P E N daldc_segment_susc.sql     "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_segment_susc.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_segment_susc.sql   "
@src/gascaribe/fnb/sinonimos/adm_person.ldc_segment_susc.sql
show errors;

prompt "--->Aplicando creación al nuevo PAQUETE adm_person.daldc_segment_susc.sql"
@src/gascaribe/fnb/paquetes/adm_person.daldc_segment_susc.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo PAQUETE adm_person.daldc_segment_susc.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_segment_susc.sql
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
@src/gascaribe/datafix/OSF-2779_Actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2779                           "
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