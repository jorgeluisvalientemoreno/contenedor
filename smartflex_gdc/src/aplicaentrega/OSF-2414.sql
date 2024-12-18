column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/general/homologacion_servicios/dald_parameter.fnugetnumeric_value.sql"
@src/gascaribe/general/homologacion_servicios/dald_parameter.fnugetnumeric_value.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/dald_parameter.fsbgetvalue_chain.sql"
@src/gascaribe/general/homologacion_servicios/dald_parameter.fsbgetvalue_chain.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/ldc_fnurettipoexce.sql"
@src/gascaribe/general/homologacion_servicios/ldc_fnurettipoexce.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/ge_boconstants.gettrue.sql"
@src/gascaribe/general/homologacion_servicios/ge_boconstants.gettrue.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/sinonimos/ldc_excep_cobro_fact.sql"
@src/gascaribe/atencion-usuarios/exencion/sinonimos/ldc_excep_cobro_fact.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/sinonimos/cc_boassignpromotion.sql"
@src/gascaribe/atencion-usuarios/exencion/sinonimos/cc_boassignpromotion.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/sinonimos/cc_promotion.sql"
@src/gascaribe/atencion-usuarios/exencion/sinonimos/cc_promotion.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/sinonimos/mo_bomotiveactionutil.sql"
@src/gascaribe/atencion-usuarios/exencion/sinonimos/mo_bomotiveactionutil.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/sinonimos/pr_promotion.sql"
@src/gascaribe/atencion-usuarios/exencion/sinonimos/pr_promotion.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/sinonimos/ps_bopacktypeparam.sql"
@src/gascaribe/atencion-usuarios/exencion/sinonimos/ps_bopacktypeparam.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/parametros/tipo_exencion_cobro_a_facturar.sql"
@src/gascaribe/atencion-usuarios/exencion/parametros/tipo_exencion_cobro_a_facturar.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/paquetes/personalizaciones.pkg_bcld_parameter.sql"
@src/gascaribe/atencion-usuarios/exencion/paquetes/personalizaciones.pkg_bcld_parameter.sql
show errors;

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/sinonimos/personalizaciones.pkg_bcld_parameter.sql"
@src/gascaribe/atencion-usuarios/exencion/sinonimos/personalizaciones.pkg_bcld_parameter.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/paquetes/adm_person.pkg_boexencion.sql"
@src/gascaribe/atencion-usuarios/exencion/paquetes/adm_person.pkg_boexencion.sql
show errors;

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/sinonimos/adm_person.pkg_boexencion.sql"
@src/gascaribe/atencion-usuarios/exencion/sinonimos/adm_person.pkg_boexencion.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/paquetes/personalizaciones.pkg_bcexencion_contribucion.sql"
@src/gascaribe/atencion-usuarios/exencion/paquetes/personalizaciones.pkg_bcexencion_contribucion.sql
show errors;

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/sinonimos/personalizaciones.pkg_bcexencion_contribucion.sql"
@src/gascaribe/atencion-usuarios/exencion/sinonimos/personalizaciones.pkg_bcexencion_contribucion.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/paquetes/personalizaciones.pkg_boexencion_contribucion.sql"
@src/gascaribe/atencion-usuarios/exencion/paquetes/personalizaciones.pkg_boexencion_contribucion.sql
show errors;

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/sinonimos/personalizaciones.pkg_boexencion_contribucion.sql"
@src/gascaribe/atencion-usuarios/exencion/sinonimos/personalizaciones.pkg_boexencion_contribucion.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/procedimientos/prcreglaasignapromocion.sql"
@src/gascaribe/atencion-usuarios/exencion/procedimientos/prcreglaasignapromocion.sql
show errors;

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/fwcob/ge_object_121761.sql"
@src/gascaribe/atencion-usuarios/exencion/fwcob/ge_object_121761.sql

prompt "Aplicando src/gascaribe/flujos/WF_UNIT_TYPE_100485.sql"
@src/gascaribe/flujos/WF_UNIT_TYPE_100485.sql

prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/
