column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                         Aplicando Entrega OSF-2772                       "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "

prompt "--------------------------------INICIO------------------------------------"
prompt "                                                                          "

prompt "                                                                          " 
prompt "------------ 1.- REGISTRO MASTER_PERSONALIZACIONES -----------------------" 
prompt "                                                                          " 
 
prompt "Aplicando OSF_2772_DeletetHomologacionServicios.sql                       " 
prompt "en el directorio src/datafix/                                             "
@src/gascaribe/datafix/OSF_2772_DeletetHomologacionServicios.sql
show errors;
prompt "                                                                          "
 
prompt "Aplicando OSF_2772_InsertHomologacionServicios.sql                        " 
prompt "en el directorio src/datafix/                                             "
@src/gascaribe/datafix/OSF_2772_InsertHomologacionServicios.sql
show errors;
prompt "                                                                          "
 
prompt "Aplicando OSF_2772_UpdtHomologacionServicios.sql                          " 
prompt "en el directorio src/datafix/                                             "
@src/gascaribe/datafix/OSF_2772_UpdtHomologacionServicios.sql
show errors;
prompt "                                                                          "

prompt "                                                                          " 
prompt "------------ 2.- PKG_BCORDENES -------------------------------------------" 
prompt "                                                                          " 
prompt "Aplicando creación de paquete adm_person.pkg_bcordenes.sql                " 
prompt "en el directorio src/gestion-ordenes/paquetes                             "
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcordenes.sql 
show errors;
prompt "                                                                          "  
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------------FINALIZA-----------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                        Fin Aplica Entrega OSF-2772                       "
prompt "--------------------------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define off
quit
/