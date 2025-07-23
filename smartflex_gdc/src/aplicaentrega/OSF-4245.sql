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

prompt "Aplicando src/gascaribe/general/materiales/triggers/personalizaciones.tgr_bi_ge_tiems_request.sql"
@src/gascaribe/general/materiales/triggers/personalizaciones.tgr_bi_ge_tiems_request.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/personalizaciones.trg_bi_ge_items_request.sql"
@src/gascaribe/general/materiales/triggers/personalizaciones.trg_bi_ge_items_request.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkreservamaterial.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkreservamaterial.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4245_borra_prefijo_ldc.sql"
@src/gascaribe/datafix/OSF-4245_borra_prefijo_ldc.sql

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