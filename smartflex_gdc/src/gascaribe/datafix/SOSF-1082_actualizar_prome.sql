set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/facturacion/consumos/Actualizacion/Marzo2023_promopen.sql
@src/gascaribe/facturacion/consumos/Actualizacion/Marzo2023_promopen.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/Actualizacion/Marzo2023_prompers.sql"
@src/gascaribe/facturacion/consumos/Actualizacion/Marzo2023_prompers.sql


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/