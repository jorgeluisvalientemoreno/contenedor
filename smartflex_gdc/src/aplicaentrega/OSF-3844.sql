column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-3844"
prompt "-----------------"

prompt "-----FWCOB-----" 

prompt "--->Aplicando ajustes objeto ge_object_121765"
@src/gascaribe/general/interfaz-contable/fwcob/ge_object_121765.sql


prompt "-----PROCESOS-----" 

prompt "--->Aplicando ajustes objeto prc_actasfnb_contabiliza_sap"
@src/gascaribe/general/interfaz-contable/procedimientos/prc_actasfnb_contabiliza_sap.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-3844-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on