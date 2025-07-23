column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-4041"
prompt "-----------------"

prompt "-----PAQUETES-----" 
prompt "--->Aplicando creacion pkg_uipbgada"
@src/gascaribe/recaudos/paquetes/pkg_uipbgada.sql

prompt "--->Aplicando creacion sinonimo pkg_uipbgada"
@src/gascaribe/recaudos/sinonimos/pkg_uipbgada.sql



prompt "-----PROCESOS-----" 
prompt "--->Aplicando creacion pbgada"
@src/gascaribe/recaudos/procedimientos/pbgada.sql

prompt "--->Aplicando creacion sinonimo pbgada"
@src/gascaribe/recaudos/sinonimos/pbgada.sql



prompt "-----FWCPB-----" 
prompt "--->Aplicando creacion pbgada"
@src/gascaribe/recaudos/fwcpb/pbgada.sql



prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-4041-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on