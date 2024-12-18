column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                  Aplicando Entrega OSF-2813                              "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "---------------- INICIA MIGRACION DE ESQUEMA -----------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------ 1.PAQUETE DALD_BINE_FINA_ENT --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_bine_fina_ent.sql   "
@src/gascaribe/facturacion/sinonimos/adm_person.ld_bine_fina_ent.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.dage_entity.sql      "
@src/gascaribe/facturacion/sinonimos/adm_person.dage_entity.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_bine_fina_ent.sql"
@src/gascaribe/facturacion/paquetes/adm_person.dald_bine_fina_ent.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_bine_fina_ent.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.dald_bine_fina_ent.sql
show errors;

prompt "                                                                          " 
prompt "------------ 2.PAQUETE DALD_CATALOG --------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_catalog.sql         "
@src/gascaribe/fnb/sinonimos/adm_person.ld_catalog.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_catalog.sql "
@src/gascaribe/fnb/paquetes/adm_person.dald_catalog.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_catalog.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_catalog.sql
show errors;

prompt "                                                                          " 
prompt "------------ 3.PAQUETE DALD_CAUS_REV_SUB ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_caus_rev_sub.sql    "
@src/gascaribe/ventas/sinonimos/adm_person.ld_caus_rev_sub.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_caus_rev_sub.sql"
@src/gascaribe/ventas/paquetes/adm_person.dald_caus_rev_sub.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_caus_rev_sub.sql"
@src/gascaribe/ventas/sinonimos/adm_person.dald_caus_rev_sub.sql
show errors;

prompt "                                                                          " 
prompt "------------ 4.PAQUETE DALD_CAUSAL ---------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_causal.sql          "
@src/gascaribe/ventas/sinonimos/adm_person.ld_causal.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_causal.sql  "
@src/gascaribe/ventas/paquetes/adm_person.dald_causal.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_causal.sql"
@src/gascaribe/ventas/sinonimos/adm_person.dald_causal.sql
show errors;

prompt "                                                                          " 
prompt "------------ 5.PAQUETE DALD_CAUSAL_TYPE ----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_causal_type.sql     "
@src/gascaribe/ventas/sinonimos/adm_person.ld_causal_type.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_causal_type.sql"
@src/gascaribe/ventas/paquetes/adm_person.dald_causal_type.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_causal_type.sql"
@src/gascaribe/ventas/sinonimos/adm_person.dald_causal_type.sql
show errors;

prompt "                                                                          " 
prompt "------------ 6.PAQUETE DALD_CO_UN_TASK_TYPE ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_co_un_task_type.sql "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ld_co_un_task_type.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_co_un_task_type.sql"
@src/gascaribe/gestion-ordenes/package/adm_person.dald_co_un_task_type.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_co_un_task_type.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.dald_co_un_task_type.sql
show errors;

prompt "                                                                          " 
prompt "------------ 7.PAQUETE DALD_CONCEPTO_REM ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_concepto_rem.sql    "
@src/gascaribe/facturacion/sinonimos/adm_person.ld_concepto_rem.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_concepto_rem.sql"
@src/gascaribe/facturacion/paquetes/adm_person.dald_concepto_rem.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_concepto_rem.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.dald_concepto_rem.sql
show errors;

prompt "                                                                          " 
prompt "------------ 8.PAQUETE DALD_CREG_RESOLUTION ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_creg_resolution.sql "
@src/gascaribe/facturacion/sinonimos/adm_person.ld_creg_resolution.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_creg_resolution.sql"
@src/gascaribe/facturacion/paquetes/adm_person.dald_creg_resolution.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_creg_resolution.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.dald_creg_resolution.sql
show errors;

prompt "                                                                          " 
prompt "------------ 9.PROCEDIMIENTO DALD_DETAIL_NOTIFICATION --------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_detail_notification.sql"
@src/gascaribe/general/sinonimos/adm_person.ld_detail_notification.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_detail_notification.sql"
@src/gascaribe/general/paquetes/adm_person.dald_detail_notification.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_detail_notification.sql"
@src/gascaribe/general/sinonimos/adm_person.dald_detail_notification.sql
show errors;

prompt "                                                                          " 
prompt "------------ 10.PROCEDIMIENTO DALD_DIS_EXP_BUDGET ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_dis_exp_budget.sql  "
@src/gascaribe/general/sinonimos/adm_person.ld_dis_exp_budget.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_dis_exp_budget.sql"
@src/gascaribe/general/paquetes/adm_person.dald_dis_exp_budget.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_dis_exp_budget.sql"
@src/gascaribe/general/sinonimos/adm_person.dald_dis_exp_budget.sql
show errors;

prompt "                                                                          " 
prompt "------------ 11.PROCEDIMIENTO DALD_DOCUMENT_TYPE -------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_document_type.sql   "
@src/gascaribe/general/sinonimos/adm_person.ld_document_type.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_document_type.sql"
@src/gascaribe/general/paquetes/adm_person.dald_document_type.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_document_type.sql"
@src/gascaribe/general/sinonimos/adm_person.dald_document_type.sql
show errors;

prompt "                                                                          " 
prompt "------------ 12.PROCEDIMIENTO DALD_EQUIVALENCE_LINE ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_equivalence_line.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_equivalence_line.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_equivalence_line.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_equivalence_line.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_equivalence_line.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_equivalence_line.sql
show errors;

prompt "                                                                          " 
prompt "------------ 13.PROCEDIMIENTO DALD_FINAN_PLAN_FNB ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_finan_plan_fnb.sql  "
@src/gascaribe/fnb/sinonimos/adm_person.ld_finan_plan_fnb.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_finan_plan_fnb.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_finan_plan_fnb.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_finan_plan_fnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_finan_plan_fnb.sql
show errors;

prompt "                                                                          " 
prompt "------------ 14.PROCEDIMIENTO DALD_FNB_WARRANTY --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_fnb_warranty.sql    "
@src/gascaribe/fnb/sinonimos/adm_person.ld_fnb_warranty.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_fnb_warranty.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_fnb_warranty.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_fnb_warranty.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_fnb_warranty.sql
show errors;

prompt "                                                                          " 
prompt "------------ 15.PROCEDIMIENTO DALD_HIST_ITEM_WO_OR -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_hist_item_wo_or.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_hist_item_wo_or.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_hist_item_wo_or.sql"
@src/gascaribe/fnb/paquetes/adm_person.dald_hist_item_wo_or.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_hist_item_wo_or.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_hist_item_wo_or.sql
show errors;

prompt "                                                                          " 
prompt "------------ 16.PROCEDIMIENTO DALD_INDEX_IPP_IPC -------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_index_ipp_ipc.sql   "
@src/gascaribe/facturacion/sinonimos/adm_person.ld_index_ipp_ipc.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_index_ipp_ipc.sql"
@src/gascaribe/facturacion/paquetes/adm_person.dald_index_ipp_ipc.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_index_ipp_ipc.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.dald_index_ipp_ipc.sql
show errors;

prompt "                                                                          " 
prompt "------------ 17.PROCEDIMIENTO DALD_LAUNCH --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_launch.sql          "
@src/gascaribe/fnb/sinonimos/adm_person.ld_launch.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_launch.sql  "
@src/gascaribe/fnb/paquetes/adm_person.dald_launch.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_launch.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_launch.sql
show errors;

prompt "                                                                          " 
prompt "------------ 18.PROCEDIMIENTO DALD_LINE ----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_line.sql            "
@src/gascaribe/fnb/sinonimos/adm_person.ld_line.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_line.sql    "
@src/gascaribe/fnb/paquetes/adm_person.dald_line.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_line.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_line.sql
show errors;

prompt "                                                                          " 
prompt "------------ 19.PROCEDIMIENTO DALD_LIQUIDATION_TYPE ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_liquidation_type.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ld_liquidation_type.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_liquidation_type.sql "
@src/gascaribe/facturacion/paquetes/adm_person.dald_liquidation_type.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_liquidation_type.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.dald_liquidation_type.sql
show errors;

prompt "                                                                          " 
prompt "------------ 20.PROCEDIMIENTO DALD_MAR_EXP_BUDGET ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_mar_exp_budget.sql "
@src/gascaribe/general/sinonimos/adm_person.ld_mar_exp_budget.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.dald_mar_exp_budget.sql    "
@src/gascaribe/general/paquetes/adm_person.dald_mar_exp_budget.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.dald_mar_exp_budget.sql"
@src/gascaribe/general/sinonimos/adm_person.dald_mar_exp_budget.sql
show errors;

prompt "                                                                          " 
prompt "------------ 21.PROCEDIMIENTO DALDC_CA_BONO_LIQUIDARECA-------------------" 
prompt "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_ca_bono_liquidareca.sql   "
@src/gascaribe/ventas/sinonimos/adm_person.ldc_ca_bono_liquidareca.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_ca_bono_liquidareca.sql"
@src/gascaribe/ventas/paquetes/adm_person.daldc_ca_bono_liquidareca.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_ca_bono_liquidareca.sql"
@src/gascaribe/ventas/sinonimos/adm_person.daldc_ca_bono_liquidareca.sql
show errors;

prompt "                                                                          " 
prompt "------------ 22.PAQUETE DALDC_CA_LIQUIDAEDAD -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_ca_liquidaedad.sql "
@src/gascaribe/ventas/sinonimos/adm_person.ldc_ca_liquidaedad.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_ca_liquidaedad.sql "
@src/gascaribe/ventas/paquetes/adm_person.daldc_ca_liquidaedad.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_ca_liquidaedad.sql"
@src/gascaribe/ventas/sinonimos/adm_person.daldc_ca_liquidaedad.sql
show errors;

prompt "                                                                          " 
prompt "------------ 23.PAQUETE DALDC_CA_LIQUIDARECA -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_ca_liquidareca.sql "
@src/gascaribe/ventas/sinonimos/adm_person.ldc_ca_liquidareca.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_ca_liquidareca.sql"
@src/gascaribe/ventas/paquetes/adm_person.daldc_ca_liquidareca.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_ca_liquidareca.sql"
@src/gascaribe/ventas/sinonimos/adm_person.daldc_ca_liquidareca.sql
show errors;

prompt "                                                                          " 
prompt "------------ 34.PAQUETE DALDC_CA_OPERUNITXRANGOREC -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_ca_operunitxrangorec.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_ca_operunitxrangorec.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_ca_operunitxrangorec.sql"
@src/gascaribe/ventas/paquetes/adm_person.daldc_ca_operunitxrangorec.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_ca_operunitxrangorec.sql"
@src/gascaribe/ventas/sinonimos/adm_person.daldc_ca_operunitxrangorec.sql
show errors;

prompt "                                                                          " 
prompt "------------ 25.PAQUETE DALDC_CA_RANGPERSCAST ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_ca_rangperscast.sql     "
@src/gascaribe/ventas/sinonimos/adm_person.ldc_ca_rangperscast.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_ca_rangperscast.sql"
@src/gascaribe/ventas/paquetes/adm_person.daldc_ca_rangperscast.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_ca_rangperscast.sql"
@src/gascaribe/ventas/sinonimos/adm_person.daldc_ca_rangperscast.sql
show errors;

prompt "                                                                          " 
prompt "------------ 26.PAQUETE DALDC_CAPILOCAFACO -------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_capilocafaco.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_capilocafaco.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_capilocafaco.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_capilocafaco.sql
show errors;

prompt "                                                                          " 
prompt "------------ 27.PAQUETE DALDC_CCXCATEG -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_ccxcateg.sql"
@src/gascaribe/ventas/paquetes/adm_person.daldc_ccxcateg.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_ccxcateg.sql"
@src/gascaribe/ventas/sinonimos/adm_person.daldc_ccxcateg.sql
show errors;

prompt "                                                                          " 
prompt "------------ 28.PAQUETE DALDC_CMMITEMSXTT --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_cmmitemsxtt.sql"
@src/gascaribe/gestion-ordenes/package/adm_person.daldc_cmmitemsxtt.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_cmmitemsxtt.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_cmmitemsxtt.sql
show errors;

prompt "                                                                          " 
prompt "------------ 29.PAQUETE DALDC_COLL_MGMT_PRO_FIN --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_coll_mgmt_pro_fin.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_coll_mgmt_pro_fin.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_coll_mgmt_pro_fin.sql"
@src/gascaribe/cartera/paquete/adm_person.daldc_coll_mgmt_pro_fin.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_coll_mgmt_pro_fin.sql"
@src/gascaribe/cartera/sinonimo/adm_person.daldc_coll_mgmt_pro_fin.sql
show errors;

prompt "                                                                          " 
prompt "------------ 30.PAQUETE DALDC_COMI_TARIFA --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_comi_tarifa.sql    "
@src/gascaribe/ventas/sinonimos/adm_person.ldc_comi_tarifa.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_comi_tarifa.sql  "
@src/gascaribe/ventas/paquetes/adm_person.daldc_comi_tarifa.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_comi_tarifa.sql"
@src/gascaribe/ventas/sinonimos/adm_person.daldc_comi_tarifa.sql
show errors;

prompt "                                                                          " 
prompt "------------ 31.PAQUETE DALDC_COMISION_PLAN ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_comision_plan.sql  "
@src/gascaribe/ventas/sinonimos/adm_person.ldc_comision_plan.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_comision_plan.sql"
@src/gascaribe/ventas/paquetes/adm_person.daldc_comision_plan.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_comision_plan.sql"
@src/gascaribe/ventas/sinonimos/adm_person.daldc_comision_plan.sql
show errors;

prompt "                                                                          " 
prompt "------------ 32.PAQUETE DALDC_CONDIT_COMMERC_SEGM ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_condit_commerc_segm.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_condit_commerc_segm.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_condit_commerc_segm.sql"
@src/gascaribe/ventas/paquetes/adm_person.daldc_condit_commerc_segm.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_condit_commerc_segm.sql"
@src/gascaribe/ventas/sinonimos/adm_person.daldc_condit_commerc_segm.sql
show errors;

prompt "                                                                          " 
prompt "------------ 33.PAQUETE DALDC_CONSTRUCTION_SERVICE -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_construction_service.sql  "
@src/gascaribe/ventas/sinonimos/adm_person.ldc_construction_service.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_construction_service.sql"
@src/gascaribe/ventas/paquetes/adm_person.daldc_construction_service.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_construction_service.sql"
@src/gascaribe/ventas/sinonimos/adm_person.daldc_construction_service.sql
show errors;

prompt "                                                                          " 
prompt "------------ 34.PAQUETE DALDC_CONTRA_ICA_GEOGRA --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_contra_ica_geogra.sql"
@src/gascaribe/contabilidad/sinonimos/adm_person.ldc_contra_ica_geogra.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_contra_ica_geogra.sql"
@src/gascaribe/contabilidad/paquetes/adm_person.daldc_contra_ica_geogra.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_contra_ica_geogra.sql"
@src/gascaribe/contabilidad/sinonimos/adm_person.daldc_contra_ica_geogra.sql
show errors;

prompt "                                                                          " 
prompt "------------ 35.PAQUETE DALDC_ESTACION_REGULA ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_estacion_regula.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_estacion_regula.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_estacion_regula.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_estacion_regula.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_estacion_regula.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_estacion_regula.sql
show errors;

prompt "                                                                          " 
prompt "------------ 36.PAQUETE DALDC_FINAN_COND ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_finan_cond.sql             "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_finan_cond.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_finan_cond.sql   "
@src/gascaribe/cartera/paquete/adm_person.daldc_finan_cond.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_finan_cond.sql"
@src/gascaribe/cartera/sinonimo/adm_person.daldc_finan_cond.sql
show errors;

prompt "                                                                          " 
prompt "------------ 37.PAQUETE DALDC_IMCOELLO -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_imcoello.sql       "
@src/gascaribe/general/sinonimos/adm_person.ldc_imcoello.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_imcoello.sql     "
@src/gascaribe/general/paquetes/adm_person.daldc_imcoello.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_imcoello.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_imcoello.sql
show errors;

prompt "                                                                          " 
prompt "------------ 38.PAQUETE DALDC_IMCOELMA -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_imcoelma.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_imcoelma.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_imcoelma.sql "
@src/gascaribe/general/paquetes/adm_person.daldc_imcoelma.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_imcoelma.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_imcoelma.sql
show errors;

prompt "                                                                          " 
prompt "------------ 39.PAQUETE DALDC_IMCOMAEL -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_imcomael.sql       "
@src/gascaribe/general/sinonimos/adm_person.ldc_imcomael.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_imcomael.sql     "
@src/gascaribe/general/paquetes/adm_person.daldc_imcomael.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_imcomael.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_imcomael.sql
show errors;

prompt "                                                                          " 
prompt "------------ 40.PAQUETE DALDC_TEMPLOCFACO --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a paquete adm_person.ldc_templocfaco.sql  "
@src/gascaribe/general/sinonimos/adm_person.ldc_templocfaco.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_templocfaco.sql  "
@src/gascaribe/general/paquetes/adm_person.daldc_templocfaco.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_templocfaco.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_templocfaco.sql
show errors;

prompt "                                                                          " 
prompt "------------ 41.PAQUETE DALDC_TIPO_CONSTRUCCION --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_tipo_construccion.sql "
@src/gascaribe/general/sinonimos/adm_person.ldc_tipo_construccion.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_tipo_construccion.sql "
@src/gascaribe/general/paquetes/adm_person.daldc_tipo_construccion.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_tipo_construccion.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_tipo_construccion.sql
show errors;

prompt "                                                                          " 
prompt "------------ 42.PAQUETE DALDC_TIPO_TRAB_PLAN_CCIAL -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_tipo_trab_plan_ccial.sql "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tipo_trab_plan_ccial.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_tipo_trab_plan_ccial.sql"
@src/gascaribe/gestion-ordenes/package/adm_person.daldc_tipo_trab_plan_ccial.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_tipo_trab_plan_ccial.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_tipo_trab_plan_ccial.sql
show errors;

prompt "                                                                          " 
prompt "------------ 43.PAQUETE DALDC_TIPOINFO -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_tipoinfo.sql       "
@src/gascaribe/general/sinonimos/adm_person.ldc_tipoinfo.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_tipoinfo.sql     "
@src/gascaribe/general/paquetes/adm_person.daldc_tipoinfo.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_tipoinfo.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_tipoinfo.sql
show errors;

prompt "                                                                          " 
prompt "------------ 44.PAQUETE DALDC_TITRACOP -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_titracop.sql       "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_titracop.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_titracop.sql     "
@src/gascaribe/gestion-ordenes/package/adm_person.daldc_titracop.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_titracop.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_titracop.sql
show errors;

prompt "                                                                          " 
prompt "------------ 45.PAQUETE DALDC_TT_ACT -------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_tt_act.sql         "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tt_act.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_tt_act.sql       "
@src/gascaribe/gestion-ordenes/package/adm_person.daldc_tt_act.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_tt_act.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_tt_act.sql
show errors;

prompt "                                                                          " 
prompt "------------ 46.PAQUETE DALDC_TT_CAUSAL_WARR -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_tt_causal_warr.sql "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tt_causal_warr.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_tt_causal_warr.sql"
@src/gascaribe/gestion-ordenes/package/adm_person.daldc_tt_causal_warr.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_tt_causal_warr.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_tt_causal_warr.sql
show errors;

prompt "                                                                          " 
prompt "------------ 47.PAQUETE DALDC_TT_TB --------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_tt_tb.sql          "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tt_tb.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_tt_tb.sql        "
@src/gascaribe/gestion-ordenes/package/adm_person.daldc_tt_tb.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_tt_tb.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_tt_tb.sql
show errors;

prompt "                                                                          " 
prompt "------------ 48.PAQUETE DALDC_TTP_TTS ------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_ttp_tts.sql        "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_ttp_tts.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_ttp_tts.sql      "
@src/gascaribe/gestion-ordenes/package/adm_person.daldc_ttp_tts.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_ttp_tts.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daldc_ttp_tts.sql
show errors;

prompt "                                                                          " 
prompt "------------ 49.PAQUETE DALDC_USERCLOSE_CONTRACT -------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_userclose_contract.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_userclose_contract.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_userclose_contract.sql  "
@src/gascaribe/actas/paquetes/adm_person.daldc_userclose_contract.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_userclose_contract.sql"
@src/gascaribe/actas/sinonimos/adm_person.daldc_userclose_contract.sql
show errors;

prompt "                                                                          " 
prompt "------------ 50.PAQUETE DALDC_VALIDACION_ACTIVIDADES ---------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_validacion_actividades.sql  "
@src/gascaribe/general/sinonimos/adm_person.ldc_validacion_actividades.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_validacion_actividades.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_validacion_actividades.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_validacion_actividades.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_validacion_actividades.sql
show errors;

prompt "                                                                          " 
prompt "------------ 51.PAQUETE DALDC_VALIDATE_RP --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_validate_rp.sql    "
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_validate_rp.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_validate_rp.sql  "
@src/gascaribe/revision-periodica/paquetes/adm_person.daldc_validate_rp.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_validate_rp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.daldc_validate_rp.sql
show errors;

prompt "                                                                          " 
prompt "------------ 52.PAQUETE DALDC_VARIATTR -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_variattr.sql       "
@src/gascaribe/general/sinonimos/adm_person.ldc_variattr.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_variattr.sql     "
@src/gascaribe/general/paquetes/adm_person.daldc_variattr.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_variattr.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_variattr.sql
show errors;

prompt "                                                                          " 
prompt "------------ 53.PAQUETE DALDC_VARICERT -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_varicert.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_varicert.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_varicert.sql     "
@src/gascaribe/general/paquetes/adm_person.daldc_varicert.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_varicert.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_varicert.sql
show errors;

prompt "                                                                          " 
prompt "------------ 54.PAQUETE DALDC_VARIFACOLO ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_varifacolo.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_varifacolo.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_varifacolo.sql"
@src/gascaribe/general/paquetes/adm_person.daldc_varifacolo.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_varifacolo.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_varifacolo.sql
show errors;

prompt "                                                                          " 
prompt "------------ 55.PAQUETE DALDCI_CTAIFRS -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldci_ctaifrs.sql       "
@src/gascaribe/general/sinonimos/adm_person.ldci_ctaifrs.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldci_ctaifrs.sql     "
@src/gascaribe/general/paquetes/adm_person.daldci_ctaifrs.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldci_ctaifrs.sql"
@src/gascaribe/general/sinonimos/adm_person.daldci_ctaifrs.sql
show errors;

prompt "                                                                          " 
prompt "------------ 56.PAQUETE DALDCI_NOVDETA -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldci_novdeta.sql       "
@src/gascaribe/general/sinonimos/adm_person.ldci_novdeta.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldci_novdeta.sql     "
@src/gascaribe/general/paquetes/adm_person.daldci_novdeta.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldci_novdeta.sql"
@src/gascaribe/general/sinonimos/adm_person.daldci_novdeta.sql
show errors;

prompt "                                                                          " 
prompt "------------ 57.PAQUETE DALDCI_NOVXTITRAB --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldci_novxtitrab.sql    "
@src/gascaribe/general/sinonimos/adm_person.ldci_novxtitrab.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldci_novxtitrab.sql  "
@src/gascaribe/general/paquetes/adm_person.daldci_novxtitrab.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldci_novxtitrab.sql"
@src/gascaribe/general/sinonimos/adm_person.daldci_novxtitrab.sql
show errors;

prompt "                                                                          " 
prompt "------------ 58.PAQUETE DALDCI_TIPOINTERFAZ ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldci_tipointerfaz.sql       "
@src/gascaribe/general/sinonimos/adm_person.ldci_tipointerfaz.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldci_tipointerfaz.sql "
@src/gascaribe/general/paquetes/adm_person.daldci_tipointerfaz.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldci_tipointerfaz.sql"
@src/gascaribe/general/sinonimos/adm_person.daldci_tipointerfaz.sql
show errors;

prompt "                                                                          " 
prompt "------------ 59.PAQUETE DALDCI_TRANSOMA ----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldci_transoma.sql              "
@src/gascaribe/papelera-reciclaje/paquetes/daldci_transoma.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldci_transoma.sql      "
@src/gascaribe/general/sinonimos/adm_person.ldci_transoma.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldci_transoma.sql    "
@src/gascaribe/general/paquetes/adm_person.daldci_transoma.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldci_transoma.sql"
@src/gascaribe/general/sinonimos/adm_person.daldci_transoma.sql
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
@src/gascaribe/datafix/OSF-2813_Actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2813                           "
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