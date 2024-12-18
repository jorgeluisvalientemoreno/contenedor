column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                  Aplicando Entrega OSF-2943                              "
prompt "                                                                          "

prompt "--->Aplicando src/gascaribe/papelera-reciclaje/tablas/ldc_encuesta.sql        "
@src/gascaribe/papelera-reciclaje/tablas/ldc_encuesta.sql



prompt "--->Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkgestinfoadot.sql        "
@src/gascaribe/general/integraciones/paquetes/ldci_pkgestinfoadot.sql
show errors;

prompt "--->Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_boosspolicy.sql        "
@src/gascaribe/papelera-reciclaje/paquetes/ld_boosspolicy.sql
show errors;



prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------- FINALIZA --------------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                    Fin Aplica Entrega OSF-2675                           "
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