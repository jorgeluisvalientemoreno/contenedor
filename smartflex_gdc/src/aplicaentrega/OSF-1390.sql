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

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkinterfazordlec.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkinterfazordlec.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/paquetes/ldc_boencuesta.sql"
@src/gascaribe/perdidas-no-operacionales/paquetes/ldc_boencuesta.sql

prompt "Aplicando src/gascaribe/ventas/procedimientos/ldc_progenaslegcalfallotred.sql"
@src/gascaribe/ventas/procedimientos/ldc_progenaslegcalfallotred.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/procedimientos/ldc_procbajareclamojob.sql"
@src/gascaribe/atencion-usuarios/procedimientos/ldc_procbajareclamojob.sql

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