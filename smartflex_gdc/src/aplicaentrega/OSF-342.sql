column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/atencion-usuarios/reporte-sui/migrations/OSF-342.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/migrations/OSF-342.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reporte-sui/migrations/DATA_MIGRACION.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/migrations/DATA_MIGRACION.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reporte-sui/migrations/DATA_MIGRACION_1.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/migrations/DATA_MIGRACION_1.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reporte-sui/procedimiento/ldcrepanexa.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/procedimiento/ldcrepanexa.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reporte-sui/trigger/ldctrg_confirepsuia.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/trigger/ldctrg_confirepsuia.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reporte-sui/vista/ldc_sui_vista_caus_equits.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/vista/ldc_sui_vista_caus_equits.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reporte-sui/vista/ldc_sui_vista_titr_cale_sui.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/vista/ldc_sui_vista_titr_cale_sui.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reporte-sui/vista/ldc_sui_vista_titr_sui.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/vista/ldc_sui_vista_titr_sui.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reporte-sui/FWCEA/LDC_SUI_CAUS_EQU.sql"
@src/gascaribe/atencion-usuarios/reporte-sui/FWCEA/LDC_SUI_CAUS_EQU.sql

prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/