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

------------- Ejecutables que no se USAN
prompt "Aplicando src/gascaribe/datafix/OSF-2886_ActSa_Executable_LODPDT.sql"
@src/gascaribe/datafix/OSF-2886_ActSa_Executable_LODPDT.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2886_ActSa_Executable_LEMADOPA.sql"
@src/gascaribe/datafix/OSF-2886_ActSa_Executable_LEMADOPA.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2886_ActSa_Executable_LDIMPMAS.sql"
@src/gascaribe/datafix/OSF-2886_ActSa_Executable_LDIMPMAS.sql

------------- Sinónimos objetos OPEN
prompt "Aplicando src/gascaribe/general/sinonimos/ge_transition_type.sql"
@src/gascaribe/general/sinonimos/ge_transition_type.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ge_process.sql"
@src/gascaribe/general/sinonimos/ge_process.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ge_priority.sql"
@src/gascaribe/general/sinonimos/ge_priority.sql

prompt "Aplicando src/gascaribe/general/sinonimos/mo_motive_asso.sql"
@src/gascaribe/general/sinonimos/mo_motive_asso.sql

prompt "Aplicando src/gascaribe/general/sinonimos/cc_prom_type.sql"
@src/gascaribe/general/sinonimos/cc_prom_type.sql

prompt "Aplicando src/gascaribe/general/sinonimos/personalizaciones.pkg_bcld_parameter.sql"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_bcld_parameter.sql

------------- Sinonimos para LEGO

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_usualego.sql"
@src/gascaribe/general/sinonimos/ldc_usualego.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_anexolegaliza.sql"
@src/gascaribe/general/sinonimos/ldc_anexolegaliza.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_tipotrabadiclego.sql"
@src/gascaribe/general/sinonimos/ldc_tipotrabadiclego.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_or_task_types_items.sql"
@src/gascaribe/general/sinonimos/ldc_or_task_types_items.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_or_task_types_materiales.sql"
@src/gascaribe/general/sinonimos/ldc_or_task_types_materiales.sql

------------- Sinonimos para SINCECOMP.VALORRECLAMO

prompt "Aplicando src/gascaribe/general/sinonimos/ps_package_areas.sql"
@src/gascaribe/general/sinonimos/ps_package_areas.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ps_bolistofvalues.sql"
@src/gascaribe/general/sinonimos/ps_bolistofvalues.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_pkvaloresreclamo.sql"
@src/gascaribe/general/sinonimos/ldc_pkvaloresreclamo.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_pkvaloresrecursosrepo.sql"
@src/gascaribe/general/sinonimos/ldc_pkvaloresrecursosrepo.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_pkrecursosreposubsape.sql"
@src/gascaribe/general/sinonimos/ldc_pkrecursosreposubsape.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ps_package_activities.sql"
@src/gascaribe/general/sinonimos/ps_package_activities.sql

prompt "Aplicando src/gascaribe/general/sinonimos/signo.sql"
@src/gascaribe/general/sinonimos/signo.sql

------------- Sinonimos para SINCECOMP.CANCELLATION.FNBIR

prompt "Aplicando src/gascaribe/general/sinonimos/ps_package_causaltyp.sql"
@src/gascaribe/general/sinonimos/ps_package_causaltyp.sql

------------- Sinonimos para SINCECOMP.FNB

prompt "Aplicando src/gascaribe/general/sinonimos/ge_civil_state.sql"
@src/gascaribe/general/sinonimos/ge_civil_state.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ge_school_degree.sql"
@src/gascaribe/general/sinonimos/ge_school_degree.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ge_house_type.sql"
@src/gascaribe/general/sinonimos/ge_house_type.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ge_geogra_loca_type.sql"
@src/gascaribe/general/sinonimos/ge_geogra_loca_type.sql

------------- Sinonimos para FDRCC 
prompt "Aplicando src/gascaribe/general/sinonimos/ldc_confplco.sql"
@src/gascaribe/general/sinonimos/ldc_confplco.sql

------------- Sinonimos para LDCGESTTA
prompt "Aplicando src/gascaribe/general/sinonimos/ta_actiperf.sql"
@src/gascaribe/general/sinonimos/ta_actiperf.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ta_actiproy.sql"
@src/gascaribe/general/sinonimos/ta_actiproy.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ta_perfusua.sql"
@src/gascaribe/general/sinonimos/ta_perfusua.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ta_tranespr.sql"
@src/gascaribe/general/sinonimos/ta_tranespr.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ta_estaproy.sql"
@src/gascaribe/general/sinonimos/ta_estaproy.sql

-------------
prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_boconstans.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boconstans.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.ld_boconstans.sql"
@src/gascaribe/general/paquetes/adm_person.ld_boconstans.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ld_boconstans.sql"
@src/gascaribe/general/sinonimos/adm_person.ld_boconstans.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2886_act_obj_mig.sql
@src/gascaribe/datafix/OSF-2886_act_obj_mig.sql

prompt "Recompilando objetos invalidos"
@src/test/recompilar-objetos.sql

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