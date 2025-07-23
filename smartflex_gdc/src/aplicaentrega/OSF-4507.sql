column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-4507"
prompt "-----------------"


prompt "-----OBJETOS-----" 

prompt "creacion script ld_send_authorized-----" 
@src/gascaribe/fnb/tablas/ld_send_authorized.sql

prompt "creacion fwcea ld_send_authorized---" 
@src/gascaribe/fnb/fwcea/ld_send_authorized.sql

prompt "creacion fwcmd crcac---" 
@src/gascaribe/fnb/fwcmd/crcac.sql

prompt "creacion procedimiento ldc_vainsldsendauthori---" 
@src/gascaribe/general/procedimientos/adm_person.ldc_vainsldsendauthori.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-4507-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on