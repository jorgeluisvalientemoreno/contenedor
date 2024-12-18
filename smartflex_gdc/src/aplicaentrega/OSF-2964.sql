column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                  Aplicando Entrega OSF-2964                              "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------- INICIA BORRAR OBJETOS -------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"

prompt "--->Aplicando borrado al Procedure O P E N  escribir.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/escribir.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib03092021.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib03092021.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib0609211.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib0609211.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib0609212.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib0609212.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib0609213.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib0609213.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib0609214.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib0609214.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib0609215.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib0609215.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib0609216.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib0609216.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib1210211.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib1210211.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib1210212.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib1210212.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib1210213.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib1210213.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib1210214.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib1210214.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib1210215.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib1210215.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib1210216.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib1210216.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib2210211.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib2210211.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib2310211.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib2310211.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib28072021.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib28072021.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib280720212.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib280720212.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prtsdwfinstattrib31082021.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prtsdwfinstattrib31082021.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prwfinstanceattrib1932021.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prwfinstanceattrib1932021.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prwfinstattrib.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prwfinstattrib.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prwfinstattribconteo.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prwfinstattribconteo.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prwfinstattribpno.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prwfinstattribpno.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gdc_prwfinstattribsn.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gdc_prwfinstattribsn.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gege_exerulval_ct69e121393087.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121393087.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gege_exerulval_ct69e121393089.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121393089.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  gege_exerulval_ct69e121393091.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121393091.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib03092021.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib03092021.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib0609211.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib0609211.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib0609212.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib0609212.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib0609213.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib0609213.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib0609214.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib0609214.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib0609215.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib0609215.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib0609216.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib0609216.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib1210211.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib1210211.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib1210212.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib1210212.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib1210213.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib1210213.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib1210214.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib1210214.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib1210215.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib1210215.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib1210216.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib1210216.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib2210211.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib2210211.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib2310211.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib2310211.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib28072021.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib28072021.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib280720212.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib280720212.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prtsdwfinstattrib31082021.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prtsdwfinstattrib31082021.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prwfinstattribconteo.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prwfinstattribconteo.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prwfinstattribpno.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prwfinstattribpno.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  job_prwfinstattribsn.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_prwfinstattribsn.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  ldc_2021101623.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_2021101623.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  ldc_2021101623b.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_2021101623b.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  ldc_dba_prc_truncate.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_dba_prc_truncate.sql
show errors;

prompt "--->Aplicando borrado al Job O P E N  ldc_prwfinstanceattrib1932021.sql"
@src/gascaribe/papelera-reciclaje/schedules/ldc_prwfinstanceattrib1932021.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  ldcbi_prueba.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcbi_prueba.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  ldcbi_pruebaendpoint.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcbi_pruebaendpoint.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  ldcbi_truncatetable.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcbi_truncatetable.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  mo_initatrib_ct23e121393074.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121393074.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  mo_initatrib_ct23e121393075.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121393075.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  mo_initatrib_ct23e121393076.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121393076.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  mo_initatrib_ct23e121393077.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121393077.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  mo_initatrib_ct23e121393080.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121393080.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  mo_initatrib_ct23e121393081.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121393081.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  mo_initatrib_ct23e121393082.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121393082.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  mo_initatrib_ct23e121393083.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121393083.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  mo_initatrib_ct23e121393084.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121393084.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  mo_initatrib_ct23e121393085.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121393085.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  mo_initatrib_ct23e121393086.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121393086.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  mo_validattr_ct26e121393078.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121393078.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  mo_validattr_ct26e121393079.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121393079.sql
show errors;

prompt "--->Aplicando borrado al Procedure O P E N  prdatafixtaritran.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/prdatafixtaritran.sql
show errors;

prompt "                                                                          "
prompt "-------------------- TERMINA BORRAR OBJETOS ------------------------------"
prompt "                                                                          " 
prompt "                                                                          " 
prompt "-------------------  Datafix MASTER_PERSONALIZACIONES --------------------" 
prompt "                                                                          "                                                                         
prompt "--->Aplicando datafix de MASTER_PERSONALIZACIONES OSF-2964_Actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-2964_Actualizar_obj_migrados.sql
show errors; 

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2964                           "
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