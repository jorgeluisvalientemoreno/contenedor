column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2706"
prompt "-----------------"

prompt "-----procedimiento PERSONALIZACIONES.PKG_BCCAMBIO_DIRECCION_ORDENES-----" 
prompt "--->Aplicando objeto personalizaciones.pkg_bccambio_direccion_ordenes.sql"
@src/gascaribe/gestion-ordenes/paquetes/personalizaciones.pkg_bccambio_direccion_ordenes.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2706-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on

show errors;
