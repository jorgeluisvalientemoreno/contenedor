column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2678"
prompt "-----------------"

prompt "-----procedimiento LDC_PROVALIDAITEMLOCTIPLIS-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_provalidaitemloctiplis.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_provalidaitemloctiplis.sql


prompt "-----procedimiento LDC_VAL_EXEC_DATE_ORDERS-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_val_exec_date_orders.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_val_exec_date_orders.sql


prompt "-----procedimiento OR_BOSERVICES-----" 
prompt "--->Aplicando creacion de procedimiento adm_person.or_boservices.sql"
@src/gascaribe/gestion-ordenes/paquetes/or_boservices.sql


prompt "-----Script OSF-2678_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2678_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2678-----"
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
