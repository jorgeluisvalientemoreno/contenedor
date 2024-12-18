column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/datafix/OSF-3002_ActualizaTipoIdentificacion.sql"
@src/gascaribe/datafix/OSF-3002_ActualizaTipoIdentificacion.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3002_InsertaTablaValidacion.sql"
@src/gascaribe/datafix/OSF-3002_InsertaTablaValidacion.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2931_ActualizaNitGe_Subscriber.sql"
@src/gascaribe/datafix/OSF-2931_ActualizaNitGe_Subscriber.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/
