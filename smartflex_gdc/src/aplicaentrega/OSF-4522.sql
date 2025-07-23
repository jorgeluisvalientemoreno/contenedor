column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-4522"
prompt "-----------------"


prompt "-----PAQUETES-----" 

prompt "creacion paquete pkg_ld_asig_subsidy-----" 
@src/gascaribe/fnb/seguros/paquetes/adm_person.pkg_ld_asig_subsidy.sql
@src/gascaribe/fnb/seguros/sinonimos/adm_person.pkg_ld_asig_subsidy.sql

prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-4522-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on