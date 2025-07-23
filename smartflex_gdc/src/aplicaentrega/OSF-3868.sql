column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-3868"
prompt "-----------------"


prompt "-----OBJETOS-----" 

prompt "--->Aplicando paquete adm_person.pkg_producto"
@src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_producto.sql


prompt "-----DATAFIX-----" 
@src/gascaribe/datafix/OSF-3868_ins_homologacion_servicios.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-3868-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on