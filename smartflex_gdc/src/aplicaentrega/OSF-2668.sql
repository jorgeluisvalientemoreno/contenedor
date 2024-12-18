column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                  Aplicando Entrega OSF-2668                              "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------------ INICIA BORRADO DE OBJETOS -----------------------------"
prompt "                                                                          "
prompt "--------------- 1.PROCEDIMIENTO LDC_CREAR_ORDEN --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_crear_orden.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_crear_orden.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 2.PROCEDIMIENTO LDC_LLENASESUCIER_H1_TEMP ----------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al procedimiento O P E N ldc_llenasesucier_h1_temp.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_llenasesucier_h1_temp.sql
show errors;

prompt "                                                                          "
prompt "--------------- 3.TABLA LDC_LOGAUDICLIEN597 ------------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado a tabla O P E N ldc_logaudiclien597.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_logaudiclien597.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 4.PROCEDIMIENTO LDC_PRDATADEUDORCODEUDORPU ---------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al procedimiento O P E N ldc_prdatadeudorcodeudorpu.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prdatadeudorcodeudorpu.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 5.PROCEDIMIENTO LDC_PROCCAMBTT12457A10450 ----------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_proccambtt12457a10450.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proccambtt12457a10450.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 6.PROCEDIMIENTO LDC_PRREGISTERPRODUCT --------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_prregisterproduct.sql  "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prregisterproduct.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 7.PROCEDIMIENTO LDC_PRREVCONSCRIT ------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al procedimiento O P E N ldc_prrevconscrit.sql      "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prrevconscrit.sql
show errors;

prompt "--->Aplicando borrado datos en LDC_PROCEDIMIENTO_OBJ"
@src/gascaribe/datafix/OSF-2668_BorrarRegistrosProcEjec_LDC_PRREVCONSCRIT.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 8.PROCEDIMIENTO LDC_PRVALDATCAMBCLIENT -------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_prvaldatcambclient.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prvaldatcambclient.sql
show errors;

prompt "--->Aplicando actualización datos en SA_EXECUTABLE"
@src/gascaribe/datafix/OSF-2668_UpdSa_Executable_LDC_PBTRASINFOCLIENT.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 9.PROCEDIMIENTO LDC_PRVALFECHVENCFACTU -------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_prvalfechvencfactu.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prvalfechvencfactu.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 10.PROCEDIMIENTO LDC_VALIDAFECHAEJECUCION ----------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_validafechaejecucion.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_validafechaejecucion.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 11.PROCEDIMIENTO LDCPLAUPTCOMENORDE ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldcplauptcomenorde.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/ldcplauptcomenorde.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 12.PROCEDIMIENTO PRACTCAUSCARGOSREVDIF1 ------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N practcauscargosrevdif1.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/practcauscargosrevdif1.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 13.PROCEDIMIENTO PRACTCAUSCARGOSREVDIF2 ------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N practcauscargosrevdif2.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/practcauscargosrevdif2.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 14.PROCEDIMIENTO PRGENERANORTASPRONTOPAGO ----------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N prgeneranortasprontopago.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/prgeneranortasprontopago.sql
show errors;

prompt "                                                                          "
prompt "---------------- TERMINA BORRADO DE OBJETOS ------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "---------------- INICIA MIGRACION DE ESQUEMA -----------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------ 1.PROCEDIMIENTO LDC_PRCONUNOPSUP ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_prconunopsup.sql       "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prconunopsup.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_prconunopsup.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_prconunopsup.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_prconunopsup.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prconunopsup.sql
show errors;

prompt "                                                                          " 
prompt "------------ 2.PROCEDIMIENTO LDC_PROCONFMAXMINITEMS ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_proconfmaxminitems.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proconfmaxminitems.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ge_item_classif.sql    "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_item_classif.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_cmmitemsxtt.sql    "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_cmmitemsxtt.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_proconfmaxminitems.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_proconfmaxminitems.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_proconfmaxminitems.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_proconfmaxminitems.sql
show errors;

prompt "                                                                          " 
prompt "------------ 3.PROCEDIMIENTO LDCPROCGENORDENAPOYO ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldcprocgenordenapoyo.sql   "
@src/gascaribe/papelera-reciclaje/procedimientos/ldcprocgenordenapoyo.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_locunit.sql        "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_locunit.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_ordeapohij.sql     "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_ordeapohij.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldcprocgenordenapoyo.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldcprocgenordenapoyo.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldcprocgenordenapoyo.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcprocgenordenapoyo.sql
show errors;

prompt "                                                                          " 
prompt "------------ 4.PROCEDIMIENTO PORUPDATESTATUSDOCORD -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N porupdatestatusdocord.sql   "
@src/gascaribe/papelera-reciclaje/procedimientos/porupdatestatusdocord.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_titrdocu.sql        "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_titrdocu.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.daor_order_status.sql "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daor_order_status.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_audocuorder.sql     "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_audocuorder.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.porupdatestatusdocord.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.porupdatestatusdocord.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.porupdatestatusdocord.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.porupdatestatusdocord.sql
show errors;

prompt "                                                                          " 
prompt "------------ 5.PROCEDIMIENTO LDC_PROCCONTDOCUVENT ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_proccontdocuvent.sql   "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proccontdocuvent.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_asig_subsidy.sql    "
@src/gascaribe/ventas/sinonimos/adm_person.ld_asig_subsidy.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ld_sales_withoutsubsidy.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ld_sales_withoutsubsidy.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.daor_related_order.sql "
@src/gascaribe/ventas/sinonimos/adm_person.daor_related_order.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.dald_ubication.sql    "
@src/gascaribe/ventas/sinonimos/adm_person.dald_ubication.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_logercodave.sql     "
@src/gascaribe/ventas/sinonimos/adm_person.ldc_logercodave.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.or_boordercomment.sql  "
@src/gascaribe/ventas/sinonimos/adm_person.or_boordercomment.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.dald_asig_subsidy.sql  "
@src/gascaribe/ventas/sinonimos/adm_person.dald_asig_subsidy.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.dald_sales_withoutsubsidy.sql    "
@src/gascaribe/ventas/sinonimos/adm_person.dald_sales_withoutsubsidy.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.or_bofworderrelated.sql "
@src/gascaribe/ventas/sinonimos/adm_person.or_bofworderrelated.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.ld_boutilflow.sql       "
@src/gascaribe/ventas/sinonimos/adm_person.ld_boutilflow.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_proccontdocuvent.sql"
@src/gascaribe/ventas/procedimientos/adm_person.ldc_proccontdocuvent.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_proccontdocuvent.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_proccontdocuvent.sql
show errors;

prompt "                                                                          " 
prompt "------------ 6.PROCEDIMIENTO LDC_PRSETSUBSIDIOS --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_prsetsubsidios.sql   "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prsetsubsidios.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_subsidios.sql       "
@src/gascaribe/ventas/sinonimos/adm_person.ldc_subsidios.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_prsetsubsidios.sql"
@src/gascaribe/ventas/procedimientos/adm_person.ldc_prsetsubsidios.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_prsetsubsidios.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_prsetsubsidios.sql
show errors;

prompt "                                                                          " 
prompt "------------ 7.PROCEDIMIENTO LDC_PROCGENPROYEMADCARETA -------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_procgenproyemadcareta.sql   "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procgenproyemadcareta.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_temp_sesucareta.sql "
@src/gascaribe/cartera/sinonimo/adm_person.ldc_temp_sesucareta.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_osf_diferido.sql "
@src/gascaribe/cartera/sinonimo/adm_person.ldc_osf_diferido.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.conftain.sql         "
@src/gascaribe/cartera/sinonimo/adm_person.conftain.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_osf_diferido_temp.sql "
@src/gascaribe/cartera/sinonimo/adm_person.ldc_osf_diferido_temp.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_proyrecareta.sql "
@src/gascaribe/cartera/sinonimo/adm_person.ldc_proyrecareta.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_proyrecareta_temp.sql "
@src/gascaribe/cartera/sinonimo/adm_person.ldc_proyrecareta_temp.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_procgenproyemadcareta.sql"
@src/gascaribe/cartera/procedimientos/adm_person.ldc_procgenproyemadcareta.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_procgenproyemadcareta.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_procgenproyemadcareta.sql
show errors;

prompt "                                                                          " 
prompt "------------ 8.PROCEDIMIENTO LDC_PROCREVNOVEDADESNUEESLIQ ----------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_procrevnovedadesnueesliq.sql   "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procrevnovedadesnueesliq.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_const_unoprl.sql   "
@src/gascaribe/actas/sinonimos/adm_person.ldc_const_unoprl.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_reporte_ofert_escalo.sql "
@src/gascaribe/actas/sinonimos/adm_person.ldc_reporte_ofert_escalo.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_procrevnovedadesnueesliq.sql"
@src/gascaribe/actas/procedimientos/adm_person.ldc_procrevnovedadesnueesliq.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_procrevnovedadesnueesliq.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_procrevnovedadesnueesliq.sql
show errors;

prompt "                                                                          " 
prompt "------------ 9.PROCEDIMIENTO PRGUARDATMPCAUSAL ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N prguardatmpcausal.sql      "
@src/gascaribe/papelera-reciclaje/procedimientos/prguardatmpcausal.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.or_order_causal_tmp.sql "
@src/gascaribe/actas/sinonimos/adm_person.or_order_causal_tmp.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.ct_boconstants.sql     "
@src/gascaribe/actas/sinonimos/adm_person.ct_boconstants.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.prguardatmpcausal.sql"
@src/gascaribe/actas/procedimientos/adm_person.prguardatmpcausal.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.prguardatmpcausal.sql"
@src/gascaribe/actas/sinonimos/adm_person.prguardatmpcausal.sql
show errors;

prompt "                                                                          " 
prompt "------------ 10.PROCEDIMIENTO LDCINSLDCLOGERRORRSUI ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldcinsldclogerrorrsui.sql   "
@src/gascaribe/papelera-reciclaje/procedimientos/ldcinsldclogerrorrsui.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldclogerrorrsui.sql     "
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldclogerrorrsui.sql
show errors;

prompt "--->Aplicando creación sinónimo a secuencia adm_person.ldc_seqlogerrorsui.sql  "
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_seqlogerrorsui.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldcinsldclogerrorrsui.sql"
@src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldcinsldclogerrorrsui.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldcinsldclogerrorrsui.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldcinsldclogerrorrsui.sql
show errors;

prompt "                                                                          " 
prompt "------------ 11.PROCEDIMIENTO LDCPROINSPRODRED ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldcproinsprodred.sql       "
@src/gascaribe/revision-periodica/procedimientos/ldcproinsprodred.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.ldc_boarchivo.sql    "
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_boarchivo.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_type_red.sql       "
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_type_red.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_product_red.sql    "
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_product_red.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_log_product_red.sql "
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_log_product_red.sql
show errors;

prompt "--->Aplicando creación sinónimo a secuencia adm_person.seq_log_product_red.sql "
@src/gascaribe/revision-periodica/sinonimos/adm_person.seq_log_product_red.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.dage_directory.sql    "
@src/gascaribe/revision-periodica/sinonimos/adm_person.dage_directory.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.dage_person.sql       "
@src/gascaribe/revision-periodica/sinonimos/adm_person.dage_person.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_usercafec.sql       "
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_usercafec.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldcproinsprodred.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldcproinsprodred.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldcproinsprodred.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcproinsprodred.sql
show errors;

prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------------ TERMINA MIGRACION DE ESQUEMA --------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          " 
prompt "------------ ACTUALIZAR REGISTRO MASTER_PERSONALIZACIONES ----------------" 
prompt "                                                                          "

prompt "--->Aplicando actualización de objetos en MASTER_PERSONALIZACIONES"
@src/gascaribe/datafix/OSF-2668_actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2668                           "
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