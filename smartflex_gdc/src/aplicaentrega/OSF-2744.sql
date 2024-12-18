column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                  Aplicando Entrega OSF-2744                              "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "---------------- INICIA MIGRACION DE ESQUEMA -----------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------ 1.PAQUETE DALDC_CA_BONO_LIQUIDARECA -------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_ca_bono_liquidareca.sql    "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_ca_bono_liquidareca.sql
show errors;

prompt "                                                                          " 
prompt "------------ 2.PAQUETE DALDC_CA_LIQUIDAEDAD ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_ca_liquidaedad.sql         "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_ca_liquidaedad.sql
show errors;

prompt "                                                                          " 
prompt "------------ 3.PAQUETE DALDC_CA_LIQUIDARECA ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_ca_liquidareca.sql         "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_ca_liquidareca.sql
show errors;

prompt "                                                                          " 
prompt "------------ 4.PAQUETE DALDC_CA_OPERUNITXRANGOREC ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_ca_operunitxrangorec.sql   "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_ca_operunitxrangorec.sql
show errors;

prompt "                                                                          " 
prompt "------------ 5.PAQUETE DALDC_CA_RANGPERSCAST -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_ca_rangperscast.sql        "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_ca_rangperscast.sql
show errors;

prompt "                                                                          " 
prompt "------------ 6.PAQUETE DALDC_CAPILOCAFACO --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_capilocafaco.sql           "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_capilocafaco.sql
show errors;

prompt "                                                                          " 
prompt "------------ 7.PAQUETE DALDC_CCXCATEG ------------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_ccxcateg.sql               "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_ccxcateg.sql
show errors;

prompt "                                                                          " 
prompt "------------ 8.PAQUETE DALDC_CMMITEMSXTT ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_cmmitemsxtt.sql            "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_cmmitemsxtt.sql
show errors;

prompt "                                                                          " 
prompt "------------ 9.PAQUETE DALDC_COLL_MGMT_PRO_FIN ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_coll_mgmt_pro_fin.sql      "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_coll_mgmt_pro_fin.sql
show errors;

prompt "                                                                          " 
prompt "------------ 10.PAQUETE DALDC_COMI_TARIFA --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_comi_tarifa.sql            "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_comi_tarifa.sql
show errors;

prompt "                                                                          " 
prompt "------------ 11.PAQUETE DALDC_COMISION_PLAN ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_comision_plan.sql          "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_comision_plan.sql
show errors;

prompt "                                                                          " 
prompt "------------ 12.PAQUETE DALDC_CONDIT_COMMERC_SEGM ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_condit_commerc_segm.sql    "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_condit_commerc_segm.sql
show errors;

prompt "                                                                          " 
prompt "------------ 13.PAQUETE DALDC_CONSTRUCTION_SERVICE -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_construction_service.sql   "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_construction_service.sql
show errors;

prompt "                                                                          " 
prompt "------------ 14.PAQUETE DALDC_CONTRA_ICA_GEOGRA --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_contra_ica_geogra.sql      "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_contra_ica_geogra.sql
show errors;

prompt "                                                                          " 
prompt "------------ 15.PAQUETE DALDC_ESTACION_REGULA ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_estacion_regula.sql        "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_estacion_regula.sql
show errors;

prompt "                                                                          " 
prompt "------------ 16.PAQUETE DALDC_FECH_ESTAD_DEU_PROD ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_fech_estad_deu_prod.sql    "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_fech_estad_deu_prod.sql
show errors;

prompt "--->Aplicando creación sinónimo a paquete adm_person.dage_entity.sql      "
@src/gascaribe/cartera/sinonimo/adm_person.dage_entity.sql
show errors;

prompt "--->Aplicando creación sinónimo a tabla adm_person.ldc_fech_estad_deu_prod.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_fech_estad_deu_prod.sql
show errors;

prompt "--->Aplicando creación al nuevo paquete adm_person.daldc_fech_estad_deu_prod.sql"
@src/gascaribe/cartera/paquete/adm_person.daldc_fech_estad_deu_prod.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo paquete adm_person.daldc_fech_estad_deu_prod.sql"
@src/gascaribe/cartera/sinonimo/adm_person.daldc_fech_estad_deu_prod.sql
show errors;

prompt "                                                                          " 
prompt "------------ 17.PAQUETE DALDC_FINAN_COND ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_finan_cond.sql             "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_finan_cond.sql
show errors;

prompt "                                                                          " 
prompt "------------ 18.PAQUETE DALDC_IMCOELLO -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_imcoello.sql               "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_imcoello.sql
show errors;

prompt "                                                                          " 
prompt "------------ 19.PAQUETE DALDC_IMCOELMA -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_imcoelma.sql  "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_imcoelma.sql
show errors;

prompt "                                                                          " 
prompt "------------ 20.PAQUETE DALDC_IMCOMAEL -----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al paquete O P E N daldc_imcomael.sql               "
@src/gascaribe/papelera-reciclaje/paquetes/daldc_imcomael.sql
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
@src/gascaribe/datafix/OSF-2744_Actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2744                           "
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