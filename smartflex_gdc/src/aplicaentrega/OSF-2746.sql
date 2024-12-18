column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                  Aplicando Entrega OSF-2746                              "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "---------------- INICIA BORRADO DE OBJETOS -------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------ 1.PAQUETE DALDC_TEMPLOCFACO ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_templocfaco.sql            "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_templocfaco.sql
show errors;

prompt "                                                                          " 
prompt "------------ 2.PAQUETE DALDC_TIPO_CONSTRUCCION ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_tipo_construccion.sql      "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_tipo_construccion.sql
show errors;

prompt "                                                                          " 
prompt "------------ 3.PAQUETE DALDC_TIPO_TRAB_PLAN_CCIAL ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_tipo_trab_plan_ccial.sql   "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_tipo_trab_plan_ccial.sql
show errors;

prompt "                                                                          " 
prompt "------------ 4.PAQUETE DALDC_TIPOINFO ------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_tipoinfo.sql               "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_tipoinfo.sql
show errors;

prompt "                                                                          " 
prompt "------------ 5.PAQUETE DALDC_TITRACOP ------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_titracop.sql               "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_titracop.sql
show errors;

prompt "                                                                          " 
prompt "------------ 6.PAQUETE DALDC_TT_ACT --------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_tt_act.sql                 "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_tt_act.sql
show errors;

prompt "                                                                          " 
prompt "------------ 7.PAQUETE DALDC_TT_CAUSAL_WARR ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_tt_causal_warr.sql         "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_tt_causal_warr.sql
show errors;

prompt "                                                                          " 
prompt "------------ 8.PAQUETE DALDC_TT_TB ---------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_tt_tb.sql                  "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_tt_tb.sql
show errors;

prompt "                                                                          " 
prompt "------------ 9.PAQUETE DALDC_TTP_TTS -------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_ttp_tts.sql                "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_ttp_tts.sql
show errors;

prompt "                                                                          " 
prompt "------------ 10.PAQUETE DALDC_USERCLOSE_CONTRACT -------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_userclose_contract.sql     "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_userclose_contract.sql
show errors;

prompt "                                                                          " 
prompt "------------ 11.PAQUETE DALDC_VALIDACION_ACTIVIDADES ---------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_validacion_actividades.sql "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_validacion_actividades.sql
show errors;

prompt "                                                                          " 
prompt "------------ 12.PAQUETE DALDC_VALIDATE_RP --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_validate_rp.sql            "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_validate_rp.sql
show errors;

prompt "                                                                          " 
prompt "------------ 13.PAQUETE DALDC_VARIATTR -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_variattr.sql               "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_variattr.sql
show errors;

prompt "                                                                          " 
prompt "------------ 14.PAQUETE DALDC_VARICERT -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_varicert.sql               "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_varicert.sql
show errors;

prompt "                                                                          " 
prompt "------------ 15.PAQUETE DALDC_VARIFACOLO ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_varifacolo.sql             "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_varifacolo.sql
show errors;

prompt "                                                                          " 
prompt "------------ 16.PAQUETE DALDCI_CTAIFRS -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldci_ctaifrs.sql               "
@src/gascaribe/papelera-reciclaje/paquetes/daldci_ctaifrs.sql
show errors;

prompt "                                                                          " 
prompt "------------ 17.PAQUETE DALDCI_NOVDETA -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldci_novdeta.sql               "
@src/gascaribe/papelera-reciclaje/paquetes/daldci_novdeta.sql
show errors;

prompt "                                                                          " 
prompt "------------ 18.PAQUETE DALDCI_NOVXTITRAB --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldci_novxtitrab.sql            "
@src/gascaribe/papelera-reciclaje/paquetes/daldci_novxtitrab.sql
show errors;

prompt "                                                                          " 
prompt "------------ 19.PAQUETE DALDCI_TIPOINTERFAZ ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldci_tipointerfaz.sql          "
@src/gascaribe/papelera-reciclaje/paquetes/daldci_tipointerfaz.sql
show errors;

prompt "                                                                          " 
prompt "------------ 20.PAQUETE DALDCI_TRANSOMA ----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldci_transoma.sql              "
@src/gascaribe/papelera-reciclaje/paquetes/daldci_transoma.sql
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
@src/gascaribe/datafix/OSF-2746_Actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2746                           "
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