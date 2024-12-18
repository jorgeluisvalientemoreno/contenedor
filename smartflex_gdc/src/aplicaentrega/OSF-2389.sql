column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                         Aplicando Entrega OSF-2389                       "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "

prompt "--------------------------------INICIO------------------------------------"
prompt "                                                                          "

prompt "                                                                          " 
prompt "-----------------1.PROCEDIMIENTO LDC_PR_CANTLEGAITEMS---------------------" 
prompt "                                                                          " 
 
prompt "Aplicando borrado del procedimiento ldc_pr_cantlegaitems                  " 
prompt "en el directorio src/gascaribe/configuraciones/procedimientos/            "
@src/gascaribe/configuraciones/procedimientos/ldc_pr_cantlegaitems.sql 
show errors;
prompt "                                                                          "
 
prompt "Aplicando sinónimo a tabla adm_person.ge_items.sql                        " 
prompt "en el directorio src/gascaribe/configuraciones/sinónimos/                 "
@src/gascaribe/configuraciones/sinonimos/adm_person.ge_items.sql 
show error;
prompt "                                                                          "

prompt "Aplicando sinónimo a tabla adm_person.ldc_cmmitemsxtt.sql                 " 
prompt "en el directorio src/gascaribe/configuraciones/sinónimos/                 "
@src/gascaribe/configuraciones/sinonimos/adm_person.ldc_cmmitemsxtt.sql 
show errors;
prompt "                                                                          "

prompt "Aplicando sinónimo a secuencia adm_person.seqldc_cmmitemsxtt.sql          " 
prompt "en el directorio src/gascaribe/configuraciones/sinónimos/                 "
@src/gascaribe/configuraciones/sinonimos/adm_person.seqldc_cmmitemsxtt.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.ut_file.sql                     " 
prompt "en el directorio src/gascaribe/configuraciones/sinónimos/                 "
@src/gascaribe/configuraciones/sinonimos/adm_person.ut_file.sql
show errors;
prompt "                                                                          "

prompt "Aplicando creación del procedimiento adm_person.ldc_pr_cantlegaitems.sql  " 
prompt "en el directorio src/gascaribe/configuraciones/procedimientos/            "
@src/gascaribe/configuraciones/procedimientos/adm_person.ldc_pr_cantlegaitems.sql
show errors;
prompt "                                                                          "

prompt "Aplicando creación del sinónimo a nuevo procedimiento adm_person.ldc_pr_cantlegaitems.sql" 
prompt "en el directorio src/gascaribe/configuraciones/sinonimos/                 "
@src/gascaribe/configuraciones/sinonimos/adm_person.ldc_pr_cantlegaitems.sql
show errors;

prompt "                                                                          " 
prompt "----------------2.PROCEDIMIENTO LDC_PRITEM_TASKTYPE_FILE------------------" 
prompt "                                                                          " 

prompt "                                                                          "
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_pritem_tasktype_file.sql "
prompt "en el directorio src/gascaribe/configuraciones/procedimientos/            "
@src/gascaribe/configuraciones/procedimientos/ldc_pritem_tasktype_file.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.dage_items.sql                  "
prompt "en el directorio src/gascaribe/configuraciones/sinonimos/                 "
@src/gascaribe/configuraciones/sinonimos/adm_person.dage_items.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_versionentrega.sql          " 
prompt "en el directorio src/gascaribe/configuraciones/sinonimos/                 "
@src/gascaribe/configuraciones/sinonimos/adm_person.ldc_versionentrega.sql
show errors;
prompt "                                                                          "

prompt "Aplicando creación del procedimiento adm_person.ldc_pritem_tasktype_file.sql  " 
prompt "en el directorio src/gascaribe/configuraciones/procedimientos/            "
@src/gascaribe/configuraciones/procedimientos/adm_person.ldc_pritem_tasktype_file.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nuevo procedimiento adm_person.ldc_pritem_tasktype_file.sql" 
prompt "en el directorio src/gascaribe/configuraciones/sinonimos/ 
@src/gascaribe/configuraciones/sinonimos/adm_person.ldc_pritem_tasktype_file.sql
show errors;

prompt "                                                                          " 
prompt "----------------3.PROCEDIMIENTO LDC_PROCINCLUMAS--------------------------"  
prompt "                                                                          " 

prompt "                                                                          "
prompt "Aplicando ejecución del procedimiento ldc_procinclumas                    "
prompt "en el directorio src/gascaribe/cartera/procedimientos/                    "
@src/gascaribe/cartera/procedimientos/ldc_procinclumas.sql 
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "----------------4.PROCEDIMIENTO LDC_PROCINFOESTABBYFILE-------------------"   
prompt "                                                                          " 

prompt "                                                                          "
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_procinfoestabbyfile.sql " 
prompt "en el directorio src/gascaribe/ventas/procedimientos/                     "
@src/gascaribe/ventas/procedimientos/ldc_procinfoestabbyfile.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a paquete adm_person.daldc_prod_comerc_sector.sql"
prompt "en el directorio src/gascaribe/ventas/sinonimos/                          "
@src/gascaribe/ventas/sinonimos/adm_person.daldc_prod_comerc_sector.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a tabla adm_person.ldc_sector_comercial.sql    "
prompt "en el directorio src/gascaribe/ventas/sinonimos/                          "
@src/gascaribe/ventas/sinonimos/adm_person.ldc_sector_comercial.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a tabla adm_person.ldc_prod_comerc_sector.sql  " 
prompt "en el directorio src/gascaribe/ventas/sinonimos/                          "
@src/gascaribe/ventas/sinonimos/adm_person.ldc_prod_comerc_sector.sql
show errors;
prompt "                                                                          "

prompt "                                                                          "
prompt "--->Aplicando creación del procedimiento adm_person.ldc_procinfoestabbyfile.sql " 
prompt "en el directorio src/gascaribe/ventas/procedimientos/                     "
@src/gascaribe/ventas/procedimientos/adm_person.ldc_procinfoestabbyfile.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nuevo procedimiento adm_person.ldc_procinfoestabbyfile.sql" 
prompt "en el directorio src/gascaribe/ventas/sinonimos/                          "
@src/gascaribe/ventas/sinonimos/adm_person.ldc_procinfoestabbyfile.sql
show errors;

prompt "                                                                          " 
prompt "----------------5.PROCEDIMIENTO LDC_PRVALDATCARGCONTRATO------------------"  
prompt "                                                                          " 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prvaldatcargcontrato.sql " 
@src/gascaribe/cartera/procedimientos/ldc_prvaldatcargcontrato.sql 
prompt "en el directorio src/gascaribe/cartera/procedimientos/                    "
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.dage_directory.sql            " 
prompt "en el directorio src/gascaribe/cartera/sinonimo/                          "
@src/gascaribe/cartera/sinonimo/adm_person.dage_directory.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a paquete adm_person.ge_bofilemanager.sql          " 
prompt "en el directorio src/gascaribe/cartera/sinonimo/                          "
@src/gascaribe/cartera/sinonimo/adm_person.ge_bofilemanager.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_contratpendtermi.sql        "
prompt "en el directorio src/gascaribe/cartera/sinonimo/                          "
@src/gascaribe/cartera/sinonimo/adm_person.ldc_contratpendtermi.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de procedimiento adm_person.prvaldatcargcontrato.sql"
prompt "en el directorio src/gascaribe/cartera/procedimientos/                    "
@src/gascaribe/cartera/procedimientos/adm_person.ldc_prvaldatcargcontrato.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nuevo procedimiento adm_person.prvaldatcargcontrato.sql"
prompt "en el directorio src/gascaribe/cartera/sinonimo/                          "
@src/gascaribe/cartera/sinonimo/adm_person.ldc_prvaldatcargcontrato.sql
show errors;

prompt "                                                                          " 
prompt "------------------- ACTUALIZAR REGISTRO ----------------------------------" 
prompt "                                                                          "
 
prompt "--->Aplicando actualización de objetos migrados                           "
@src/gascaribe/general/sql/OSF-2389_actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------------FINALIZA-----------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                        Fin Aplica Entrega OSF-2389                       "
prompt "--------------------------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
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