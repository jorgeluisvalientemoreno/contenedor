column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                         Aplicando Entrega OSF-2349                       "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "

prompt "--------------------------------INICIO------------------------------------"
prompt "                                                                          "

prompt "                                                                          " 
prompt "--------------------Aplicando pkg_traza-----------------------" 
prompt "                                                                          " 
@src/gascaribe/general/paquetes/adm_person.pkg_traza.sql
show errors;
prompt "                                                                          "

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------------FINALIZA-----------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                        Fin Aplica Entrega OSF-2349                       "
prompt "--------------------------------------------------------------------------"


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit