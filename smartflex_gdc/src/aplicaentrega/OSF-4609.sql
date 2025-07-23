column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-4609"
prompt "-----------------"

prompt "-----SINONIMOS-----" 

prompt "Creacion sinonimo ldc_ordsinasigaut"
@src/gascaribe/cartera/sinonimo/ldc_ordsinasigaut.sql

prompt "-----PAQUETES-----" 

prompt "Creacion paquete pkg_ldc_ordsinasigaut"
@src/gascaribe/cartera/paquetes/adm_person.pkg_ldc_ordsinasigaut.sql
@src/gascaribe/cartera/sinonimo/adm_person.pkg_ldc_ordsinasigaut.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-4609-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on