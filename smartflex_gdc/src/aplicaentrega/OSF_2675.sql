column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                  Aplicando Entrega OSF-2675                              "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------------ INICIA BORRADO DE OBJETOS -----------------------------"
prompt "                                                                          "
prompt "--------------- 1.PROCEDIMIENTO GETCOSIGNERINFO --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N getcosignerinfo.sql        "
@src/gascaribe/papelera-reciclaje/procedimientos/getcosignerinfo.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 2.PROCEDIMIENTO ACTUALIZA_PROCEJEC -----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al procedimiento O P E N actualiza_procejec.sql     "
@src/gascaribe/papelera-reciclaje/procedimientos/actualiza_procejec.sql
show errors;

prompt "                                                                          "
prompt "--------------- 3.TABLA PROGRAMA_LDC_LDRREPDIRCOBRO ----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al procedimiento O P E N programa_ldc_ldrrepdircobro.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/programa_ldc_ldrrepdircobro.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 4.PROCEDIMIENTO LDC_PARAMEJECUTAPROCNOVE -----------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al procedimiento O P E N ldc_paramejecutaprocnove.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_paramejecutaprocnove.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 5.PROCEDIMIENTO LDC_PRLEGALIZAOTFNB ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_prlegalizaotfnb.sql    "
@src/gascaribe/objetos-obsoletos/ldc_prlegalizaotfnb.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 6.PROCEDIMIENTO LDCI_PROATTENDESOLICFINAN ----------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldci_proattendesolicfinan.sql  "
@src/gascaribe/papelera-reciclaje/procedimientos/ldci_proattendesolicfinan.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 7.PROCEDIMIENTO PRORECTECUNIDADDIG1 ----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al procedimiento O P E N prorectecunidaddig1.sql    "
@src/gascaribe/papelera-reciclaje/procedimientos/prorectecunidaddig1.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 8.PROCEDIMIENTO LDC_PRRETURNAGENCY -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_prreturnagency.sql     "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prreturnagency.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 9.PROCEDIMIENTO LDC_REPORTE_SUI --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_reporte_sui.sql        "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_reporte_sui.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 10.PROCEDIMIENTO PE_SAVE_ECOACTCONTRACT ------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N pe_save_ecoactcontract.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/pe_save_ecoactcontract.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 11.PROCEDIMIENTO LDC_PROCSUBSCONTRIB ---------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_procsubscontrib.sql    "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procsubscontrib.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 12.PROCEDIMIENTO PRC_MTTO_NOTFLOG ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N prc_mtto_notflog.sql       "
@src/gascaribe/papelera-reciclaje/procedimientos/prc_mtto_notflog.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 13.PROCEDIMIENTO LDC_PROVALIPCOMERPERIANO ----------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_provalipcomerperiano.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_provalipcomerperiano.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 14.PROCEDIMIENTO PROVAPATAPAGENERAL ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N provapatapageneral.sql     "
@src/gascaribe/papelera-reciclaje/procedimientos/provapatapageneral.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 15.PROCEDIMIENTO PROGUARDADESASIGOTTEC -------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N proguardadesasigottec.sql  "
@src/gascaribe/papelera-reciclaje/procedimientos/proguardadesasigottec.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 16.PROCEDIMIENTO PRORECTECUNIDADDIG ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N prorectecunidaddig.sql     "
@src/gascaribe/papelera-reciclaje/procedimientos/prorectecunidaddig.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 17.PROCEDIMIENTO PRORETPERIFACT --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N proretperifact.sql         "
@src/gascaribe/papelera-reciclaje/procedimientos/proretperifact.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 18.PROCEDIMIENTO LDCI_PRTRAMARECAUDO ---------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldci_prtramarecaudo.sql    "
@src/gascaribe/papelera-reciclaje/procedimientos/ldci_prtramarecaudo.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 19.PROCEDIMIENTO PROCCONSESTADOSCUENTACONTRATOS ----------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N procconsestadoscuentacontratos.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/procconsestadoscuentacontratos.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 20.PROCEDIMIENTO LDC_LDRREPDIRCOBRO ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_ldrrepdircobro.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_ldrrepdircobro.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 21.TABLA LDC_DETAL_DIRCOBRO ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado tabla O P E N ldc_detal_dircobro.sql                "
@src/gascaribe/papelera-reciclaje/tablas/ldc_detal_dircobro.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 22.TABLA LDC_ENCAB_DIRCOBRO ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado tabla O P E N ldc_encab_dircobro.sql                "
@src/gascaribe/papelera-reciclaje/tablas/ldc_encab_dircobro.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 23.TABLA LDC_REPORTESUI_TMP ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado tabla O P E N ldc_reportesui_tmp.sql                "
@src/gascaribe/papelera-reciclaje/tablas/ldc_reportesui_tmp.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 24.TABLA LDC_OSF_SUBS_CONTR ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado tablas O P E N ldc_osf_subs_contr.sql               "
@src/gascaribe/papelera-reciclaje/tablas/ldc_osf_subs_contr.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 25.TABLA LDC_PER_COMERCIAL -------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado tabla O P E N ldc_per_comercial.sql                 "
@src/gascaribe/papelera-reciclaje/tablas/ldc_per_comercial.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 26.TABLA LDC_PER_COMERCIAL_AUD ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado tabla O P E N ldc_per_comercial_aud.sql             "
@src/gascaribe/papelera-reciclaje/tablas/ldc_per_comercial_aud.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 27.TRIGGER LDC_PER_COMERCIAL_TRG01 -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado trigger O P E N ldc_per_comercial_trg01.sql         "
@src/gascaribe/objetos-obsoletos/triggers/ldc_per_comercial_trg01.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 28.TRIGGER LDC_PER_COMERCIAL_TRG02 -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado trigger O P E N ldc_per_comercial_trg02.sql         "
@src/gascaribe/objetos-obsoletos/triggers/ldc_per_comercial_trg02.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 29.JOB LDCI_ATEND_SOLICI_FINAN_MOVIL ---------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado Job O P E N ldci_atend_solici_finan_movil.sql       "
@src/gascaribe/papelera-reciclaje/schedules/ldci_atend_solici_finan_movil.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 30.FUNCIÓN LDCFNU_VENANOACTUAL ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado función adm_person.ldcfnu_venanoactual.sql          "
@src/gascaribe/Cierre/funciones/adm_person.ldcfnu_venanoactual.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 31.FUNCIÓN LDCFNU_VENANODIREC ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado función adm_person.ldcfnu_venanodirec.sql           "
@src/gascaribe/Cierre/funciones/adm_person.ldcfnu_venanodirec.sql
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
prompt "------------ 1.PROCEDIMIENTO LDC_PRMARCAPRODUCTOLOG ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_prmarcaproductolog.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prmarcaproductolog.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_marca_producto_log.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_marca_producto_log.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_prmarcaproductolog.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prmarcaproductolog.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_prmarcaproductolog.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prmarcaproductolog.sql
show errors;

prompt "                                                                          " 
prompt "------------ 2.PROCEDIMIENTO LDC_PROCREAREGASIUNIOPREVPER ----------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_procrearegasiunioprevper.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procrearegasiunioprevper.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_procrearegasiunioprevper.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_procrearegasiunioprevper.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_procrearegasiunioprevper.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_procrearegasiunioprevper.sql
show errors;

prompt "                                                                          " 
prompt "------------ 3.PROCEDIMIENTO LDC_PROACTUALIZAESTAPROG --------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_proactualizaestaprog.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proactualizaestaprog.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_proactualizaestaprog.sql"
@src/gascaribe/general/procedimientos/adm_person.ldc_proactualizaestaprog.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_proactualizaestaprog.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_proactualizaestaprog.sql
show errors;

prompt "                                                                          " 
prompt "------------ 4.PROCEDIMIENTO LDC_PROINSERTAESTAPROG ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_proinsertaestaprog.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proinsertaestaprog.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_proinsertaestaprog.sql"
@src/gascaribe/general/procedimientos/adm_person.ldc_proinsertaestaprog.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_proinsertaestaprog.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_proinsertaestaprog.sql
show errors;

prompt "                                                                          " 
prompt "------------ 5.PROCEDIMIENTO LDC_PRGENERECOCMRP --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_prgenerecocmrp.sql     "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prgenerecocmrp.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_ordenes_rp.sql     "
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_ordenes_rp.sql
show errors;

prompt "--->Aplicando creación sinónimo a función adm_person.ldcfncretornamarcacerprp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcfncretornamarcacerprp.sql
show errors;

prompt "--->Aplicando creación sinónimo a función adm_person.ldcfncretornamarcadefcri.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcfncretornamarcadefcri.sql
show errors;

prompt "--->Aplicando creación sinónimo a función adm_person.ldcfncretornamarcacerprp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcfncretornamarcacerprp.sql
show errors;

prompt "--->Aplicando creación sinónimo a función adm_person.ldcfncretornamarcarevprp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcfncretornamarcarevprp.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_prgenerecocmrp.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prgenerecocmrp.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_prgenerecocmrp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prgenerecocmrp.sql
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
@src/gascaribe/datafix/OSF_2675_InsertMasterPersonalizaciones.sql
show errors;

prompt "--->Aplicando actualización del comentario en MASTER_PERSONALIZACIONES"
@src/gascaribe/datafix/OSF-2675_Actualizar_obj_migrados.sql
show errors;
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          " 
prompt "----------------- BORRAR REGISTRO GE_STATEMENT ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de datos de STATEMENT_ID=120038236                  "
@src/gascaribe/datafix/OSF-2675_BorrarRegistrosGe_Statement.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2675                           "
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