column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                         Aplicando Entrega OSF-2848                       "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "

prompt "--------------------------------INICIO------------------------------------"
prompt "                                                                          "

prompt "                                                                          " 
prompt "----------------- 1.Paquete LD_BOEXECUTEDRELMARKET -----------------------" 
prompt "                                                                          " 
 
prompt "--->Aplicando borrado al Paquete O P E N  ld_boexecutedrelmarket.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boexecutedrelmarket.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 2.Paquete LD_BOOSSCOMMENT ------------------------------" 
prompt "                                                                          " 
 
prompt "--->Aplicando borrado al Paquete O P E N  ld_boosscomment.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boosscomment.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 3.Paquete LD_BOOSSPOLICY -------------------------------" 
prompt "                                                                          " 
 
prompt "--->Aplicando borrado al Paquete O P E N  ld_boosspolicy.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boosspolicy.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 4.Paquete LD_BOREADINGORDERDATA ------------------------" 
prompt "                                                                          " 
 
prompt "--->Aplicando borrado al Paquete O P E N  ld_boreadingorderdata.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boreadingorderdata.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 5.Paquete LD_REPORT_GENERATION_2 -----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ld_report_generation_2.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_report_generation_2.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 6.Paquete LD_REPORT_GENERATION_4 -----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ld_report_generation_4.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_report_generation_4.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 7.Paquete LD_REPORT_GENERATION_8 -----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ld_report_generation_8.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_report_generation_8.sql
show errors;

prompt "--->Aplicando datafix de Job LD_REPORT_GENERATION_8"
@src/gascaribe/datafix/OSF-2848_BorrarJOB_LD_REPORT_GENERATION_8.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 9.Paquete LDC_ACTA2_PRU --------------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_acta2_pru.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_acta2_pru.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 10.Paquete LDC_ACTUAPERICOSE ---------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado a Paquete O P E N  ldc_actuapericose.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_actuapericose.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla O P E N  adm_person.ldc_log_apc.sql"
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.ldc_log_apc.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete O P E N  adm_person.ldc_actuapericose.sql"
@src/gascaribe/facturacion/consumos/paquetes/adm_person.ldc_actuapericose.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete O P E N  adm_person.ldc_actuapericose.sql"
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.ldc_actuapericose.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 11.Paquete LDC_ANULAITEMMATERIAL -----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_anulaitemmaterial.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_anulaitemmaterial.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 12.Paquete LDC_APTEMPERATURAS --------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado a Paquete O P E N  ldc_aptemperaturas.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_aptemperaturas.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla O P E N  adm_person.ldc_templocacapi.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_templocacapi.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla O P E N  adm_person.cm_vavafaco.sql"
@src/gascaribe/general/sinonimos/adm_person.cm_vavafaco.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete O P E N  adm_person.ldc_aptemperaturas.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_aptemperaturas.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete O P E N  adm_person.ldc_aptemperaturas.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_aptemperaturas.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 13.Paquete LDC_BCACTACONSTRUCTORAS ---------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_bcactaconstructoras.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcactaconstructoras.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 14.Paquete LDC_BCCHANGEQUOTAVALUE ----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado a Paquete O P E N  ldc_bcchangequotavalue.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcchangequotavalue.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete O P E N  adm_person.ldc_bcchangequotavalue.sql"
@src/gascaribe/fnb/paquetes/adm_person.ldc_bcchangequotavalue.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete O P E N  adm_person.ldc_bcchangequotavalue.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_bcchangequotavalue.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 15.Paquete LDC_BCDELETECHARGEDUPL ----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado a Paquete O P E N  ldc_bcdeletechargedupl.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcdeletechargedupl.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete O P E N  adm_person.ldc_bcdeletechargedupl.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_bcdeletechargedupl.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete O P E N  adm_person.ldc_bcdeletechargedupl.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_bcdeletechargedupl.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 16.Paquete LDC_BCDELETECHARGES -------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado a Paquete O P E N  ldc_bcdeletecharges.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcdeletecharges.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete O P E N  adm_person.ldc_bcdeletecharges.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_bcdeletecharges.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete O P E N  adm_person.ldc_bcdeletecharges.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_bcdeletecharges.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 17.Paquete LDC_BCEJECUTAR_FUNCION ----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_bcejecutar_funcion.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcejecutar_funcion.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 18.Paquete LDC_BCFORMATO_COTI_COM ----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_bcformato_coti_com.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcformato_coti_com.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 19.Paquete LDC_BCPKASEM --------------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado a Paquete O P E N  ldc_bcpkasem.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcpkasem.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla O P E N  adm_person.elemmedi.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.elemmedi.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete O P E N  adm_person.ldc_bcpkasem.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_bcpkasem.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete O P E N  adm_person.ldc_bcpkasem.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_bcpkasem.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 20.Paquete LDC_BCREGEREVIPERI_TMP ----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_bcregereviperi_tmp.sql"
@src/gascaribe/revision-periodica/paquetes/ldc_bcregereviperi_tmp.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 21.Paquete LDC_BO_GESTUNITPER --------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado a Paquete O P E N  ldc_bo_gestunitper.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bo_gestunitper.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla O P E N  adm_person.ldc_audor_oper_unit_person.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_audor_oper_unit_person.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete O P E N  adm_person.ldc_bo_gestunitper.sql"
@src/gascaribe/gestion-contratista/paquetes/adm_person.ldc_bo_gestunitper.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete O P E N  adm_person.ldc_bo_gestunitper.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_bo_gestunitper.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 22.Paquete LDC_BO_SUBSCRIBERXID ------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_bo_subscriberxid.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bo_subscriberxid.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 23.Paquete LDC_BOACTA ----------------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_boacta.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boacta.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 24.Paquete LDC_BOACTUALIZAVARIABLES --------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_boactualizavariables.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boactualizavariables.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 25.Paquete LDC_BOARCHIVOFTP ----------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_boarchivoftp.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boarchivoftp.sql
show errors;

prompt "--->Aplicando datafix de Ejecutable TSCTYC "
@src/gascaribe/datafix/OSF-2848_UpdSa_Executable.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 26.Actualizar MASTER_PERSONALIZACIONES------------------" 
prompt "                                                                          " 

prompt "--->Aplicando datafix en MASTER_PERSONALIZACIONES "
@src/gascaribe/datafix/OSF-2848_Actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------------FINALIZA-----------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                        Fin Aplica Entrega OSF-2848                       "
prompt "--------------------------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define off
quit
/