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

prompt "Aplicando src/gascaribe/revision-periodica/procedimientos/ldc_procierraotvisitacerti.sql"
@src/gascaribe/revision-periodica/procedimientos/ldc_procierraotvisitacerti.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/ldc_procierraotvisitacerti.sql"
@src/gascaribe/revision-periodica/sinonimos/ldc_procierraotvisitacerti.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_temppkgestlegaorden.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_temppkgestlegaorden.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/ldci_temppkgestlegaorden.sql"
@src/gascaribe/general/integraciones/sinonimos/ldci_temppkgestlegaorden.sql

prompt "Aplicando src/gascaribe/facturacion/procedimientos/ldclmle.sql"
@src/gascaribe/facturacion/procedimientos/ldclmle.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/ldclmle.sql"
@src/gascaribe/facturacion/sinonimos/ldclmle.sql


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