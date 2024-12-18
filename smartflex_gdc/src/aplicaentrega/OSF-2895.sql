column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                  Aplicando Entrega OSF-2895                              "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "---------------- INICIA ORGANIZAR DIRECTORIOS ----------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------ 1.PAQUETE LD_BCEQUIVALREPORT --------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación al Paquete O P E N  ld_bcequivalreport.sql"
@src/gascaribe/objetos-obsoletos/paquetes/ld_bcequivalreport.sql
show errors;

prompt "                                                                          " 
prompt "------------ 2.PAQUETE PKTBLIC_DETLISIM ----------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación al Paquete O P E N  pktblic_detlisim.sql"
@src/gascaribe/objetos-obsoletos/paquetes/pktblic_detlisim.sql
show errors;

prompt "                                                                          " 
prompt "------------ 3.PAQUETE LD_BCSELECTIONCRITERIA ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación al Paquete O P E N  ld_bcselectioncriteria.sql"
@src/gascaribe/objetos-obsoletos/paquetes/ld_bcselectioncriteria.sql
show errors;

prompt "                                                                          " 
prompt "------------ 4.PAQUETE IC_BCLISIMPROVGEN ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación al Paquete O P E N  ic_bclisimprovgen.sql"
@src/gascaribe/objetos-obsoletos/paquetes/ic_bclisimprovgen.sql
show errors;

prompt "                                                                          " 
prompt "------------ 5.PAQUETE IC_BOLISIMPROVGEN ---------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación al Paquete O P E N  ic_bolisimprovgen.sql"
@src/gascaribe/objetos-obsoletos/paquetes/ic_bolisimprovgen.sql
show errors;

prompt "                                                                          " 
prompt "------------ 6.PAQUETE LD_BCFILEGENERATION -------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación al Paquete O P E N  ld_bcfilegeneration.sql"
@src/gascaribe/objetos-obsoletos/paquetes/ld_bcfilegeneration.sql
show errors;

prompt "                                                                          " 
prompt "------------ 7.PAQUETE LD_BCGENERATIONRANDOMSAMPLE_3 ---------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación al Paquete O P E N  ld_bcgenerationrandomsample_3.sql"
@src/gascaribe/objetos-obsoletos/paquetes/ld_bcgenerationrandomsample_3.sql
show errors;

prompt "                                                                          " 
prompt "------------ 8.PAQUETE LD_REPORT_GENERATION ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación al Paquete O P E N  ld_report_generation.sql"
@src/gascaribe/objetos-obsoletos/paquetes/ld_report_generation.sql
show errors;

prompt "                                                                          " 
prompt "------------ 9.PROCEDIMIENTO IC_BCLISIMPROVREV ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación al Paquete O P E N  ic_bclisimprovrev.sql"
@src/gascaribe/objetos-obsoletos/paquetes/ic_bclisimprovrev.sql
show errors;

prompt "                                                                          " 
prompt "------------ 10.PROCEDIMIENTO LD_BCNOTIFIMASCR ------------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación al Paquete O P E N  ld_bcnotifimascr.sql"
@src/gascaribe/objetos-obsoletos/paquetes/ld_bcnotifimascr.sql
show errors;

prompt "                                                                          " 
prompt "------------ 11.PROCEDIMIENTO IC_BSLISIMPROVGEN --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación al Paquete O P E N  ic_bslisimprovgen.sql"
@src/gascaribe/objetos-obsoletos/paquetes/ic_bslisimprovgen.sql
show errors;

prompt "                                                                          " 
prompt "------------ 12.PROCEDIMIENTO PKG_CONSTANTES -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación al Paquete O P E N  pkg_constantes.sql"
@src/gascaribe/migracion-gasplus-osf/paquetes/pkg_constantes.sql
show errors;



prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------------ TERMINA ORGANIZAR DIRECTORIOS -------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          " 
prompt "------------ ACTUALIZAR REGISTRO MASTER_PERSONALIZACIONES ----------------" 
prompt "                                                                          "

prompt "--->Aplicando datafix de MASTER_PERSONALIZACIONES OSF-2895_Actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-2895_Actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2895                           "
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