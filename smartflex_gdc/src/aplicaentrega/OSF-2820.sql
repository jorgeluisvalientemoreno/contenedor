column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                         Aplicando Entrega OSF-2820                       "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "

prompt "--------------------------------INICIO------------------------------------"
prompt "                                                                          "

prompt "                                                                          " 
prompt "----------------- 1.Procedimiento LDC_PRFILLOTREVDET  --------------------" 
prompt "                                                                          " 
 
prompt "Aplicando ajustes al procedimiento adm_person.ldc_prfillotrevdet.sql      " 
prompt "en el directorio src/gascaribe/revision-periodica/procedimientos/         "
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prfillotrevdet.sql
show errors;
prompt "                                                                          "

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------------FINALIZA-----------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                        Fin Aplica Entrega OSF-2820                       "
prompt "--------------------------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define off
quit
/