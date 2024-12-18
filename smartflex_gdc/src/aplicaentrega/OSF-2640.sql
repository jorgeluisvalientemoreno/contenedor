column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                         Aplicando Entrega OSF-2640                       "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "--------------------------------INICIO------------------------------------"
prompt "                                                                          "
prompt "----------- 1.PROCEDIMIENTO PROC_LEGALIZAOTEJECUTADAS --------------------" 
prompt "                                                                          "

prompt "--->Aplicando traslado de directorio al procedimiento O P E N proc_legalizaotejecutadas.sql"
@src/gascaribe/objetos-obsoletos/procedimientos/proc_legalizaotejecutadas.sql
show errors;

prompt "                                                                          " 
prompt "----------- 2.PROCEDIMIENTO LDC_PROCGENERAPROYECDIFERIDO2 ----------------" 
prompt "                                                                          " 

prompt "--->Aplicando traslado de directorio al procedimiento O P E N ldc_procgeneraproyecdiferido2.sql"
@src/gascaribe/objetos-obsoletos/procedimientos/ldc_procgeneraproyecdiferido2.sql
show errors;

prompt "                                                                          "
prompt "----------- 3.PROCEDIMIENTO LDC_PROCGENERAPROYECDIFECAP ------------------" 
prompt "                                                                          " 

prompt "--->Aplicando traslado de directorio al procedimiento O P E N ldc_procgeneraproyecdifecap.sql "
@src/gascaribe/objetos-obsoletos/procedimientos/ldc_procgeneraproyecdifecap.sql
show errors;

prompt "                                                                          " 
prompt "----------- 4.PROCEDIMIENTO LDC_PROCGENERAPROYECDIFE ---------------------" 
prompt "                                                                          " 

prompt "--->Aplicando traslado de directorio al procedimiento ldc_procgeneraproyecdife.sql "
@src/gascaribe/objetos-obsoletos/procedimientos/ldc_procgeneraproyecdife.sql
show errors;

prompt "                                                                          " 
prompt "----------- 5.PROCEDIMIENTO LDC_INSACTCALLCENTER -------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_insactcallcenter.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_insactcallcenter.sql
show errors;
prompt "                                                                          "
  
prompt "--->Aplicando sinonimo a secuencia adm_person.seq_ldc_actcallcenter.sql   " 
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.seq_ldc_actcallcenter.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando sinonimo a paquete adm_person.daldc_actcallcenter.sql       " 
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.daldc_actcallcenter.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando creación de procedimiento adm_person.ldc_insactcallcenter.sql" 
@src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_insactcallcenter.sql
show errors;
prompt "                                                                          "  
 
prompt "--->Aplicando creación de sinonimo a nuevo procedimiento adm_person.ldc_insactcallcenter.sql    " 
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_insactcallcenter.sql
show errors;
prompt "                                                                          "  

prompt "                                                                          " 
prompt "------------ 6.PROCEDIMIENTO LDC_GEN_OT_INTERVE_VTA_EMPAQ ----------------" 
prompt "                                                                          "

prompt "--->Aplicando traslado de directorio al procedimiento O P E N ldc_gen_ot_interve_vta_empaq.sql "
@src/gascaribe/objetos-obsoletos/procedimientos/ldc_gen_ot_interve_vta_empaq.sql
show errors;


prompt "                                                                          " 
prompt "----------- 7.PROCEDIMIENTO LDC_GEN_OT_INTERVE_FNB -----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando traslado de directorio al procedimiento O P E N ldc_gen_ot_interve_fnb.sql "
@src/gascaribe/objetos-obsoletos/procedimientos/ldc_gen_ot_interve_fnb.sql
show errors;

prompt "                                                                          " 
prompt "----------- 8.PROCEDIMIENTO LDC_PRCREAPLANTNOTI --------------------------" 
prompt "                                                                          "

prompt "--->Aplicando traslado de directorio al procedimiento O P E N ldc_prcreaplantnoti.sql "
@src/gascaribe/objetos-obsoletos/procedimientos/ldc_prcreaplantnoti.sql
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "----------- 9.PROCEDIMIENTO OS_EMERGENCY_ORDER ---------------------------" 
prompt "                                                                          "

prompt "--->Aplicando traslado de directorio al procedimiento O P E N os_emergency_order.sql "
@src/gascaribe/objetos-obsoletos/procedimientos/os_emergency_order.sql
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "------------ 10.PROCEDIMIENTO GE_BOEMERGENCYORDERS -----------------------" 
prompt "                                                                          "

prompt "--->Aplicando procedimiento O P E N ge_boemergencyorders.sql" 
@src/gascaribe/operacion-y-mantenimiento/paquetes/ge_boemergencyorders.sql
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "------------- ACTUALIZAR REGISTRO MASTER_PERSONALIZACIONES ---------------" 
prompt "                                                                          "

prompt "--->Aplicando actualización de objetos migrados en MASTER_PERSONALIZACIONES"
@src/gascaribe/datafix/OSF-2640_actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2640                           "
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