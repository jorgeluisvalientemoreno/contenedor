column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"

prompt "                                                      "
prompt "Aplicando borrado del procedimiento ldc_procliquidaalquilervehicu " 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procliquidaalquilervehicu.sql
show errors;
prompt "                                                      "

prompt "                                                      "
prompt "Aplicando borrado del procedimiento ldc_procliquidaporcfijo " 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procliquidaporcfijo.sql
show errors;
prompt "                                                      "
 
prompt "                                                      "
prompt "Aplicando borrado del procedimiento ldclica " 
@src/gascaribe/papelera-reciclaje/procedimientos/ldclica.sql
show errors;
prompt "                                                      "
 
prompt "                                                      "
prompt "Aplicando datafix en SA_EXECUTABLE LDCLICA " 
@src/gascaribe/datafix/OSF_1893_Actualizar_SA_EXECUTABLE_LDCLICA.sql
show errors;
prompt "  
 
prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0"
prompt "------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit