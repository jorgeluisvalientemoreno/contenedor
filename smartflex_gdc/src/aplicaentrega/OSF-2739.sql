column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                  Aplicando Entrega OSF-2739                              "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "---------------- INICIA BORRADO DE OBJETOS -------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------ 1.PAQUETE DALD_BINE_FINA_ENT --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_bine_fina_ent.sql     "
@src/gascaribe/papelera-reciclaje/paquetes/dald_bine_fina_ent.sql
show errors;

prompt "                                                                          " 
prompt "------------ 2.PAQUETE DALD_CATALOG --------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_catalog.sql           "
@src/gascaribe/papelera-reciclaje/paquetes/dald_catalog.sql
show errors;

prompt "                                                                          " 
prompt "------------ 3.PAQUETE DALD_CAUS_REV_SUB ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_caus_rev_sub.sql      "
@src/gascaribe/papelera-reciclaje/paquetes/dald_caus_rev_sub.sql
show errors;

prompt "                                                                          " 
prompt "------------ 4.PAQUETE DALD_CAUSAL ---------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_causal.sql            "
@src/gascaribe/papelera-reciclaje/paquetes/dald_causal.sql
show errors;

prompt "                                                                          " 
prompt "------------ 5.PAQUETE DALD_CAUSAL_TYPE ----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_causal_type.sql       "
@src/gascaribe/papelera-reciclaje/paquetes/dald_causal_type.sql
show errors;

prompt "                                                                          " 
prompt "------------ 6.PAQUETE DALD_CO_UN_TASK_TYPE ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_co_un_task_type.sql   "
@src/gascaribe/papelera-reciclaje/paquetes/dald_co_un_task_type.sql
show errors;

prompt "                                                                          " 
prompt "------------ 7.PAQUETE DALD_CONCEPTO_REM ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_concepto_rem.sql      "
@src/gascaribe/papelera-reciclaje/paquetes/dald_concepto_rem.sql
show errors;

prompt "                                                                          " 
prompt "------------ 8.PAQUETE DALD_CREG_RESOLUTION ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_creg_resolution.sql   "
@src/gascaribe/papelera-reciclaje/paquetes/dald_creg_resolution.sql
show errors;

prompt "                                                                          " 
prompt "------------ 9.PAQUETE DALD_DETAIL_NOTIFICATION --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_detail_notification.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dald_detail_notification.sql
show errors;

prompt "                                                                          " 
prompt "------------ 10.PAQUETE DALD_DIS_EXP_BUDGET ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_dis_exp_budget.sql    "
@src/gascaribe/papelera-reciclaje/paquetes/dald_detail_notification.sql
show errors;

prompt "                                                                          " 
prompt "------------ 11.PAQUETE DALD_DOCUMENT_TYPE -------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_document_type.sql     "
@src/gascaribe/papelera-reciclaje/paquetes/dald_document_type.sql
show errors;

prompt "                                                                          " 
prompt "------------ 12.PAQUETE DALD_EQUIVALENCE_LINE ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_equivalence_line.sql  "
@src/gascaribe/papelera-reciclaje/paquetes/dald_equivalence_line.sql
show errors;

prompt "                                                                          " 
prompt "------------ 13.PAQUETE DALD_FINAN_PLAN_FNB ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_finan_plan_fnb.sql    "
@src/gascaribe/papelera-reciclaje/paquetes/dald_finan_plan_fnb.sql
show errors;

prompt "                                                                          " 
prompt "------------ 14.PAQUETE DALD_FNB_WARRANTY --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_fnb_warranty.sql      "
@src/gascaribe/papelera-reciclaje/paquetes/dald_fnb_warranty.sql
show errors;

prompt "                                                                          " 
prompt "------------ 15.PAQUETE DALD_HIST_ITEM_WO_OR -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_hist_item_wo_or.sql   "
@src/gascaribe/papelera-reciclaje/paquetes/dald_hist_item_wo_or.sql
show errors;

prompt "                                                                          " 
prompt "------------ 16.PAQUETE DALD_INDEX_IPP_IPC -------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_index_ipp_ipc.sql     "
@src/gascaribe/papelera-reciclaje/paquetes/dald_index_ipp_ipc.sql
show errors;

prompt "                                                                          " 
prompt "------------ 17.PAQUETE DALD_LAUNCH --------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_launch.sql            "
@src/gascaribe/papelera-reciclaje/paquetes/dald_launch.sql
show errors;

prompt "                                                                          " 
prompt "------------ 18.PAQUETE DALD_LINE ----------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_line.sql              "
@src/gascaribe/papelera-reciclaje/paquetes/dald_line.sql
show errors;

prompt "                                                                          " 
prompt "------------ 19.PAQUETE DALD_LIQUIDATION_TYPE ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_liquidation_type.sql  "
@src/gascaribe/papelera-reciclaje/paquetes/dald_liquidation_type.sql
show errors;

prompt "                                                                          " 
prompt "------------ 20.PAQUETE DALD_MAR_EXP_BUDGET ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N dald_mar_exp_budget.sql    "
@src/gascaribe/papelera-reciclaje/paquetes/dald_mar_exp_budget.sql
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
@src/gascaribe/datafix/OSF-2739_Actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2739                           "
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