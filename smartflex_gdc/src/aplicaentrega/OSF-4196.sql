SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;
prompt "-----------------"
prompt "Aplicando Entrega OSF-4196"
prompt "-----------------"

prompt "-----Datafix-----" 
prompt "--->Aplicando datafix anulacion_solicitudes"
@src/gascaribe/datafix/anulacion_solicitudes.sql

prompt "--->Aplicando datafix actua_estado_productos"
@src/gascaribe/datafix/retiro_productos.sql

prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-4196-----"
prompt "-----------------------"
SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;
prompt Fin Proceso!!
SET SERVEROUTPUT OFF
QUIT
/