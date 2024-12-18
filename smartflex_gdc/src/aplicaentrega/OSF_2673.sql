column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                  Aplicando Entrega OSF-2673                              "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------------ INICIA BORRADO DE OBJETOS -----------------------------"
prompt "                                                                          "
prompt "--------------- 1.PROCEDIMIENTO LDC_VALCRITERIORECONEX_TEST --------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_valcriterioreconex_test.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_valcriterioreconex_test.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 2.PROCEDIMIENTO LDC_VALIDA_ITEM_REGULADOR ----------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al procedimiento O P E N ldc_valida_item_regulador.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_valida_item_regulador.sql
show errors;

prompt "                                                                          "
prompt "--------------- 3.TABLA LDC_PROACTUALIZATIPOMEDIDOR ----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al procedimiento O P E N ldc_proactualizatipomedidor.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proactualizatipomedidor.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 4.PROCEDIMIENTO LDC_PRINSPROYECT -------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al procedimiento O P E N ldc_prinsproyect.sql       "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prinsproyect.sql
show errors;

prompt "--->Aplicando borrado datos en LDC_PROCEDIMIENTO_OBJ                      "
@src/gascaribe/datafix/OSF-2673_BorrarRegistrosProcEjec_1.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 5.PROCEDIMIENTO PRTEMPORALCHARGE10444 --------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N prtemporalcharge10444.sql  "
@src/gascaribe/papelera-reciclaje/procedimientos/prtemporalcharge10444.sql
show errors;

prompt "--->Aplicando borrado datos en LDC_PROCEDIMIENTO_OBJ                      "
@src/gascaribe/datafix/OSF-2673_BorrarRegistrosProcEjec_2.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 6.PROCEDIMIENTO LDCGENCOMASE_PROCESAR --------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldcgencomase_procesar.sql  "
@src/gascaribe/papelera-reciclaje/procedimientos/ldcgencomase_procesar.sql
show errors;

prompt "--->Aplicando actualización LDCGENCOMASE en SA_EXECUTABLE                 "
@src/gascaribe/datafix/OSF-2673_UpdSa_Executable_1.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 7.PROCEDIMIENTO LDC_GENERA_OT_VISITA_AUTOMA --------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al procedimiento O P E N ldc_genera_ot_visita_automa.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_genera_ot_visita_automa.sql
show errors;

prompt "--->Aplicando borrado JOB SOLICITUD_VISITA_AUTOMAT en DBA_SCHEDULER_JOBS  "
@src/gascaribe/papelera-reciclaje/schedules/solicitud_visita_automat.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 8.PROCEDIMIENTO LDC_LLENASESUCIER_COPIA ------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_llenasesucier_copia.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_llenasesucier_copia.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 9.PROCEDIMIENTO LDC_PROCCANTUSUARPORDEUCONC --------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_proccantusuarpordeuconc.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proccantusuarpordeuconc.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 10.PROCEDIMIENTO LDC_PROLDEMAIL --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_proldemail.sql         "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proldemail.sql
show errors;

prompt "--->Aplicando actualización LDEMAIL en SA_EXECUTABLE                      "
@src/gascaribe/datafix/OSF-2673_UpdSa_Executable_2.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 11.PROCEDIMIENTO PROCESSVALIDAORDENTRAB ------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N processvalidaordentrab.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/processvalidaordentrab.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 12.PROCEDIMIENTO PROANALISUSPENSION ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N proanalisuspension.sql     "
@src/gascaribe/papelera-reciclaje/procedimientos/proanalisuspension.sql
show errors;

prompt "--->Aplicando borrado JOB LDC_PROANALISUSPENSION en DBA_SCHEDULER_JOBS    "
@src/gascaribe/papelera-reciclaje/schedules/ldc_proanalisuspension.sql
show errors;

prompt "--->Aplicando borrado JOB LDC_PROANALISUSPENSION2 en DBA_SCHEDULER_JOBS   "
@src/gascaribe/papelera-reciclaje/schedules/ldc_proanalisuspension2.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 13.PROCEDIMIENTO LDC_RESTRATIFICACION --------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_restratificacion.sql   "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_restratificacion.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 14.PROCEDIMIENTO PROMARCAUSUACODPROVEED ------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N promarcausuacodproveed.sql   "
@src/gascaribe/papelera-reciclaje/procedimientos/promarcausuacodproveed.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 15.PROCEDIMIENTO LDC_PROELIMINAEQUIPAMENTO ---------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_proeliminaequipamento.sql   "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proeliminaequipamento.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 16.Tabla LDC_OSF_USUDECOLO -------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado a tabla O P E N ldc_osf_usudecolo.sql "
@src/gascaribe/papelera-reciclaje/tablas/ldc_osf_usudecolo.sql
show errors;

prompt "                                                                          " 
prompt "--------------- 17.Tabla LDC_ANALISUSP -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado a tablaO P E N ldc_analisusp.sql                    "
@src/gascaribe/papelera-reciclaje/tablas/ldc_analisusp.sql
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
prompt "------------ 1.PROCEDIMIENTO CHANGESTATUS --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N changestatus.sql           "
@src/gascaribe/papelera-reciclaje/procedimientos/changestatus.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.daor_order_comment.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daor_order_comment.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.daor_order_stat_change.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daor_order_stat_change.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.or_bcorderactivities.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bcorderactivities.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.or_bosequences.sql    "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bosequences.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.changestatus.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.changestatus.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.changestatus.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.changestatus.sql
show errors;

prompt "                                                                          " 
prompt "------------ 2.PROCEDIMIENTO LDC_CERTIFICATE_RP --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_certificate_rp.sql     "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_certificate_rp.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_certificados_oia.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_certificados_oia.sql
show errors;

prompt "--->Aplicando creación sinónimo a secuencia adm_person.ldc_seq_plazos_cert.sql "
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_seq_plazos_cert.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.pkholidaymgr.sql     "
@src/gascaribe/revision-periodica/sinonimos/adm_person.pkholidaymgr.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.pr_certificate.sql     "
@src/gascaribe/revision-periodica/sinonimos/adm_person.pr_certificate.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_certificate_rp.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_certificate_rp.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_certificate_rp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_certificate_rp.sql
show errors;

prompt "                                                                          " 
prompt "------------ 3.PROCEDIMIENTO LDC_CREATRAMITEREPARACIONRP -----------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_creatramitereparacionrp.sql   "
@src/gascaribe/revision-periodica/plugin/ldc_creatramitereparacionrp.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_creatramitereparacionrp.sql"
@src/gascaribe/revision-periodica/plugin/adm_person.ldc_creatramitereparacionrp.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_creatramitereparacionrp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_creatramitereparacionrp.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento a innovacion.ldc_creatramitereparacionrp.sql"
@src/gascaribe/revision-periodica/sinonimos/innovacion.ldc_creatramitereparacionrp.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento a personalizaciones.ldc_creatramitereparacionrp.sql"
@src/gascaribe/revision-periodica/sinonimos/personalizaciones.ldc_creatramitereparacionrp.sql
show errors;

prompt "                                                                          " 
prompt "------------ 4.PROCEDIMIENTO LDC_OS_ADDRESSCHANGE ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_os_addresschange.sql   "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_os_addresschange.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.ldc_bomanageaddress.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_bomanageaddress.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_os_addresschange.sql"
@src/gascaribe/general/procedimientos/adm_person.ldc_os_addresschange.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_os_addresschange.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_os_addresschange.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento a gisosf.ldc_os_addresschange.sql"
@src/gascaribe/general/sinonimos/gisosf.ldc_os_addresschange.sql
show errors;

prompt "                                                                          " 
prompt "------------ 5.PROCEDIMIENTO LDC_OS_UDPORDERADDRESS ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_os_udporderaddress.sql "
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_os_udporderaddress.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_os_udporderaddress.sql"
@src/gascaribe/general/procedimientos/adm_person.ldc_os_udporderaddress.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_os_udporderaddress.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_os_udporderaddress.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento a gisosf.ldc_os_udporderaddress.sql"
@src/gascaribe/general/sinonimos/gisosf.ldc_os_udporderaddress.sql
show errors;

prompt "                                                                          " 
prompt "------------ 6.PROCEDIMIENTO LDC_OS_UDPREQUESTADDRESS --------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_os_udprequestaddress.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_os_udprequestaddress.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_os_udprequestaddress.sql"
@src/gascaribe/general/procedimientos/adm_person.ldc_os_udprequestaddress.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_os_udprequestaddress.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_os_udprequestaddress.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento a gisosf.ldc_os_udprequestaddress.sql"
@src/gascaribe/general/sinonimos/gisosf.ldc_os_udprequestaddress.sql
show errors;

prompt "                                                                          " 
prompt "------------ 7.PROCEDIMIENTO LDC_PRLECTURAVAL ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_prlecturaval.sql       "
@src/gascaribe/servicios-asociados/plugin/ldc_prlecturaval.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_prlecturaval.sql"
@src/gascaribe/servicios-asociados/plugin/adm_person.ldc_prlecturaval.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_prlecturaval.sql"
@src/gascaribe/servicios-asociados/sinonimos/adm_person.ldc_prlecturaval.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento a innovacion.ldc_prlecturaval.sql"
@src/gascaribe/servicios-asociados/sinonimos/innovacion.ldc_prlecturaval.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento a personalizaciones.ldc_prlecturaval.sql"
@src/gascaribe/servicios-asociados/sinonimos/personalizaciones.ldc_prlecturaval.sql
show errors;

prompt "                                                                          " 
prompt "------------ 8.PROCEDIMIENTO LDC_PROREGCALCAMORTANOANO -------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_proregcalcamortanoano.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proregcalcamortanoano.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_osf_proyrecar.sql  "
@src/gascaribe/cartera/sinonimo/adm_person.ldc_osf_proyrecar.sql
show errors;

prompt "--->Aplicando creación sinónimo a procedimiento adm_person.ldc_prodevuelvevalorescuotas.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_prodevuelvevalorescuotas.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_proyrecar_temp.sql  "
@src/gascaribe/cartera/sinonimo/adm_person.ldc_proyrecar_temp.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_proregcalcamortanoano.sql"
@src/gascaribe/cartera/procedimientos/adm_person.ldc_proregcalcamortanoano.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_proregcalcamortanoano.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_proregcalcamortanoano.sql
show errors;

prompt "                                                                          " 
prompt "------------ 9.PROCEDIMIENTO LDC_PROVALIREGENSERVNUEVOS_PR ---------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N ldc_provaliregenservnuevos_pr.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_provaliregenservnuevos_pr.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.ldc_provaliregenservnuevos_pr.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_provaliregenservnuevos_pr.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.ldc_provaliregenservnuevos_pr.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_provaliregenservnuevos_pr.sql
show errors;

prompt "                                                                          " 
prompt "------------ 10.PROCEDIMIENTO OS_PEGENCONTRACTOBLIGAT --------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al procedimiento O P E N os_pegencontractobligat.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/os_pegencontractobligat.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ge_base_administra.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_base_administra.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ge_periodo_cert.sql   "
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_periodo_cert.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.pe_bsgencontractoblig.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pe_bsgencontractoblig.sql
show errors;

prompt "--->Aplicando creación al nuevo procedimiento adm_person.os_pegencontractobligat.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.os_pegencontractobligat.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo procedimiento adm_person.os_pegencontractobligat.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.os_pegencontractobligat.sql
show errors;

prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------------ TERMINA MIGRACION DE ESQUEMA --------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          " 
prompt "------------ ACTUALIZAR REGISTRO MASTER_PERSONALIZACIONES ----------------" 
prompt "                                                                          "

prompt "--->Aplicando actualización de objetos en MASTER_PERSONALIZACIONES        "
@src/gascaribe/datafix/OSF-2673_actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2673                           "
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