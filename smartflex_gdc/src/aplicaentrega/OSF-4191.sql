set serveroutput on
column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-4191"
prompt "-----------------"


prompt "-----Objetos-----" 

prompt "--->Aplicando actualizacion MD ldcunitrp"
@src/gascaribe/revision-periodica/fwcmd/ldcunitrp.sql

prompt "--->Aplicando borrado vista vw_ldc_unit_oper_plamin"
@src/gascaribe/papelera-reciclaje/vistas/vw_ldc_unit_oper_plamin.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-4191-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
