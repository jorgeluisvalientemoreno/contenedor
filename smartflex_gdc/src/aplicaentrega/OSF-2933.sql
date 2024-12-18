column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                  Aplicando Entrega OSF-2933                              "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------- INICIA BORRAR OBJETOS -------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "------------ 1.PAQUETE GDC_DSLDC_PLAZOS_CERT -----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  gdc_dsldc_plazos_cert.sql"
@src/gascaribe/papelera-reciclaje/paquetes/gdc_dsldc_plazos_cert.sql
show errors;

prompt "                                                                          " 
prompt "------------ 2.PAQUETE GDC_DSLDC_USUARIOS_SUSP_Y_NOTI --------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  gdc_dsldc_usuarios_susp_y_noti.sql"
@src/gascaribe/papelera-reciclaje/paquetes/gdc_dsldc_usuarios_susp_y_noti.sql
show errors;

prompt "                                                                          " 
prompt "------------ 3.PAQUETE GDC_DSUSUARIOS_NO_APLICA_SU_NO --------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Paquete O P E N  gdc_dsusuarios_no_aplica_su_no.sql"
@src/gascaribe/papelera-reciclaje/paquetes/gdc_dsusuarios_no_aplica_su_no.sql
show errors;

prompt "                                                                          " 
prompt "------------ 4.TABLA LDC_USUARIOS_SUSP_Y_NOTI ----------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Tabla O P E N  ldc_usuarios_susp_y_noti.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_usuarios_susp_y_noti.sql
show errors;

prompt "                                                                          " 
prompt "------------ 5.TABLA USUARIOS_NO_APLICA_SUSPE_NOTIF ----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Tabla O P E N  usuarios_no_aplica_suspe_notif.sql"
@src/gascaribe/papelera-reciclaje/tablas/usuarios_no_aplica_suspe_notif.sql
show errors;

prompt "                                                                          " 
prompt "------------ 6.VISTA LDC_VISTA_USUARIOS_NOTIFICAR ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Vista O P E N  ldc_vista_usuarios_notificar.sql"
@src/gascaribe/papelera-reciclaje/vistas/ldc_vista_usuarios_notificar.sql
show errors;


prompt "                                                                          " 
prompt "------------ 7.VISTA LDC_VISTA_USUARIOS_SUSPENDER ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Vista O P E N  ldc_vista_usuarios_suspender.sql"
@src/gascaribe/papelera-reciclaje/vistas/ldc_vista_usuarios_suspender.sql
show errors;

prompt "                                                                          " 
prompt "------------ 8.PROCEDIMIENTO LDC_PROCCREASOLICITUDNOTIFI -----------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Procedimiento O P E N  ldc_proccreasolicitudnotifi.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proccreasolicitudnotifi.sql
show errors;


prompt "                                                                          " 
prompt "------------ 9.PROCEDIMIENTO LDC_PROCCREASOLICITUDSUSPADMIN --------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado al Procedimiento O P E N  ldc_proccreasolicitudsuspadmin.sql"
@src/gascaribe/cartera/suspensiones/procedimiento/ldc_proccreasolicitudsuspadmin.sql
show errors;

prompt "                                                                          "
prompt "-------------------- TERMINA BORRAR OBJETOS ------------------------------"
prompt "                                                                          " 
prompt "                                                                          "
prompt "---------------------- INICIA CREAR OBJETOS ------------------------------"
prompt "                                                                          "
prompt "------------ 10.PAQUETE GDC_BOSUSPENSION_XNO_CERT ------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación de Paquete O P E N  adm_person.gdc_bosuspension_xno_cert.sql"
@src/gascaribe/revision-periodica/paquetes/adm_person.gdc_bosuspension_xno_cert.sql
show errors;

prompt "                                                                          "
prompt "------------------ TERMINA CREAR OBJETOS ---------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "---------------------- APLICAR DATAFIX  ----------------------------------"
prompt "                                                                          "

prompt "--->Aplicando datafix a Sa_executable O P E N  OSF-2933_UpdSa_Executable_LDRUSUNOT.sql"
@src/gascaribe/datafix/OSF-2933_UpdSa_Executable_LDRUSUNOT.sql
show errors;

prompt ""--->Aplicando datafix a Sa_executable O P E N  OSF-2933_UpdSa_Executable_LDRREUSSUSP.sql"
@src/gascaribe/datafix/OSF-2933_UpdSa_Executable_LDRREUSSUSP.sql
show errors;

prompt "--->Aplicando datafix a Sa_executable O P E N  OSF-2933_UpdSa_Executable_LDC_PROCCREASOLICITUDSUSPADMIN.sql"
@src/gascaribe/datafix/OSF-2933_UpdSa_Executable_LDC_PROCCREASOLICITUDSUSPADMIN.sql
show errors;

prompt "--->Aplicando datafix a Sa_executable O P E N  OSF-2933_UpdSa_Executable_LDC_PROCCREASOLICITUDNOTIFI.sql"
@src/gascaribe/datafix/OSF-2933_UpdSa_Executable_LDC_PROCCREASOLICITUDNOTIFI.sql
show errors;

prompt "--->Aplicando datafix a GE_RECORD_PROCESS y GE_CONTROL_PROCESS [LDC_PROCCREASOLICITUDSUSPADMIN] O P E N "
@src/gascaribe/datafix/OSF-2933_DelGe_x_Process_LDC_PROCCREASOLICITUDSUSPADMIN.sql
show errors;

prompt "--->Aplicando datafix a Ge_Object [LDC_PROCCREASOLICITUDSUSPADMIN] O P E N  GE_OBJECT_121295.sql"
@src/gascaribe/papelera-reciclaje/fwcob/GE_OBJECT_121295.sql 
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          " 
prompt "------------ INGRESAR - ACTUALIZAR REGISTRO MASTER_PERSONALIZACIONES -----" 
prompt "                                                                          "

prompt "--->Aplicando datafix(insert) a Master_Personalizaciones O P E N  OSF_2933_InsertMasterPersonalizaciones"
@src/gascaribe/datafix/OSF_2933_InsertMasterPersonalizaciones.sql
show errors;

prompt "--->Aplicando datafix(update) a Master_Personalizaciones O P E N  OSF-2933_Actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-2933_Actualizar_obj_migrados.sql
show errors;


prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2933                           "
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