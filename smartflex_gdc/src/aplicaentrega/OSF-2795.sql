column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2795"
prompt "-----------------"

prompt "-----procedimiento GENIFRS_DUMMY-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN genifrs_dummy.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/genifrs_dummy.sql

prompt "--->Aplicando creacion de procedimiento adm_person.genifrs_dummy.sql"
@src/gascaribe/cartera/provision/procedimientos/adm_person.genifrs_dummy.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.genifrs_dummy.sql"
@src/gascaribe/cartera/provision/sinonimos/adm_person.genifrs_dummy.sql


prompt "-----Script OSF-2795_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2795_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2795-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on

prompt "-----RECOMPILAR OBJETOS-----"
prompt "--->Aplicando recompilar objetos"
@src/test/recompilar-objetos.sql
show errors;
