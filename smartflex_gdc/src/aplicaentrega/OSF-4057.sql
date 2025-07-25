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

prompt "Aplicando src/gascaribe/datafix/OSF-4057_anular_requisicion_con_estado_null.sql"
@src/gascaribe/datafix/OSF-4057_anular_requisicion_con_estado_null.sql

prompt "Aplicando src/gascaribe/general/materiales/tablas/ldci_transoma.sql"
@src/gascaribe/general/materiales/tablas/ldci_transoma.sql

prompt "Aplicando src/gascaribe/general/materiales/fwcea/ldci_transoma.sql"
@src/gascaribe/general/materiales/fwcea/ldci_transoma.sql

prompt "Aplicando src/gascaribe/general/materiales/proceso-negocio/proceso_negocio.materiales.sql"
@src/gascaribe/general/materiales/proceso-negocio/proceso_negocio.materiales.sql

prompt "Aplicando src/gascaribe/general/materiales/parametros/estado_pedido_enviado.sql"
@src/gascaribe/general/materiales/parametros/estado_pedido_enviado.sql

prompt "Aplicando src/gascaribe/general/materiales/parametros/estado_pedido_recibido.sql"
@src/gascaribe/general/materiales/parametros/estado_pedido_recibido.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/personalizaciones.trg_val_est_enviado_pedido.sql"
@src/gascaribe/general/materiales/triggers/personalizaciones.trg_val_est_enviado_pedido.sql

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