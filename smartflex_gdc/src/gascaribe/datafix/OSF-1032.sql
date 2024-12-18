column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega OSF-166"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/facturacion/consumos/Actualizacion/Febrero_promopen.sql"
@src/gascaribe/facturacion/consumos/Actualizacion/Febrero_promopen.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/Actualizacion/Febrero_prompers.sql"
@src/gascaribe/facturacion/consumos/Actualizacion/Febrero_prompers.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega"
prompt "------------------------------------------------------"


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/