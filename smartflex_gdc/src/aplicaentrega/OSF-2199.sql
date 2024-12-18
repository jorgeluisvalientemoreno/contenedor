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
prompt "Aplicando Entrega OSF-2199"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/calidad-medicion/parametros/par_lega_sus_aco.sql"
@src/gascaribe/calidad-medicion/parametros/par_lega_sus_aco.sql

prompt "Aplicando src/gascaribe/calidad-medicion/parametros/par_lega_sus_cdm.sql"
@src/gascaribe/calidad-medicion/parametros/par_lega_sus_cdm.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/procedimientos/personalizaciones.prc_generasolisuspencdm.sql"
@src/gascaribe/atencion-usuarios/procedimientos/personalizaciones.prc_generasolisuspencdm.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.prc_generasolisuspencdm.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.prc_generasolisuspencdm.sql

prompt "Aplicandosrc/gascaribe/atencion-usuarios/procedimientos/prc_generasuspencdm.sql"
@src/gascaribe/atencion-usuarios/procedimientos/prc_generasuspencdm.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/procedimientos/personalizaciones.prc_generasolisuspenacom.sql"
@src/gascaribe/atencion-usuarios/procedimientos/personalizaciones.prc_generasolisuspenacom.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.prc_generasolisuspenacom.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.prc_generasolisuspenacom.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/procedimientos/prc_generasuspenacom.sql"
@src/gascaribe/atencion-usuarios/procedimientos/prc_generasuspenacom.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_ldc_logerrleorresu.sql"
@src/gascaribe/atencion-usuarios/paquetes/personalizaciones.pkg_ldc_logerrleorresu.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_ldc_logerrleorresu.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.pkg_ldc_logerrleorresu.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_order_person.sql"
@src/gascaribe/objetos-producto/sinonimos/or_order_person.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/procedimientos/personalizaciones.prc_ejecasiglegasuspcdmacom.sql"
@src/gascaribe/atencion-usuarios/procedimientos/personalizaciones.prc_ejecasiglegasuspcdmacom.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.prc_ejecasiglegasuspcdmacom.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.prc_ejecasiglegasuspcdmacom.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/procedimientos/prc_asiglegasuspcdmacom.sql"
@src/gascaribe/atencion-usuarios/procedimientos/prc_asiglegasuspcdmacom.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121757.sql"
@src/gascaribe/fwcob/ge_object_121757.sql

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