column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO OSF-1399');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/revision-periodica/certificados/procedimientos/emirol_job_suspension_xno_cert.sql"
@src/gascaribe/revision-periodica/certificados/procedimientos/emirol_job_suspension_xno_cert.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/procedimientos/job_suspension_xno_cert_gdc.sql"
@src/gascaribe/revision-periodica/certificados/procedimientos/job_suspension_xno_cert_gdc.sql

prompt "Aplicando src/gascaribe/revision-periodica/procedimientos/ldc_proccreasolicitudnotifi.sql"
@src/gascaribe/revision-periodica/procedimientos/ldc_proccreasolicitudnotifi.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/ldc_proccreasolicitudnotifi.sql"
@src/gascaribe/revision-periodica/sinonimos/ldc_proccreasolicitudnotifi.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/procedimiento/ldc_proccreasolicitudsuspadmin.sql"
@src/gascaribe/cartera/suspensiones/procedimiento/ldc_proccreasolicitudsuspadmin.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/sinonimos/ldc_proccreasolicitudsuspadmin.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/ldc_proccreasolicitudsuspadmin.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/paquetes/ldci_pkrevisionperiodicaweb.sql"
@src/gascaribe/revision-periodica/certificados/paquetes/ldci_pkrevisionperiodicaweb.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/ldci_pkrevisionperiodicaweb.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/ldci_pkrevisionperiodicaweb.sql

prompt "Aplicando src/gascaribe/fwcob/GE_OBJECT_121136.sql"
@src/gascaribe/fwcob/GE_OBJECT_121136.sql


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