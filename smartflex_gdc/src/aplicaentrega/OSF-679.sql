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


prompt "Aplicando src/gascaribe/atencion-usuarios/interaccion/parametro/cod_tip_sol_per_inter.sql"
@src/gascaribe/atencion-usuarios/interaccion/parametro/cod_tip_sol_per_inter.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/interaccion/entidad/ldc_interaccion_sin_flujo.sql"
@src/gascaribe/atencion-usuarios/interaccion/entidad/ldc_interaccion_sin_flujo.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/interaccion/procedimiento/ldc_prJobinteraccionsinflujo.sql"
@src/gascaribe/atencion-usuarios/interaccion/procedimiento/ldc_prJobinteraccionsinflujo.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/interaccion/trigger/ldc_trg_interaccion.sql"
@src/gascaribe/atencion-usuarios/interaccion/trigger/ldc_trg_interaccion.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/interaccion/trigger/ldc_trg_fechaintersinflujo.sql"
@src/gascaribe/atencion-usuarios/interaccion/trigger/ldc_trg_fechaintersinflujo.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/interaccion/job/ldc_job_interaccion_sin_flujo.sql"
@src/gascaribe/atencion-usuarios/interaccion/job/ldc_job_interaccion_sin_flujo.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/interaccion/paquetes/ld_bortainteraccion.sql"
@src/gascaribe/atencion-usuarios/interaccion/paquetes/ld_bortainteraccion.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121667.sql"
@src/gascaribe/fwcob/ge_object_121667.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121696.sql"
@src/gascaribe/fwcob/ge_object_121696.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121669.sql"
@src/gascaribe/fwcob/ge_object_121669.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121710.sql"
@src/gascaribe/fwcob/ge_object_121710.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_268.sql"
@src/gascaribe/tramites/ps_package_type_268.sql

prompt "Aplicando src/gascaribe/datafix/OSF-679_ge_database_version.sql"
@src/gascaribe/datafix/OSF-679_ge_database_version.sql

prompt "Aplicando src/gascaribe/datafix/OSF-679_version.sql"
@src/gascaribe/datafix/OSF-679_version.sql

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