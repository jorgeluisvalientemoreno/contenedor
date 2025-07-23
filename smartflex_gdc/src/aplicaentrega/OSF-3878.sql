column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/facturacion/funciones/personalizaciones.fsbvalcontratoplanprepago.sql"
@src/gascaribe/facturacion/funciones/personalizaciones.fsbvalcontratoplanprepago.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/personalizaciones.fsbvalcontratoplanprepago.sql"
@src/gascaribe/facturacion/sinonimos/personalizaciones.fsbvalcontratoplanprepago.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/fsbnotificacontplanprepago.sql"
@src/gascaribe/facturacion/funciones/fsbnotificacontplanprepago.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/fsbnotificacontplanprepago.sql"
@src/gascaribe/facturacion/sinonimos/fsbnotificacontplanprepago.sql

prompt "Aplicando src/gascaribe/facturacion/fwcob/ge_object_121803.sql"
@ src/gascaribe/facturacion/fwcob/ge_object_121803.sql

prompt "Aplicando src/gascaribe/facturacion/notificaciones/sql/OSF-3878_notificacion.sql"
@src/gascaribe/facturacion/notificaciones/sql/OSF-3878_notificacion.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/