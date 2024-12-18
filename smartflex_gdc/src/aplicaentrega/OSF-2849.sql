column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                         Aplicando Entrega OSF-2849                       "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "

prompt "--------------------------------INICIO------------------------------------"
prompt "                                                                          "

prompt "-------------------------- Borrado de paquetes ---------------------------"
prompt "                                                                          "

prompt "                                                                          " 
prompt "----------------- 1.Paquete LDC_BOASOBANCARIA2001 -----------------------" 
prompt "                                                                          " 
 
prompt "--->Aplicando borrado al Paquete O P E N  ldc_boasobancaria2001.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boasobancaria2001.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 2.Paquete LDC_BOCARTERA --------------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_bocartera.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bocartera.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 3.Paquete LDC_BOCOUPONS (RETIRADO DE LA ENTREGA)--------" 
prompt "                                                                          " 

--prompt "--->Aplicando borrado al Paquete O P E N  ldc_bocoupons.sql"
---@src/gascaribe/papelera-reciclaje/paquetes/ldc_bocoupons.sql
--show errors;

prompt "                                                                          " 
prompt "----------------- 4.Paquete LDC_BOCRMCOTIZACION --------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_bocrmcotizacion.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bocrmcotizacion.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 5.Paquete LDC_BODOC_INFO_GDC ---------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_bodoc_info_gdc.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bodoc_info_gdc.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 6.Paquete LDC_BOFACTURADEVENTA ---------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_bofacturadeventa.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bofacturadeventa.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 7.Paquete LDC_BOFWCERTFREVPERIOD -----------------------" 
prompt "--------------------- RETIRADO DE LA ENTREGA -----------------------------" 
prompt "                                                                          " 


--prompt "--->Aplicando borrado al Paquete O P E N  ldc_bofwcertfrevperiod.sql"
--@src/gascaribe/papelera-reciclaje/paquetes/ldc_bofwcertfrevperiod.sql
--show errors;

prompt "                                                                          " 
prompt "----------------- 8.Paquete LDC_BOGESTIONMODSOLI -------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_bogestionmodsoli.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bogestionmodsoli.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 9.Paquete LDC_BONOTIFICATIONSERVICES -------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_bonotificationservices.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bonotificationservices.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 10.Paquete LDC_BOORDENCONCILACION ----------------------" 
prompt "                                                                          " 


prompt "--->Aplicando borrado al Paquete O P E N  ldc_boordenconcilacion.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boordenconcilacion.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 11.Paquete LDC_BOOTBYQUOTATION -------------------------" 
prompt "                                                                          " 


prompt "--->Aplicando borrado al Paquete O P E N  ldc_bootbyquotation.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bootbyquotation.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 12.Paquete LDC_BOPACKAGE -------------------------------"
prompt "--------------------- RETIRADO DE LA ENTREGA -----------------------------" 
prompt "                                                                          " 


--prompt "--->Aplicando borrado al Paquete O P E N  ldc_bopackage.sql"
--@src/gascaribe/papelera-reciclaje/paquetes/ldc_bopackage.sql
--show errors;

prompt "                                                                          " 
prompt "----------------- 13.Paquete LDC_BOPICONSTRUCTORA ------------------------"
prompt "--------------------- RETIRADO DE LA ENTREGA -----------------------------" 
prompt "                                                                          " 

--prompt "--->Aplicando borrado al Paquete O P E N  ldc_bopiconstructora.sql"
--@src/gascaribe/papelera-reciclaje/paquetes/ldc_bopiconstructora.sql
--show errors;

prompt "                                                                          " 
prompt "----------------- 14.Paquete LDC_BOPICOTIZACOMERCIAL ---------------------"
prompt "--------------------- RETIRADO DE LA ENTREGA -----------------------------" 
prompt "                                                                          " 

--prompt "--->Aplicando borrado al Paquete O P E N  ldc_bopicotizacomercial.sql"
--@src/gascaribe/papelera-reciclaje/paquetes/ldc_bopicotizacomercial.sql
--show errors;

prompt "                                                                          " 
prompt "----------------- 15.Paquete LDC_BOPROYECTOCONSTRUCTORA ------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_boproyectoconstructora.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boproyectoconstructora.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 16.Paquete LDC_BOREGISTERNOVELTY_NEWNOV ----------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_boregisternovelty_newnov.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boregisternovelty_newnov.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 17.Paquete LDC_BOREPROCESAORD --------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_boreprocesaord.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boreprocesaord.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 18.Paquete LDC_BOSUBSCRIPTION --------------------------"
prompt "--------------------- RETIRADO DE LA ENTREGA -----------------------------" 
prompt "                                                                          " 

--prompt "--->Aplicando borrado al Paquete O P E N  ldc_bosubscription.sql"
--@src/gascaribe/papelera-reciclaje/paquetes/ldc_bosubscription.sql
--show errors;

prompt "                                                                          " 
prompt "----------------- 19.Paquete LDC_BOSUSPPORSEGURIDAD ----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_bosuspporseguridad.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bosuspporseguridad.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 20.Paquete LDC_BOTRASLADO_PAGO -------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_botraslado_pago.sql"
@src/gascaribe/gestion-ordenes/package/ldc_botraslado_pago.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 21.Paquete LDC_BOUBIGEOGRAFICA -------------------------"
prompt "--------------------- RETIRADO DE LA ENTREGA -----------------------------"
prompt "                                                                          " 

--prompt "--->Aplicando borrado al Paquete O P E N  ldc_boubigeografica.sql"
--@src/gascaribe/papelera-reciclaje/paquetes/ldc_boubigeografica.sql
--show errors;

prompt "                                                                          "
prompt "-------------------Termina Borrado de paquetes ---------------------------"
prompt "                                                                          "

prompt "                                                                          "
prompt "-------------------Inicia Migracion de paquetes --------------------------"
prompt "                                                                          "

prompt "                                                                          " 
prompt "----------------- 1.Paquete LDC_BOIMPFACTURACONSTRUCTORA -----------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_boimpfacturaconstructora.sql"
@src/gascaribe/ventas/paquetes/ldc_boimpfacturaconstructora.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla O P E N  adm_person.ld_temp_clob_fact.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ld_temp_clob_fact.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete O P E N  adm_person.daed_document.sql"
@src/gascaribe/ventas/sinonimos/adm_person.daed_document.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete O P E N  adm_person.sa_boexecutable.sql"
@src/gascaribe/ventas/sinonimos/adm_person.sa_boexecutable.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete O P E N  adm_person.pktblfactura.sql"
@src/gascaribe/ventas/sinonimos/adm_person.pktblfactura.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete O P E N  adm_person.ld_bosequence.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ld_bosequence.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete O P E N  adm_person.pkboprintingprocess.sql"
@src/gascaribe/ventas/sinonimos/adm_person.pkboprintingprocess.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete O P E N  adm_person.ldc_boimpfacturaconstructora.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_boimpfacturaconstructora.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete O P E N  adm_person.ldc_boimpfacturaconstructora.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_boimpfacturaconstructora.sql
show errors;

prompt "                                                                          " 
prompt "----------------- 2.Paquete LDC_BOPOLITICASLDC ---------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado al Paquete O P E N  ldc_bopoliticasldc.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bopoliticasldc.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla O P E N  adm_person.banco.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.banco.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla O P E N  adm_person.trbadosr.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.trbadosr.sql
show errors;

prompt "--->Aplicando creación sinónimo a Tabla O P E N  adm_person.docusore.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.docusore.sql
show errors;

prompt "--->Aplicando creación sinónimo a Paquete O P E N  adm_person.dage_parameter.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.dage_parameter.sql
show errors;

prompt "--->Aplicando creación al nuevo Paquete O P E N  adm_person.ldc_bopoliticasldc.sql"
@src/gascaribe/recaudos/paquetes/adm_person.ldc_bopoliticasldc.sql
show errors;

prompt "--->Aplicando creación sinónimo del nuevo Paquete O P E N  adm_person.ldc_bopoliticasldc.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.ldc_bopoliticasldc.sql
show errors;

prompt "                                                                          "
prompt "-------------------Termina Migracion de paquetes -------------------------"
prompt "                                                                          "


prompt "                                                                          "
prompt "-------------------Actualizar MASTER_PERSONALIZACIONES -------------------"
prompt "                                                                          "

prompt "--->Aplicando actualizacion de objetos en MASTER_PERSONALIZACIONES        "
@src/gascaribe/datafix/OSF-2849_Actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------------FINALIZA-----------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                        Fin Aplica Entrega OSF-2849                       "
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